Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbQKIAA6>; Wed, 8 Nov 2000 19:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbQKIAAs>; Wed, 8 Nov 2000 19:00:48 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:24816 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129171AbQKIAAj>; Wed, 8 Nov 2000 19:00:39 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Reto Baettig <baettig@scs.ch>
Cc: david <sector2@ihug.co.nz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Date: Wed, 8 Nov 2000 16:45:50 -0800 (PST)
Subject: Re: fpu now a must in kernel
In-Reply-To: <3A099F81.81FD885@scs.ch>
Message-ID: <Pine.LNX.4.21.0011081641210.9515-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the problem is that unless your code does the save/restore of the FPU
registers you will corrupt user code that does floating point.

nothing else in the kernel is supposed to use the FPU, and as a result
(almost) no user->kernek->user transitions touch the FPU and therefor the
registers don't need to be saved.

If your code needs to use them it is your code's responsibility to get a
lock (to prevent something else from interrupting you), save teh
registers, do your work, restore the registers, and release the lock

there may not be a lock, but if not then you cannot schedule/sleep during
the time you have monkeyed with the FPU.

David Lang

 On Wed, 8 Nov 2000, Reto Baettig wrote:

> Date: Wed, 08 Nov 2000 10:46:25 -0800
> From: Reto Baettig <baettig@scs.ch>
> To: david <sector2@ihug.co.nz>
> Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: Re: fpu now a must in kernel
> 
> When you add it to the task switcher, it takes away a lot of cpu cycles
> during each task switch and slows down your system. I think this was the
> main idea behind _not_ saving those registers. IMHO, it does not make
> sense to generally save these registers when nobody else but your driver
> uses them. 
> 
> Good luck!
> 
> Reto
> 
> david wrote:
> > 
> > hi i need fast fpu in the kernel for my lexos work
> > so how am i going to do it on the i386
> > 
> > 1 . can i add some save / restore code to the task swicher ( the right
> > way )
> >      so when it switchs from user to kernel task its saves the fpu state
> > ?
> > 
> > 2 . put the save / restore code in my code (NOT! GOOD! i do not wont to
> > do it this way it is not the right way)
> > 
> > so i have to use fpu in the kernel so its just how am i going to do it ?
> > 
> > thank you
> > 
> >     David Rundle <sector2@ihug.co.nz>
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
