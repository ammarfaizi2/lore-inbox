Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317849AbSFSL0z>; Wed, 19 Jun 2002 07:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317850AbSFSL0y>; Wed, 19 Jun 2002 07:26:54 -0400
Received: from [62.70.58.70] ([62.70.58.70]:21120 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317849AbSFSL0w> convert rfc822-to-8bit;
	Wed, 19 Jun 2002 07:26:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Wed, 19 Jun 2002 13:26:47 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200205241004.g4OA4Ul28364@mail.pronto.tv> <200206181326.27860.roy@karlsbakk.net> <3D0F8D40.2FC13433@zip.com.au>
In-Reply-To: <3D0F8D40.2FC13433@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206191326.47329.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roy, all we know is that "nuke-buffers stops your machine from locking up".
> But we don't know why your machine locks up in the first place.  This just
> isn't sufficient grounds to apply it!  We need to know exactly why your
> kernel is failing.  We don't know what the bug is.

The bug, as previously described, occurs when multiple (20+) clients downloads 
large files (3-6Gigs each) at a speed of ~5Mbps. The error does _not_ occur 
when a fewer number of clients are downloading at speeds close to disk speed. 
All testing is being done on gigE crossover.

> You have two gigabytes of RAM, yes?  It's very weird that stripping buffers
> prevents a lockup on a machine with such a small highmem/lowmem ratio.

No. I have 1GB - highmem (which is disabled) giving me ~900MB

> I'll have yet another shot at reproducing it.  So, again, could you please
> tell me *exactly*, in great deatail, what I need to do to reproduce this
> problem?

> - memory size

1GB - highmem

> - number of CPUs

1 Athlon 1133Mz, 256kB cache

> - IO system

standard 33MHz/32bit single peer PCI motherboard (SiS based)
on-board SiS IDE/ATA 100 controller.
promise 20269 controller
realtek 100mbps nic
e1000 gigE nic
4 IBM 40gig 120GXP drives - one on each IDE channel
data partition on RAID-0 across all drives

> - kernel version, any applied patches, compiler version
kernel 2.4.19-pre8+tux+akpm buffer patch
	I have tried _many_ different kernels, and as I needed the 20269 support, I
	chose 2.4.19-pre, Tux is there as I did some testing with that. The problem
	is _not_ tux specific, as I've tried with other server software (custom or
	standard) as well.
gcc2.95.3

> - exact sequence of commands

start http server software
start 20+ downloads. each downloaded file is 3-6 gigs
after some time most processes are killed OOM

> - anything else you can think of

I have not tried to give it coffee yet, although that might help. I'm usually 
pretty pissed if I haven't got my morning coffee

> Have you been able to reproduce the failure on any other machine?

yes. I have set up one other machine with exact same setup and one with 
slightly different setup and reproduced it.

> No, not at all.  All the pagecache is still there - the patch just
> throws away the buffer_heads which are attached to those pagecache
> pages.

oh. that's good.

> The 2.5 kernel does it tons better.  Have you tried it?

I haven't. I've tried to compile it a few times, but it has failed. And. I 
don't want to run 2.5 on a production server.

But - If you ask me to test it, I will

thanks for all help

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

