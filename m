Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131325AbRAIOli>; Tue, 9 Jan 2001 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131315AbRAIOl2>; Tue, 9 Jan 2001 09:41:28 -0500
Received: from archimede.mat.ulaval.ca ([132.203.18.50]:55993 "EHLO
	archimede.mat.ulaval.ca") by vger.kernel.org with ESMTP
	id <S131241AbRAIOlX>; Tue, 9 Jan 2001 09:41:23 -0500
Date: Tue, 9 Jan 2001 09:41:21 -0500 (EST)
From: Mihai Moise <mcartoaj@mat.ulaval.ca>
Message-Id: <200101091441.JAA12925@taylor.mat>
To: linux-kernel@vger.kernel.org
Subject: Re: adding a system call
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What is the procedure for adding a new system call to the Linux kernel?
> 
> hack away, the code's free.  don't expect Linus to accept your 
> changes into the "real" kernel without a VERY good argument.

I know. However the Kernel Hacker's Guide writes about sys.h. After a bit of exploring, I found that sys.h has been replaced by something else in later kernels, which leaves me wondering where in the kernel I should insert my code, and where the dispatcher is located for the other system calls, in case my system call would need them.

My system call idea is to allow a superuser process to request a mmap on behalf of an user process. To see how this would be useful, let us consider svgalib.

Until now, there were two ways to allow an application access to the video array. The first was by making it setuid root, but this compromises system security by allowing it too many permissions. The second was by having a helper module which allows user applications access to the video card. However this allows any remote user to set the screen in flames.

With my new system call, a superuser process can set the graphics mode in a safe manner and then ask for an mmap of the video array into the application data segment.

Mihai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
