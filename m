Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbRAKXYa>; Thu, 11 Jan 2001 18:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131551AbRAKXYU>; Thu, 11 Jan 2001 18:24:20 -0500
Received: from jalon.able.es ([212.97.163.2]:56571 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131153AbRAKXYC>;
	Thu, 11 Jan 2001 18:24:02 -0500
Date: Fri, 12 Jan 2001 00:23:03 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
Message-ID: <20010112002303.A905@werewolf.able.es>
In-Reply-To: <UTC200101112234.XAA98877.aeb@ark.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <UTC200101112234.XAA98877.aeb@ark.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Jan 11, 2001 at 23:34:36 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.11 Andries.Brouwer@cwi.nl wrote:
> > The "none" bit puzzles me the most.
> 
> It is a common misconfiguration. Given a line
> 
>   device  dir  type  options  garbage
> 
> in /etc/fstab, some umount versions will complain "device busy"
> when the umount fails. Thus, it is better to use
> 
>   proc    /proc     proc
>   devpts  /dev/pts  devpts
> 
> instead of
> 
>   none    /proc     proc
>   none    /dev/pts  devpts
> 
> so as to avoid this silly "none busy".
> But many distributions come misconfigured like this.
> 

Same cam be applied to shm ? Thus kernel Documentation/Changes should be
changed:

System V shared memory is now implemented via a virtual filesystem.
You do not have to mount it to use it. SYSV shared memory limits are
set via /proc/sys/kernel/shm{max,all,mni}.  You should mount the
filesystem under /dev/shm to be able to use POSIX shared
memory. Adding the following line to /etc/fstab should take care of
things:

none        /dev/shm    shm     defaults    0 0

to

shm        /dev/shm    shm     defaults    0 0


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac5 #1 SMP Wed Jan 10 23:36:11 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
