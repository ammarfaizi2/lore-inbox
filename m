Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVBKJjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVBKJjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVBKJjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:39:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48893 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262227AbVBKJi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:38:58 -0500
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "'George Anzinger'" <george@mvista.com>
Cc: "'William Weston'" <weston@lysdexia.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Date: Fri, 11 Feb 2005 01:38:56 -0800
Message-ID: <000501c5101d$8247b280$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20050211083408.GB3349@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, this is not in arm. Here is the patch.

Index: linux-2.6.10/include/asm-i386/spinlock.h
===================================================================
--- linux-2.6.10.orig/include/asm-i386/spinlock.h      2005-02-11 09:25:39.224240321 +0000
+++ linux-2.6.10/include/asm-i386/spinlock.h   2005-02-11 09:25:58.006812173 +0000
@@ -30,7 +30,7 @@

 #define __raw_spin_is_locked(x)        (*(volatile signed char *)(&(x)->lock) <= 0)
 #define __raw_spin_unlock_wait(x) \
-       do { barrier(); } while(__spin_is_locked(x))
+       do { barrier(); } while(__raw_spin_is_locked(x))

 #define spin_lock_string \
        "\n1:\t" \




> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ingo Molnar
> Sent: Friday, February 11, 2005 12:34 AM
> To: George Anzinger
> Cc: William Weston; linux-kernel@vger.kernel.org
> Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
> 
> 
> 
> * George Anzinger <george@mvista.com> wrote:
> 
> > Possibly from:
> > define __raw_spin_is_locked(x)	(*(volatile signed char 
> *)(&(x)->lock) <= 0)
> > #define __raw_spin_unlock_wait(x) \
> > 	do { barrier(); } while(__spin_is_locked(x))
> > in asm/spinlock.h
> > 
> > should that be __raw_spin_is_locked(x) instead?
> 
> yeah. Is this in the ARM patch? I havent applied the ARM 
> patch yet, waiting to see Thomas Gleixner's generic-hardirq 
> based one. (which is more compelling from an architectural 
> and long-term maintainance POV - but also more work to 
> address all of RMK's concerns.)
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

