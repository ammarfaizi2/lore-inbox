Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292680AbSBZS4w>; Tue, 26 Feb 2002 13:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293385AbSBZS4i>; Tue, 26 Feb 2002 13:56:38 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:15345 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293523AbSBZSz7>;
	Tue, 26 Feb 2002 13:55:59 -0500
Date: Tue, 26 Feb 2002 11:55:48 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226115548.N12832@lynx.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.4.44L.0202261419240.1413-100000@duckman.distro.conectiva> <20020226173822.GN4393@matchmail.com> <20020226191409.A23093@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020226191409.A23093@devcon.net>; from aferber@techfak.uni-bielefeld.de on Tue, Feb 26, 2002 at 07:14:09PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  19:14 +0100, Andreas Ferber wrote:
> On Tue, Feb 26, 2002 at 09:38:22AM -0800, Mike Fedyk wrote:
> > Basically, it would only move the files to the undelete area if the link
> > count == 1.  If you just decremented the link, then unlink() in glibc would
> > work as it does now.
> 
> Always racy if done in userspace, unless you introduce a centralised
> "unlink daemon" (hope no glibc developer reads that, they might be
> tempted to implement such an abomination...):
> 
>      proc1       proc2
>    --------------------
>     stat()
>                 stat()
>     unlink()
>                 unlink()
> 
> *kaboom*, blackhole opens, file is gone.

I had previously suggested to Mike (but he seems to have missed it) that
you should _always_ move files to the undelete area, regardless of how
many links there are.  This avoids all of the races, doesn't increase
space usage at all (because the undelete area is always in the same fs),
and is actually better for the users (because "rm <file>", "unrm <file>"
will always work even if <file> has multiple links).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

