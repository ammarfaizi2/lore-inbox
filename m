Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbSIZJmU>; Thu, 26 Sep 2002 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSIZJmU>; Thu, 26 Sep 2002 05:42:20 -0400
Received: from balu.gombas.hu ([195.70.35.130]:34311 "EHLO balu.cmexpress.hu")
	by vger.kernel.org with ESMTP id <S262256AbSIZJmT>;
	Thu, 26 Sep 2002 05:42:19 -0400
Date: Thu, 26 Sep 2002 11:53:03 +0200 (CEST)
From: Elek Robert <robymus@cprogramming.hu>
X-X-Sender: robymus@balu.cmexpress.hu
To: linux-kernel@vger.kernel.org
Subject: A little offtopic: uClinux on i960
Message-ID: <Pine.LNX.4.43.0209261151540.27667-100000@balu.cmexpress.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I know it's a little offtopic, but i think that the problem is based on
some structural details of linux kernel, so i hope someone will have any
idea..

--

I have a strange problem. I'm using a special own-designed hardware with
i960CF cpu, and with uClinux 2.0.35 i960 port.

previously i've changed some mail with a guy working with an i960 port,
but unfortunately i've lost his email address due to a HD crash.
If you are reading this, please answer :)

So my questions (the description of my scenario) :

the kernel seems to boot up properly, with scsi initialization (reads the
partition table well) and initrd mounting.

the problem begins with the execve syscall. in the original entry.S at
the syscall there was no flushreg, so i placed on there, to save the
register contents to memory, but it did not help..

so loading the flat binary is ok, i've dumped the memory and it seems good.
calling start_thread fills the pfp of the calling thread to a newly created
stack frame, and it seems ok too, according to the dump.

but cpu does not start to execute the code at the new IP, even if the IP is
in bios, so the code can't be altered. The curiosity is that it sometimes
works - and i don't know why. My idea is that it has something to do with
interrupt stack / supervisor stack - but i'm not sure.
But when it does not execute the code at the new IP, the CPU hangs, it does
not accept IRQ requests, nothing.

previously i had a strange error (now fixed) that bdflush hanged randomly,
depending on if the size of the gzipped kernel was odd or even (!)
i inserted a code to clear the contents of the whole memory to 0, and
now it works stable. strange for me.

Any ideas for solving the 'syscall problem' are welcome, also anything
about to previous error mentioned above could be good for me, as it
could help me understanding the cause of my problem.

Thanks in advance..

						robymus


