Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277318AbRJEG3D>; Fri, 5 Oct 2001 02:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277320AbRJEG2y>; Fri, 5 Oct 2001 02:28:54 -0400
Received: from [205.178.14.190] ([205.178.14.190]:55826 "EHLO
	orca.desanasystems.com") by vger.kernel.org with ESMTP
	id <S277318AbRJEG2s>; Fri, 5 Oct 2001 02:28:48 -0400
Message-ID: <1DF71FB881F4D311A6B700C04FA06A1AB6B2F7@orca.desanasystems.com>
From: "Michailidis, Dimitrios" <dm@desanasystems.com>
To: "'kravetz@us.ibm.com'" <kravetz@us.ibm.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
Date: Thu, 4 Oct 2001 23:31:02 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe the 'quick and dirty' patches we came up with substantially
> increased context switch times for this benchmark (doubled them).
> The reason is that you needed to add IPI time to the context switch
> time.  Therefore, I did not actively pursue getting these accepted. :)
> It appears that something in the 2.2 scheduler did a much better
> job of handling this situation.  I haven't looked at the 2.2 code.
> Does anyone know what feature of the 2.2 scheduler was more successful
> in keeping tasks on the CPUs on which they previously executed?
> Also, why was that code removed from 2.4?  I can research, but I
> suspect someone here has firsthand knowledge.

The reason 2.2 does better is because under some conditions if a woken up
process's preferred CPU is busy it will refrain from moving it to another
CPU even if there are many idle CPUs, in the hope that the preferred CPU
will become available soon.  This can cause situations where processes are
sitting on the run queue while CPUs idle, but works great for lmbench.  OTOH
2.4 assigns processes to CPUs as soon as possible.  IIRC this change
happened in one of the early 2.3.4x kernels.

---
Dimitris Michailidis				 dm@desanasystems.com
