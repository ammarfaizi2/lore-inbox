Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263462AbTCNTPo>; Fri, 14 Mar 2003 14:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263447AbTCNTPo>; Fri, 14 Mar 2003 14:15:44 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:28895 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S263462AbTCNTPn>;
	Fri, 14 Mar 2003 14:15:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [Ext2-devel] Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Date: Fri, 14 Mar 2003 20:30:23 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
References: <m3el5bmyrf.fsf@lexa.home.net> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int>
In-Reply-To: <20030313165641.H12806@schatzie.adilger.int>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030314192631.8935342AF9@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Mar 03 00:56, Andreas Dilger wrote:
> There was a desire to keep ext2 small and simple, and ext3 would get the
> fancy high-end features that make sense if you have a large filesystem
> that you would likely be using in conjunction with ext3 anyways.
>
> It does make sense to test this out on ext2 since it is definitely easier
> to code for ext2 than ext3, and the journaling doesn't skew the performance
> so much.  Of course one of the reasons that ext2 is easier to code for is
> exactly _because_ we don't put all of the features into ext2...
>
> Comments on the code inline below...

Ext3 is getting to the point, or has already gotten to the point, where it's 
so reliable that it's reasonable to call it Linux's new native filesystem. At 
this point, Ext2 can become more of a crucible for new techniques, hopefully, 
techniques that simplify things, shorten up data paths, clarify the code, 
make it more parallel and so on.  For example, I can't help thinking that's 
there's some fundamental improvement possible to the truncate path (hmm, I 
wonder if I'm giving Alex new ideas...) and that proving such a thing out in 
Ext2 first would make a whole lot of sense.

I do intend to pick up the Ext2 HTree patch again in due course and attempt 
some simplification of it, as well as working on the outstanding 
optimizations, i.e., improved inode allocation and delete coalescing.  HTree 
is an example of a feature that adds a few K of code, but in my opinion it's 
worth it in order to match up better with the Ext3 feature set.  Besides, 
Ext2 is still quite attractive as a host filesystem for NFS export, and would 
be still more attractive with the directory index.

(By the way, on the HTree simplification front, there's a whole lot of 
forward declaration cruft that can go away as soon as CONFIG_EXT3_INDEX
is declared to be always on.)

So anyway, the point you were making and that I agree with, is that Ext2 is
growing into the role of experimental filesystem; Ext3 is now the stable 
filesystem.  Hopefully, the experiments will make Ext2 smaller, cleaner and 
at the same time, more powerful, over time.  Sort of like the role that RAMFS 
plays: besides being useful, Ext2 should be thought of as a showcase for best 
filesystem coding practices.

Regards,

Daniel
