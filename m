Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269512AbRHGWdy>; Tue, 7 Aug 2001 18:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHGWdo>; Tue, 7 Aug 2001 18:33:44 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:3087 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269518AbRHGWcj>; Tue, 7 Aug 2001 18:32:39 -0400
Message-ID: <20010807234440.A2032@bug.ucw.cz>
Date: Tue, 7 Aug 2001 23:44:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dan Podeanu <pdan@spiral.extreme.ro>,
        Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: "'David Maynor'" <david.maynor@oit.gatech.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com> <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro>; from Dan Podeanu on Tue, Aug 07, 2001 at 10:23:15PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Now that laptop is stolen at an airport. The thief decides
> > to try to improve his take by grabbing useful information
> > from documents.  The encrypted documents are untouchable,
> > of course.  It _doesn't matter_ that the thief has the
> > hardware, the decryption key is protected by a passphrase
> > which is _nowhere_ on the hard drive.
> >
> > The only place that sensitive, unencrypted data could be
> > on such a machine is in swap.  In fact, it is _likely_ to
> > be in swap.
> >
> > Encrypted swap solves this _particular_ problem nicely,
> > does it not?
> 
> You got it bit.. wrong. Or, non-specific. If you assume that your laptop
> is stolen while its powered, then encrypted swap won't help you (strings
> /proc/kcore & the likes). If its going to be stolen while its offline, you
> can have your shutdown scripts blank the swap partition and the boot
> scripts call mkswap on it.
> 
> Or, somehow better & safer (or, explain the drawback):
> 
> spiral:~# dd if=/dev/zero of=/swap bs=1024k count=16
> 16+0 records in
> 16+0 records out
> spiral:~# losetup -e DES /dev/loop0 /swap
> Password:
> Init (up to 16 hex digits):
> spiral:~# mkswap /dev/loop0
> Setting up swapspace version 1, size = 16773120 bytes
> spiral:~# swapon /dev/loop0
> spiral:~# cat /proc/swaps
> Filename                        Type            Size    Used    Priority
> /dev/loop0                      partition       16376   0       -3
> 
> There, you have the swap encrypted, up and running. Of course, if
> you need

You have your swap encrypted, but I'm not sure for how long you'll see
it running before it deadlocks. Unless -e DES and loop were designed
for use with swap (were they?), this is tricky. Does anyone know if
swapping over loop is safe?

> more fancy encryption than the default, XOR or DES, get the crypto patch.
> You only need to have a script that does the stuff, that runs when the
> system boots, without shutdown scripts (in case of power/battery failure
> these might not be executed, hence the swap would not be wiped). Of
> course, you'll need to enter the losetup password upon booting, which
> might prove annoying (then again, if kernel would provide swap
> encryption, the only way to make it non-decryptable would be for you to
> enter a password, same drawback actually).

You could generate random password each boot. Should work well enough.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
