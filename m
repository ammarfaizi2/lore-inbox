Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSIXFSZ>; Tue, 24 Sep 2002 01:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSIXFSZ>; Tue, 24 Sep 2002 01:18:25 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:42224 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261566AbSIXFSX>; Tue, 24 Sep 2002 01:18:23 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 23 Sep 2002 23:21:05 -0600
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Nanosecond resolution for stat(2)
Message-ID: <20020924052105.GV7215@clusterfs.com>
Mail-Followup-To: Mark Mielke <mark@mark.mielke.cc>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <20020923214836.GA8449@averell> <20020924040528.GA22618@pimlott.net> <20020924003502.A3226@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020924003502.A3226@mark.mielke.cc>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24, 2002  00:35 -0400, Mark Mielke wrote:
> The behaviour does seem wrong. Resolution should not be faked to be
> more accurate than the granularity offered by the underlying file
> system. Timestamps can be persistently stored, or stored for longer
> periods of times, for all sorts of reasons beyond 'make', each with
> consequence that cannot be determined here.
> 
> What would it take to get microsecond or better time stored in ext[23]?

Not very much.  We have been thinking about this for a while already.

The microsecond-resolution times would be stored in a "large inode"
or in an extended attribute if the inode is a regular-sized one.  The
latter would be a pretty big performance hit for most applications if
it were only the u-second data that were being stored in the EA space.
We are also looking at a better method of storing the EA data so that
it is more efficient than the current EA implementation, but that is
mostly tangential to your concerns.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

