Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUJRS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUJRS4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUJRSz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:55:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:6086 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267466AbUJRSvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:51:33 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: using cc-option in arch/ppc64/boot/Makefile
Date: Mon, 18 Oct 2004 13:47:55 +0000
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410141611.32198.hollisb@us.ibm.com> <20041017095700.GB16186@mars.ravnborg.org>
In-Reply-To: <20041017095700.GB16186@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410181347.55746.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 October 2004 09:57, Sam Ravnborg wrote:
> Something like this should do the trick?
> You could also include everything in your Makefile but I prefer
> Makefile.lib to make it a bit more general.

That's what I had tried. I'm having strange problems though. This patch:

--- 1.25/arch/ppc64/boot/Makefile       Sun Oct  3 12:23:50 2004
+++ edited/arch/ppc64/boot/Makefile     Mon Oct 18 14:03:40 2004
@@ -20,6 +20,8 @@
 #      CROSS32_COMPILE is setup as a prefix just like CROSS_COMPILE
 #      in the toplevel makefile.

+include scripts/Makefile.lib
+
 CROSS32_COMPILE ?=
 #CROSS32_COMPILE = /usr/local/ppc/bin/powerpc-linux-

@@ -72,7 +74,12 @@
 quiet_cmd_stripvm = STRIP $@
       cmd_stripvm = $(STRIP) -s $< -o $@

+HAS_BIARCH      := $(call cc-option-yn, -lalala)
+
 vmlinux.strip: vmlinux FORCE
+       echo $(cc-option-yn)
+       echo $(HAS_BIARCH)
+       $(call cc-option-yn, -m64)
        $(call if_changed,stripvm)
 $(obj)/vmlinux.initrd: vmlinux.strip $(obj)/addRamDisk 
$(obj)/ramdisk.image.gz FORCE
        $(call if_changed,ramdisk)

... yields the following output:

make -f scripts/Makefile.build obj=arch/ppc64/boot arch/ppc64/boot/zImage
echo y
y
echo y
y
y
make[1]: y: Command not found

Also confusing: the gcc switch "-lalala" is invalid, so I don't know where 
*any* y's came from. User error?

-- 
Hollis Blanchard
IBM Linux Technology Center
