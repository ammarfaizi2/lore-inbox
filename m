Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275373AbRJCE57>; Wed, 3 Oct 2001 00:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275624AbRJCE5s>; Wed, 3 Oct 2001 00:57:48 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:7934 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275373AbRJCE5h>; Wed, 3 Oct 2001 00:57:37 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Tue, 2 Oct 2001 22:57:51 -0600
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
Message-ID: <20011002225751.A8954@turbolinux.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, lvm-devel@sistina.com
In-Reply-To: <20011002190547.A3323@cm.nu> <9pe345$8ic$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9pe345$8ic$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 03, 2001  04:10 +0000, Linus Torvalds wrote:
> In article <20011002190547.A3323@cm.nu>, Shane Wegner  <shane@cm.nu> wrote:
> >I am getting the following out of fs/buffer.c immediately
> >after bootup.  The kernel is 2.4.11-pre2 when the message
> >was added.
> >
> >Oct  2 17:35:08 continuum kernel: invalidate: busy buffer
> >Oct  2 17:35:08 continuum last message repeated 7 times
> >
> >I assume this is an error though it doesn't seem to say so. 
> 
> Well, it's an error, but it's an error in that LVM invalidates the block
> devices a bit too much, and the message really tells you that the code
> refused to invalidate stuff that must not be invalidated.
> 
> It's harmless, although I hope that the LVM people will become a bit
> less invalidation-happy as a result of the warning (it's always happened
> before, it just hasn't warned about it in earlier kernels).

Given that 2.4.10+ have devices in page cache, is there _any_ reason
why what the kernel sees on a device would be different than what user
space reads from a device?  I don't think it was ever an issue between
whole-disk-dev and partition-dev aliasing, since both user-space and
the kernel are accessing the same device.

If not, then we can just change the PV_FLUSH code to not do
invalidate_buffers() on the device for kernels 2.4.10+.  There never
was a very strong reason to do it for disk identification.

Cheers, Andreas

CC'd LVM folks to get their input on this.
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

