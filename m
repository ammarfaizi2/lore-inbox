Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265376AbSJRWp7>; Fri, 18 Oct 2002 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265384AbSJRWp7>; Fri, 18 Oct 2002 18:45:59 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:50422 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265376AbSJRWpW>; Fri, 18 Oct 2002 18:45:22 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 18 Oct 2002 16:48:49 -0600
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (3/3) stack overflow checking for x86
Message-ID: <20021018224849.GS14989@clusterfs.com>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <3DB08620.40004@us.ibm.com> <3DB08BD4.50607@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB08BD4.50607@us.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2002  15:31 -0700, Dave Hansen wrote:
> Greg KH just pointed out that someone else snuck in an overflow check. 
>  However, they take completely different approaches.  The Ben LaHaise 
> one that I posted uses GCC features to check the stack on entry to all 
> functions.  The one in the tree now is much, much simpler than Ben's, 
> but only works only for detecting problems at the time that an 
> interrupt actually occurs.

Yes, we had that patch in the RH 2.4 kernel, but it didn't detect the
stack overflow we spent days to track.  Our problem was just one of
a really deep stack: RPC-to-network-filesystem-on-ext3-with-htree.
This overflowed the 8kB stack even without an interrupt happening.

We fixed the htree and the network filesystem stack usage, but if we
added LVM/EVMS into the mix (which we would have in production) and
threw in a piggy interrupt handler we would possibly again overflow
an 8kB stack, so having a per-entry/exit stack checker would be great.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

