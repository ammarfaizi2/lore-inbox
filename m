Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267228AbUBSMjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267229AbUBSMjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:39:15 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:16031 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267228AbUBSMjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:39:12 -0500
Subject: Re: 2.6.3-mm1
From: Christophe Saout <christophe@saout.de>
To: Brandon Low <lostlogic@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040219003301.GE449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org> <40338FE8.60809@tmr.com>
	 <20040218200439.GB449@lostlogicx.com>
	 <20040218122216.62bb9e82.akpm@osdl.org>
	 <20040218203325.GC449@lostlogicx.com>
	 <20040218125227.0bf7dc2f.akpm@osdl.org>
	 <20040218205206.GD449@lostlogicx.com>
	 <1077142536.27450.14.camel@leto.cs.pocnet.net>
	 <20040219003301.GE449@lostlogicx.com>
Content-Type: text/plain
Message-Id: <1077194347.5970.15.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 13:39:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 19.02.2004 schrieb Brandon Low um 01:33:

> > To set up a device basically:
> > 
> > echo 0 `blockdev --getsize /dev/bla` crypt <cipher> <key> 0 /dev/bla 0 |
> > dmsetup create <newname>
> > 
> > is enough. And it's just temporary, because no special tool has been
> > written yet. dmsetup is the most low-level dm tool, mostly for
> > developers. I've written a shell script named cryptsetup for the
> > meantime, it asks for a passphrase and does all the magic you need.
> > 
> > "cryptsetup create test /dev/hda5" will ask for a passphrase and set up
> > /dev/mapper/test. Voila. "cryptsetup remove test" removes it and
> > "cryptsetup status test" shows some status information.
> > 
> What I can't figure out yet is how to do that easily for a loopback...
> use losetup first, and then cryptsetup?  I guess that's ok, just more
> steps than I would prefer.

Yes. Block->File and Block->Crypto->Block are two different things and
should be separated out. But it would be an easy one to make cryptsetup
also call losetup if your specified backend happens to be a file. Like
mount -o loop does. The only thing I'm not sure about: How would it know
when to remove the loop device on "cryptsetup remove" and when now.
mount stores it in the mtab.

I've got some free time, I think I'm going to rewrite cryptsetup as a
small C program today.

> I was under the mistaken impression that I would need lvmtools as well
> in order to use dmcrypt... cool.

Yes, there's some FUD going around...

> > There are some plans to write a unified plugin based key management
> > tool. You might want to have your key stored on a USB stick. Or
> > encrypted in the first sector of your device and you want to unlock it
> > using a password (so you can change your password without needing to
> > reencrypt your data). This would be much more flexible than most of the
> > crap floating around.
> 
> That sounds very cool, saw mention of putting it in the first part of
> the device elsethread.

Yes, for example.

> Ok ok, I'll quit panicking... this just makes it hard to decide which to
> use now as I'm preparing to deploy soon... If I use cryptoloop, it is
> now guaranteed to be obsolete soon, but if I use dmcrypt, it is more
> work right now, but more forward looking... 
> 
> Can you point me to some useful readings related to dmcrypt,
> devicemapper for loopback, etc.? Thanks!

For dm-crypt I've set up a small page:
http://www.saout.de/misc/dm-crypt/

For device-mapper and loopback there's nothing. The loop device provides
block devices, device-mapper can use them. Nothing special here.


