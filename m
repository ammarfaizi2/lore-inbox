Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280095AbRJaHYR>; Wed, 31 Oct 2001 02:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280096AbRJaHX6>; Wed, 31 Oct 2001 02:23:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:54540 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280095AbRJaHXu>;
	Wed, 31 Oct 2001 02:23:50 -0500
Subject: [PATCH][CFT] updated preempt-kernel
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 31 Oct 2001 02:24:35 -0500
Message-Id: <1004513076.1209.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Penguins Rejoice:  An updated preemptible kernel patch 

Available now at 
	http://tech9.net/rml/linux
for kernels 2.4.14-pre5, 2.4.13-ac5, 2.4.13, and 2.4.12. 

First, an optimization: we redesigned the preemption counter code to not
use atomic operators.  This non-atomicity should result in a modest
performance gain. 

Second, we have a mailing list at kpreempt-tech@lists.sourceforge.net
(see sf.net/projects/kpreempt) where we discuss technical issues and the
occasional odd-bug is reported.  Anyone with such interests is welcome. 

Third, we have ARM support (in need of much testing) by Nico Pitre! 
You will need kernel 2.4.12-ac6, Russell's ARM patch available at 
	ftp://ftp.arm.linux.org.uk/pub/armlinux/source/kernel-patches/v2.4/patch-2.4.12-ac6-rmk1.gz
the corresponding preempt-kernel patch available at 
	http://tech9.net/rml/linux/preempt-kernel-rml-2.4.12-ac6-1.patch
and finally the ARM-specific patch available at 
	ftp://ftp.arm.linux.org.uk/pub/linux/arm/people/nico/diff-2.4.12-ac6-rmk1-preempt.gz

Finally, the partial change log since the last public post: 

20011030 
- convert to non-atomic model: 
	o preempt_count is now an int 
	o memory validating is down via barrier() 
	o this removes many of the macros 
	o not using atomic ops should gain us some speed ... 
- rename preempt_is_disable to preempt_is_disabled 
- remove some extraneous ifdefs 
- compile preempt_count into the task_struct regardless of 
  whether CONFIG_PREEMPT is set.  This way the offsets do 
  not change depending on whether preemption is set. 
- rediff all the patches off one codebase to insure no ambiguities, 
  however I may introduce a typo since the trees do differ. 
- update tty race fix 

20011021 
- add a Documentation/preempt-locking.txt 
- merge fix to protect tty race on console close.  this isn't our 
  problem but preempt induces it.  will try to merge into mainline. 

Enjoy. 

	Robert Love

