Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273326AbRIXNmw>; Mon, 24 Sep 2001 09:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273413AbRIXNmm>; Mon, 24 Sep 2001 09:42:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:34291 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S273326AbRIXNmk>; Mon, 24 Sep 2001 09:42:40 -0400
Date: Mon, 24 Sep 2001 15:42:59 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
In-Reply-To: <20010923232511.B1466@athlon.random>
Message-ID: <Pine.NEB.4.40.0109241529440.27952-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2001, Andrea Arcangeli wrote:

> If you are interested about the VM behaviour under swap (and non) please
> test the 00_vm-tweaks-1 (can be applied to plain 2.4.10), here the swap
> behaviour seems improved with it. Thanks!
>...

2.4.10 seems to behave worse than kernels up to 2.4.9 and 2.4.9ac12
(haven't tried above) with the following workload (everything is only a
subjective impression as a user; I don't look at how long the "rm" and the
"tar" take because that's not very important for me):

FVWM with 6 open xterms is running
XMMS is running

mv linux linux.old
nice rm -rf linux.old &
tar xzf linux-2.4.10.tar.gz &
lynx ftp://ftp.kernel.org/pub/linux/kernel/testing


up to 2.4.9 and 2.4.9ac12:
everything works fine

2.4.10:
interactive use of the machine is very bad, I can't type a command in
another xterm

2.4.10 + 00_vm-tweaks-1:
interactive use of the machine works all right, but XMMS does sometimes
stutter


This is on a K6 with 300 Mhz. free in 2.4.10 + 00_vm-tweaks-1 gives the
following output:

$ free
             total       used       free     shared    buffers     cached
Mem:         62252      60400       1852          0       2408      32792
-/+ buffers/cache:      25200      37052
Swap:       947824      10264     937560
$


My impression is that there's a problem when several processes do heavy
non-cachable disk IO.


cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

