Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269353AbRHGTV7>; Tue, 7 Aug 2001 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269354AbRHGTVm>; Tue, 7 Aug 2001 15:21:42 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:38787 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S269353AbRHGTVg>;
	Tue, 7 Aug 2001 15:21:36 -0400
Date: Tue, 7 Aug 2001 22:23:15 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: "'David Maynor'" <david.maynor@oit.gatech.edu>,
        <linux-kernel@vger.kernel.org>
Subject: RE: encrypted swap
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com>
Message-ID: <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now that laptop is stolen at an airport. The thief decides
> to try to improve his take by grabbing useful information
> from documents.  The encrypted documents are untouchable,
> of course.  It _doesn't matter_ that the thief has the
> hardware, the decryption key is protected by a passphrase
> which is _nowhere_ on the hard drive.
>
> The only place that sensitive, unencrypted data could be
> on such a machine is in swap.  In fact, it is _likely_ to
> be in swap.
>
> Encrypted swap solves this _particular_ problem nicely,
> does it not?

You got it bit.. wrong. Or, non-specific. If you assume that your laptop
is stolen while its powered, then encrypted swap won't help you (strings
/proc/kcore & the likes). If its going to be stolen while its offline, you
can have your shutdown scripts blank the swap partition and the boot
scripts call mkswap on it.

Or, somehow better & safer (or, explain the drawback):

spiral:~# dd if=/dev/zero of=/swap bs=1024k count=16
16+0 records in
16+0 records out
spiral:~# losetup -e DES /dev/loop0 /swap
Password:
Init (up to 16 hex digits):
spiral:~# mkswap /dev/loop0
Setting up swapspace version 1, size = 16773120 bytes
spiral:~# swapon /dev/loop0
spiral:~# cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/loop0                      partition       16376   0       -3

There, you have the swap encrypted, up and running. Of course, if you need
more fancy encryption than the default, XOR or DES, get the crypto patch.
You only need to have a script that does the stuff, that runs when the
system boots, without shutdown scripts (in case of power/battery failure
these might not be executed, hence the swap would not be wiped). Of
course, you'll need to enter the losetup password upon booting, which
might prove annoying (then again, if kernel would provide swap
encryption, the only way to make it non-decryptable would be for you to
enter a password, same drawback actually).

Cheers,
Dan.


