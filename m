Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUHKLue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUHKLue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHKLue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:50:34 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:57076 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268030AbUHKLub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:50:31 -0400
Date: Wed, 11 Aug 2004 13:49:45 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408111149.i7BBnj6Z015053@burner.fokus.fraunhofer.de>
To: maillist@jg555.com, schilling@fokus.fraunhofer.de
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel bug report (includes fix)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jim Gifford <maillist@jg555.com>


>There is a simple fix to your problem, I have sent this patch to you a 
>few times, but never got an answer.

>I bet eveyone here will agree, this is the proper way to fix the issue

Of course, what you like to do is not the proper way....

>-DEFINCDIRS=    $(SRCROOT)/include /usr/src/linux/include
>+DEFINCDIRS=    $(SRCROOT)/include

/usr/src/linux/include is definitely needed on Linux-2.2 and before



> #if LINUX_VERSION_CODE >= 0x01031a /* <linux/scsi.h> introduced in 
>1.3.26 */
> #if LINUX_VERSION_CODE >= 0x020000 /* <scsi/scsi.h> introduced 
>somewhere. */
>+
>+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
>+    #define __KERNEL__
>+    #include <asm/types.h>
>+    #include <asm/byteorder.h>
>+    #undef __KERNEL__
>+#endif

If an application would need to #define __KERNEL__ and to include 
inofficial include files, the official include files are broken 
and should be fixed. This is exactly the reason why I send a bug report
against include/scsi/scsi.h & include/scsi/sg.h



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
