Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267226AbUBSAfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUBSAfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:35:45 -0500
Received: from node-402418b2.mdw.onnet.us.uu.net ([64.36.24.178]:3576 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S267226AbUBSAfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:35:34 -0500
Date: Wed, 18 Feb 2004 18:33:01 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
Message-ID: <20040219003301.GE449@lostlogicx.com>
References: <20040217232130.61667965.akpm@osdl.org> <40338FE8.60809@tmr.com> <20040218200439.GB449@lostlogicx.com> <20040218122216.62bb9e82.akpm@osdl.org> <20040218203325.GC449@lostlogicx.com> <20040218125227.0bf7dc2f.akpm@osdl.org> <20040218205206.GD449@lostlogicx.com> <1077142536.27450.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077142536.27450.14.camel@leto.cs.pocnet.net>
X-Operating-System: Linux found.lostlogicx.com 2.6.1-mm2
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02/18/04 at 23:15:37 +0100, Christophe Saout wrote:
> Am Mi, den 18.02.2004 schrieb Brandon Low um 21:52:
> 
> > I am just reading up on dm now, but correct me if I am wrong, I will
> > need to do losetup, dmcreate, mount in that order in order to use
> > dmcrypt on loop where with cryptoloop, I could just do "mount"... there
> > must be an easier way to handle this!
> 
> You don't need to know everything about dm to set up encrypted devices.
> 
> Basically dmsetup is something like losetup, only that it's much more
> flexible.
> 
> To set up a device basically:
> 
> echo 0 `blockdev --getsize /dev/bla` crypt <cipher> <key> 0 /dev/bla 0 |
> dmsetup create <newname>
> 
> is enough. And it's just temporary, because no special tool has been
> written yet. dmsetup is the most low-level dm tool, mostly for
> developers. I've written a shell script named cryptsetup for the
> meantime, it asks for a passphrase and does all the magic you need.
> 
> "cryptsetup create test /dev/hda5" will ask for a passphrase and set up
> /dev/mapper/test. Voila. "cryptsetup remove test" removes it and
> "cryptsetup status test" shows some status information.
> 
What I can't figure out yet is how to do that easily for a loopback...
use losetup first, and then cryptsetup?  I guess that's ok, just more
steps than I would prefer.

> mount -o loop is basically a hack. mount uses parts of losetup to do an
> ioctl. The encryption support as mount argument is an additional patch.
> Even worse, some do passphrase hashing, some don't... it works but it's
> not a very clean solution either.
> 
> BTW: dmsetup is NOT a big program. It has two parts: a libdevmapper.so
> in /lib and the dmsetup binary itself. Every part is 16k in size (if
> compiled statically into one binary it's just 27k), and it's still
> linked against glibc. If linked against dietlibc or klibc it would be
> even smaller. Nobody needs LVM tools or something. It's just a small
> client for the dm ioctl, just like losetup is a client for the loop
> ioctl.
> 
I was under the mistaken impression that I would need lvmtools as well
in order to use dmcrypt... cool.

> There are some plans to write a unified plugin based key management
> tool. You might want to have your key stored on a USB stick. Or
> encrypted in the first sector of your device and you want to unlock it
> using a password (so you can change your password without needing to
> reencrypt your data). This would be much more flexible than most of the
> crap floating around.

That sounds very cool, saw mention of putting it in the first part of
the device elsethread.
> 
> So, you see. NO NEED TO PANIC. Cryptoloop won't disappear over night.
> There will be some nice to user interface. At the moment dm-crypt is
> only a *kernel implementation* and not meant to be used by every end
> user immediately. Nobody will force you to drop cryptoloop until there
> is a clean solution for everybody out there.
> 
Ok ok, I'll quit panicking... this just makes it hard to decide which to
use now as I'm preparing to deploy soon... If I use cryptoloop, it is
now guaranteed to be obsolete soon, but if I use dmcrypt, it is more
work right now, but more forward looking... 

Can you point me to some useful readings related to dmcrypt,
devicemapper for loopback, etc.? Thanks!

--Brandon
