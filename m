Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJC3i>; Tue, 9 Jan 2001 21:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRAJC32>; Tue, 9 Jan 2001 21:29:28 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:21002 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129431AbRAJC3J>; Tue, 9 Jan 2001 21:29:09 -0500
Date: Tue, 9 Jan 2001 20:28:55 -0600
To: alan@lxorguk.ukuu.org.uk
Cc: Mike van Smoorenburg <miquels@traveler.cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre7
Message-ID: <20010109202855.C3385@cadcamlab.org>
In-Reply-To: <3A5B6437.3BC23AD3@metabyte.com> <93g39b$a9b$1@enterprise.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <93g39b$a9b$1@enterprise.cistron.net>; from miquels@traveler.cistron-office.nl on Tue, Jan 09, 2001 at 10:27:55PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Mike van Smoorenburg]
> Also calling kwhich with multiple arguments was actually the idea
> behind the script.

Yes, and that's why my optimization patch (in 2.2.19pre3, since
reverted) broke -- it relied on multiple arguments.

Alan, could you put it back in now?

Peter

--- 2.2.19-7/Makefile~	Tue Jan  9 20:20:14 2001
+++ 2.2.19-7/Makefile	Tue Jan  9 20:27:27 2001
@@ -24,12 +24,14 @@
 LD	=$(CROSS_COMPILE)ld
 #
 #	foo-bar-gcc for cross builds
-#	gcc272 for Debian's old compiler for kernels
 #	kgcc for Conectiva, Mandrake and Red Hat 7
+#	gcc272 for Debian
 #	otherwise 'cc'
 #
-CC	=$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else \
-	$(CONFIG_SHELL) scripts/kwhich gcc272 2>/dev/null || $(CONFIG_SHELL) scripts/kwhich kgcc 2>/dev/null || echo cc; fi) \
+CCFOUND :=$(shell $(CONFIG_SHELL) scripts/kwhich kgcc gcc272 cc gcc)
+## Better, but requires GNU make 3.78
+##CC	=$(if $(CROSS_COMPILE),$(CROSS_COMPILE)gcc,$(CCFOUND)) -D__KERNEL__ -I$(HPATH)
+CC	=$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else echo $(CCFOUND); fi) \
 	-D__KERNEL__ -I$(HPATH)
 CPP	=$(CC) -E
 AR	=$(CROSS_COMPILE)ar
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
