Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265968AbRFZJ1e>; Tue, 26 Jun 2001 05:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265969AbRFZJ1Y>; Tue, 26 Jun 2001 05:27:24 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:22546 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S265968AbRFZJ1Q>;
	Tue, 26 Jun 2001 05:27:16 -0400
Subject: Re: [Ext2-devel] Re: [UPDATE] Directory index for ext2
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andreas Dilger <adilger@turbolinux.com>, Folkert van <f.v.heusden@ftr.nl>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>
In-Reply-To: <01062600253207.01008@starship>
In-Reply-To: <200106251951.f5PJpOYN025503@webber.adilger.int> 
	<01062600253207.01008@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 26 Jun 2001 10:27:14 +0100
Message-Id: <993547634.11781.0.camel@syntax.dera.gov.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use debugfs to remove the flag before fsck'ing:

Start debugfs.

Type

open -f -w /dev/<part>
features -FEATURE_C5

-tony


On 26 Jun 2001 00:25:32 +0200, Daniel Phillips wrote:
> On Monday 25 June 2001 21:51, Andreas Dilger wrote:
> > Daniel writes:
> > > Sure, if your root partition is expendable, by all means go ahead.  Ted
> > > has already offered to start the required changes to e2fsck, which
> > > reminds me, I have to send the promised docs.  For now, just use normal
> > > fsck and it will (in theory) turn the directory indexes back into normal
> > > file blocks, and have no effect on inodes.
> >
> > This is only true without the COMPAT_DIR_INDEX flag.  Since e2fsck _needs_
> > to know about every filesystem feature, it will (correctly) refuse to touch
> > such a system for now.  You could "tune2fs -O ^FEATURE_C4 /dev/hdX" to
> > turn of the COMPAT_DIR_INDEX flag and let e2fsck go to town.  That will
> > break all of the directory indexes, I believe.
> 
> This is what he wants, a workaround so he can fsck.  However, the above 
> command (on version 1.2-WIP) just gives me:
> 
>    Invalid filesystem option set: ^FEATURE_C4
> 
> Maybe he should just edit the source so it doesn't set the superblock flag 
> for now.
> 
> BTW, there doesn't seem to be a --version command in tune2fs.
> 


