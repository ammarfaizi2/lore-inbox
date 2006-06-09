Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWFIQzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWFIQzG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWFIQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:55:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030297AbWFIQzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:55:03 -0400
Date: Fri, 9 Jun 2006 09:54:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alex Tomas <alex@clusterfs.com>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Linus Torvalds wrote:
> 
> Just as an example: ext3 _sucks_ in many ways. It has huge inodes that 
> take up way too much space in memory.

Btw, I'm not kidding you on this one.

THE NUMBER ONE MEMORY USAGE ON A LOT OF LOADS IS EXT3 INODES IN MEMORY!

And you know what? 2TB files are totally uninteresting to 99.9999% of all 
people. Most people find it _much_ more interesting to have hundreds of 
thousands of _smaller_ files instead.

So do this:

	cat /proc/slabinfo | grep ext3

and be absolutely disgusted and horrified by the size of those inodes 
already, and ask yourself whether extending the block size to 48 bits will 
help or further hurt one of the biggest problems of ext3 right now?

(And yes, I realize that block numbers are just a small part of it. The 
"vfs_inode" is also a real problem - it's got _way_ too many large 
list-heads that explode on a 64-bit kernel, for example. Oh, well. My 
point is that things like this can make a very real issue _worse_ for all 
the people who don't care one whit about it)

		Linus
