Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQKGNVp>; Tue, 7 Nov 2000 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQKGNVg>; Tue, 7 Nov 2000 08:21:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:32018 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129121AbQKGNV3>;
	Tue, 7 Nov 2000 08:21:29 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: motyl@stan.chemie.unibas.ch (Tomasz Motylewski),
        linux-kernel@vger.kernel.org
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build 
In-Reply-To: Your message of "Tue, 07 Nov 2000 12:11:57 -0000."
             <E13t7ba-0007KF-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 00:21:22 +1100
Message-ID: <13554.973603282@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 12:11:57 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Agreed, I was unhappy that the build symlink was added to 2.2 kernels.
>> Now you need modutils >= 2.3.14 for 2.2 kernels :(.  But nobody asks
>> me, I'm just the kernel module.[ch] and modutils maintainer.
>
>Actually they do. I agree that it wants sorting. Im just wondering what the
>best approach is - maybe check modutils rev and only add the link if its high
>enough ?

Against 2.2.18-pre19, only create build symlink if insmod exists and
has version >= 2.3.14.

Index: 18-pre19.1/Makefile
--- 18-pre19.1/Makefile Sat, 04 Nov 2000 21:35:33 +1100 kaos (linux-2.2/G/b/14_Makefile 1.3.2.2.1.1.1.5.1.3.6.1.5.1.1.1.1.16.1.4 644)
+++ 18-pre19.1(w)/Makefile Wed, 08 Nov 2000 00:13:19 +1100 kaos (linux-2.2/G/b/14_Makefile 1.3.2.2.1.1.1.5.1.3.6.1.5.1.1.1.1.16.1.4 644)
@@ -335,6 +335,7 @@ modules_install:
 	MODLIB=$(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE); \
 	mkdir -p $$MODLIB; \
 	rm -f $$MODLIB/build; \
+	[ `/sbin/insmod -V 2>&1 | awk '/^insmod version /{split($3, a, /\./); printf "%d%03d%03d\n", a[1], a[2], a[3];}'`0 -ge 20030140 ] && \
 	ln -s `pwd` $$MODLIB/build; \
 	cd modules; \
 	MODULES=""; \

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
