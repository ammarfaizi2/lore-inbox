Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSBBWaC>; Sat, 2 Feb 2002 17:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSBBW3w>; Sat, 2 Feb 2002 17:29:52 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:43764 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP
	id <S286942AbSBBW3m>; Sat, 2 Feb 2002 17:29:42 -0500
Date: Sat, 2 Feb 2002 23:29:34 +0100 (MET)
From: Lars Christensen <larsch@cs.auc.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 agpgart process hang on crash
In-Reply-To: <E16X8Ts-0000gN-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0202022322430.367-100000@peta.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2002, Alan Cox wrote:

> > Hi. I have experienced a problem with the combination of kernel-2.4.16,
> > the kernel agpgart module and NVIDIA supplied drivers. I don't know which
> > is the cause of the problem.
> >
>
> Please report problem with the nvidia drivers loaded to nvidia. They have
> the kernel source, we do not have their source code. Only they can help
> you.

I am sorry -- my initial testing weren't throurough enough. Now, booting
to single-user, without any drivers loaded, i can reproduce the bug:

modprobe agpart   # loads fine, AMD 761 chipset found
ulimit -c unlimited   # only occurs if core file sizes are written
./testgart &
pkill -ABRT testgart  # before testgart ends

testgart AND pkill process hang. Nothing will kill them. "pkill pkill"
hangs too :)

Testgart is the one by Jeff Hartman.

Doesn't seem to be NVIDIA drivers causing this. Note, with ulimit -c 0,
testgart terminates, printing "Aborted".

-- 
Lars Christensen, larsch@cs.auc.dk

