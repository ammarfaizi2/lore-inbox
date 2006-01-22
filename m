Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWAVVDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWAVVDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWAVVDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:03:25 -0500
Received: from thunk.org ([69.25.196.29]:39118 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751366AbWAVVDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:03:14 -0500
Date: Sun, 22 Jan 2006 13:28:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Stoffel <john@stoffel.org>
Cc: Takashi Sato <sho@tnes.nec.co.jp>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3: Extends blocksize up to pagesize
Message-ID: <20060122182801.GA7082@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Stoffel <john@stoffel.org>, Takashi Sato <sho@tnes.nec.co.jp>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp> <17358.25398.943860.755559@smtp.charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17358.25398.943860.755559@smtp.charter.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:48:06AM -0500, John Stoffel wrote:
> 
> Takashi> As a disk tends to get large, a disk storage has had a
> Takashi> capacity to supply multi-TB.  But now, ext3 can't support
> Takashi> more than 8TB filesystem when blocksize is 4KB.  That's why I
> Takashi> think ext3 needs to be more than 8TB.
> 
> Man, I don't want to even think about doing an FSCK on an 8TB
> filesystem running ext[23] at all.  
> 
> In that size range, you really need a filesystem which doesn't need an
> FSCK at all.  Not sure what the real answer is though...

Ext3 doesn't require a fsck under normal circumstances.  The only
reason why it still requires a periodic fsck after some number of
mounts is sheer paranoia about the reliability of PC class hardware.
All filesystems need some kind of filesystem consistency checker to
deal with filesystem corruptions caused by OS bugs or hardware
corruption bugs.  The only question is whether or not the filesystem
assumes at a fundamental level whether or not the hardware can be
trusted to be reliable or not.  (People have claimed that XFS is much
less robust in the face of hardware errors when compared to ext[23]; I
haven't seen a definitive study on the issue, although that tends to
correspond with my experience.  Other people would say it doesn't
matter because that's why you pay $$$$$ for am EMC Symmetrix box or an
IBM shark/DS6000/DS8000, or some other Really Expensive Storage
Hardware.)

But if you're willing to assume that your hardware is reliable and
never fails, hey, feel free to disable the periodic FSCK checking
using the command: "tune2fs -c 0 -i 0 /dev/sdXXX".

						- Ted

