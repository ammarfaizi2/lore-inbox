Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbULaBk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbULaBk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 20:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbULaBk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 20:40:28 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:24528 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261805AbULaBkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 20:40:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rMgxmwjcJeRnl5ckVqrGrKCqSwLSLazyovfDjU+dJaVBPVPufMhdMTs0vTH4cFZ2t3p7QlJu1vYZbm64E293uj9ki8lW8oVWxLzUADDMl3ZcmxWmyB6K0Ou5+2a2Sspc6F7rFu3Tehv1mlQHFkTLgDJ3gu8+Ci28CdljvlxYtN8=
Message-ID: <2cd57c90041230174037300542@mail.gmail.com>
Date: Fri, 31 Dec 2004 09:40:19 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.10-ac2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104450153.3415.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104450153.3415.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 23:42:34 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> Forward ported from 2.6.9-ac
> o       Don't probe legacy ISA ide2,3,4,5 on PCI boxes  (Alan Cox)

Below is a cut from the 2.6.10-ac2 patch. I think since
pci_find_device() == NULL is more unlikely, please consider this patch
previousely posted on your original thread: 
http://lkml.org/lkml/2004/12/27/195


diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux.vanilla-2.6.10/include/asm-i386/ide.h
linux-2.6.10/include/asm-i386/ide.h
--- linux.vanilla-2.6.10/include/asm-i386/ide.h 2004-12-25
21:13:51.000000000 +0000
+++ linux-2.6.10/include/asm-i386/ide.h 2004-12-29 22:34:05.000000000 +0000
@@ -41,16 +41,20 @@

 static __inline__ unsigned long ide_default_io_base(int index)
 {
+       if(pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+               switch(index) {
+                       case 2: return 0x1e8;
+                       case 3: return 0x168;
+                       case 4: return 0x1e0;
+                       case 5: return 0x160;
+                       }
+       }
        switch (index) {
                case 0: return 0x1f0;
                case 1: return 0x170;
-               case 2: return 0x1e8;
-               case 3: return 0x168;
-               case 4: return 0x1e0;
-               case 5: return 0x160;
                default:
                        return 0;
-       }
+       }
 }

 #define IDE_ARCH_OBSOLETE_INIT




-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
