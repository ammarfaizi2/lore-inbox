Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUFQQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUFQQzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUFQQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:55:39 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:48912 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266574AbUFQQzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:55:35 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: Finalized FPU Crash Fix? [2.2.x]
Date: Thu, 17 Jun 2004 18:55:28 +0200
User-Agent: KMail/1.6.52
References: <20040617160856.GA1470@brevity>
In-Reply-To: <20040617160856.GA1470@brevity>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406171855.28929.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 of June 2004 18:08, Josh Myer wrote:
> Hello everybody,
>
> Is there a general concensus that the one-liner in 2.6.7 is an
> appropriate fix for the FPU hang/crash bug?  I have several machines
> running 2.4.x which require that outside people have shell access.
> Needless to say, I'm somewhat nervous about this problem =)
And how this look in 2.2.x kernels? One guy here tells me that after running 
http://linuxreviews.org/news/2004-06-11_kernel_crash/index.html#toc1the 2.2 
kernel freezes.

Is such fix right one? 2.2.x doesn't crash with it.

Index: SOURCES/kernel-fwait-2.2.patch
diff -u /dev/null SOURCES/kernel-fwait-2.2.patch:1.1
--- /dev/null   Thu Jun 17 15:34:42 2004
+++ SOURCES/kernel-fwait-2.2.patch      Thu Jun 17 15:34:36 2004
@@ -0,0 +1,10 @@
+--- linux-2.2.26/include/asm-i386/processor.h~ Thu Jun 17 17:19:57 2004
++++ linux-2.2.26/include/asm-i386/processor.h  Thu Jun 17 17:32:36 2004
+@@ -426,6 +426,7 @@
+ 
+ #define clear_fpu(tsk) do { \
+       if (tsk->flags & PF_USEDFPU) { \
++              asm volatile("fnclex ; fwait"); \
+               tsk->flags &= ~PF_USEDFPU; \
+               stts(); \
+       } \
-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
