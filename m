Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291729AbSCDFco>; Mon, 4 Mar 2002 00:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291741AbSCDFce>; Mon, 4 Mar 2002 00:32:34 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:1268 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291729AbSCDFcX>;
	Mon, 4 Mar 2002 00:32:23 -0500
Date: Sun, 3 Mar 2002 22:31:03 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020303223103.J4188@lynx.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304050450.GF353@matchmail.com>; from mfedyk@matchmail.com on Sun, Mar 03, 2002 at 09:04:50PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 03, 2002  21:04 -0800, Mike Fedyk wrote:
> On Mon, Mar 04, 2002 at 03:08:54AM +0100, Daniel Phillips wrote:
> > The main disconnect there is sub-page sized writes, you will bundle together
> > young and old 1K buffers.  Since it's getting harder to find a 1K blocksize
> > filesystem, we might not care.  
> 
> Please don't do that.
> 
> Hopefully, once this is in, 1k blocks will work much better.  There are many
> cases where people work with lots of small files, and using 1k blocks is bad
> enough, 4k would be worse.
> 
> Also, with dhash going into ext2/3 lots of tiny files in one dir will be
> feasible and comparible with reiserfs.

Actually, there are a whole bunch of performance issues with 1kB block
ext2 filesystems.  For very small files, you are probably better off
to have tails in EAs stored with the inode, or with other tails/EAs in
a shared block.  We discussed this on ext2-devel a few months ago, and
while the current ext2 EA design is totally unsuitable for that, it
isn't impossible to fix.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

