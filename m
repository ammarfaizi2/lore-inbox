Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263438AbSKCWUp>; Sun, 3 Nov 2002 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSKCWUp>; Sun, 3 Nov 2002 17:20:45 -0500
Received: from mta06ps.bigpond.com ([144.135.25.138]:45818 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S263438AbSKCWUn>; Sun, 3 Nov 2002 17:20:43 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Dave Jones <davej@codemonkey.org.uk>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Petition against kernel configuration options madness...
Date: Mon, 4 Nov 2002 09:18:01 +1100
User-Agent: KMail/1.4.5
Cc: Jos Hulzink <josh@stack.nl>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103215920.GB733@suse.de>
In-Reply-To: <20021103215920.GB733@suse.de>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211040918.02414.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 4 Nov 2002 08:59, Dave Jones wrote:
> On Sun, Nov 03, 2002 at 12:52:48PM -0500, Jeff Garzik wrote:
>  > This is potentially becoming a FAQ...  I ran into this too, as did
>  > several people in the office.  People who compile custom kernels seem to
>  > run into this when they first jump into 2.5.x.  AT Keyboard support is
>  > definitely buried :/
>
> Documentation isn't enough. It _has_ to be made simpler.
> Its obvious that this is the #1 stumbling block to a 2.5 virgin right now.
> I fell over it myself when I merged it, as did Linus I believe.
> It's just not obvious enough.
This is a general merging issue. I personally didn't get affected (because USB 
only is good), but it was a big problem for 2.4.19-pre10, when HID input 
support became optional (so you can have HID for an embedded USB UPS server, 
without getting bloat).

The idea of using a kernel revisioning system is good, but things change 
between any two kernels (2.4.19-pre9 and 2.4.19-pre10 in this case).

Suggest that the kernel .config should be revisioned, and if the version 
doesn't match, make $BUILDTARGET (eg bzImage, vmlinux, modules, whatever) 
should not run. make install and make modules_install shouldn't run either.

Instead, if the version differences are minor (definition TBA), then make 
[|x|menu|old|m]config should copy the old .config to an alternative name (eg. 
.config-previous) and then for each option, we should pull from 
.config-previous, then def-config (if no entry in .config-previous), which 
we'd then have as a default. and allow the user to override.

Also note that this will NOT solve the problem described. When you move 
functionality into an existing section, which is turned off, you have to 
check every option. Consider the impact of creating a "make kernel boot" 
option three levels down in the AX.25 code. 99% of kernel builders wouidn't 
see it. Generally you only get this level of breakage in unstable series, so 
people need to rebuild their config from scratch anyway. Also, the intent of 
some options changes (consider those that no longer need any SCSI, because 
their IDE CD-RW device is now native)

Fundamentally, if you don't know how to build the configuration, this is a 
good time to learn, even if only by trial and error.

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9xaCaW6pHgIdAuOMRAiGlAJ9bHWOxXDameBdHyKhFQLfuImUmGgCgop2w
NE66gEzpN4hNzPAoR4uMTcg=
=jxzW
-----END PGP SIGNATURE-----

