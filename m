Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRI0E32>; Thu, 27 Sep 2001 00:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275759AbRI0E3S>; Thu, 27 Sep 2001 00:29:18 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:49908 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275758AbRI0E3J>; Thu, 27 Sep 2001 00:29:09 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 26 Sep 2001 22:29:06 -0600
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
Message-ID: <20010926222906.J1140@turbolinux.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010926101914.A28339@atrey.karlin.mff.cuni.cz> <200109270302.f8R32pl12537@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109270302.f8R32pl12537@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2001  23:02 -0400, Albert D. Cahalan wrote:
> That is totally broken, because I may mount the disk in between
> the suspend and resume. I might even:
> 
> 1. boot kernel X
> 2. suspend kernel X
> 3. boot kernel Y
> 4. suspend kernel Y
> 5. resume kernel X
> 6. suspend kernel X
> 7. resume kernel Y
> 8. suspend kernel Y
> 9. goto #5
> 
> You really have to close the logs and mark the disks clean
> when you suspend. The problems here are similar the the ones
> NFS faces. Between the suspend and resume, filesystems may be
> modified in arbitrary ways.

This is possible with the "write_super_lockfs" interface to the
journaling filesystems (ext3/reiserfs/XFS).  This is normally
used for LVM snapshots, but it could also be used for this.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

