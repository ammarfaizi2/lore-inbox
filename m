Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283012AbRL0Xc2>; Thu, 27 Dec 2001 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283052AbRL0XcR>; Thu, 27 Dec 2001 18:32:17 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:37369 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283012AbRL0XcB>;
	Thu, 27 Dec 2001 18:32:01 -0500
Date: Thu, 27 Dec 2001 16:31:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Dave Jones <davej@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227163130.N12868@lynx.no>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011227202345.B30930@conectiva.com.br> <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>; from davej@suse.de on Thu, Dec 27, 2001 at 11:44:12PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2001  23:44 +0100, Dave Jones wrote:
> Someone with far too much time on their hands would be my personal
> hero[*] if they were to write a script (in language of their choice) to
> parse a diff, extract filename, and do lookup in a flat text file
> to find a list of maintainers/interested parties.
> 
> Imagine a patch against devfs..
> 
> $ cclist my.devfs.patch.diff
> Richard Gooch <rgooch@atnf.csiro.au>
> Alexander Viro <viro@math.psu.edu>
> 
> SCNR 8-)
> 
> This 'little black book of addresses' doesn't have to be anything
> wonderful, but its tedious work for someone to make the textfile
> mapping the various source files to email addresses.
> 
> Someone (Alan?) suggested having something like a web interface
> allowing anyone interested in any particular file to register
> their interest, and get added to the cclist for that file.
> Which is also a cool idea.

Well, in the past I had suggested to ESR (and he agreed) that it would
be nice to split up the MAINTAINERS file (and maybe even Configure.help)
to be more heirarchical in nature, so that there would be a MAINTAINER
file in each directory, and maybe even MAINTAINER.<file> for files in
common directories like drivers/net/foo.c.  In the top-level MAINTAINER
file would only be something like "Marcello Tosatti" to cover the
entire tree, and e.g. "David Miller" in the net/MAINTAINER, "Al Viro" in
the fs/MAINTAINER, "Stephen Tweedie" in fs/ext3/MAINTAINER, etc.

This way the entire tree has coverage, and if a high-level maintainer gets
email for stuff that isn't relevant to them then they create a sub-MAINTAINER
file for the things they want to delegate.  It could be possible to add a
keyword to the file which says "I have full authority for this tree and don't
include a higher-level maintainer in cclist output".  This would mean that
for people like DaveM or arch maintainers who want ALL patches to go through
them, it would not list Marcello or Linus in the cclist.  For "unmaintained"
areas (e.g. drivers) the only person listed would be the top-level maintainer,
and it would be easy for him to say "you are the first person to care about
this driver in a while, you are now the maintainer".

It might be good (for compatibility sake) to build the top-level MAINTAINERS
file from all of the sub-MAINTAINER files in the tree.

This approach doesn't have the "scalability" of the web-based subscription
model, but it _does_ have the benefit that it is kept in-sync with the tree
that it is distributed with, and it would be a simple script to determine
whom to send patches to (i.e. the proposed "cclist" script above would be
very easy to write and could be CLI only).  I would think the two are
complimentary.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

