Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWFJTL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWFJTL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWFJTL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:11:28 -0400
Received: from smtpout.mac.com ([17.250.248.172]:50908 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751683AbWFJTL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:11:26 -0400
In-Reply-To: <448992EB.5070405@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DFFC56C-2516-449F-990E-71DDE2601531@mac.com>
Cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC 0/13] extents and 48bit ext3
Date: Sat, 10 Jun 2006 15:10:30 -0400
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 9, 2006, at 11:25:31, Jeff Garzik wrote:
> Overall, I'm surprised that ext3 developers don't see any of the  
> problems related to progressive, stealth filesystem upgrades.
>
> Users are never given a clear indication of when their metadata is  
> being upgraded, there is no clear "line of demarcation" they cross,  
> when they start using extents.
>
> Since there is no user-visible fs upgrade event, users do not have  
> a clear picture of what features are being used -- which means they  
> are kept in the dark about which kernels are OK to use on their data.
>
> Do you guys honestly expect users to keep track of which kernels  
> added specific ext3 features?
>
> This is why other enterprise filesystems have clear "fs version 1",  
> "fs version 2" points across which a user migrates.  ext3's feature- 
> flags approach just means that there are a million combinations of  
> potential old-and-new features, in-tree and third party, all of  
> which must be supported.

One possible solution to the version-confusion that would avoid  
duplicating features would be to merge the fs/ext{2,3} to fs/ext,  
then make fs/ext register itself as a filesystem under "ext2",  
"ext3", and "ext4".  Then have each name imply a specific set of  
features and compatibility.  That would allow the same performance  
optimizations to affect all 3 even as you make metadata changes in  
the latest version.  I've heard quite some griping about the amount  
of duplicated code between ext2 and ext3; why cause those problems  
again with an "ext4"?  There would probably be some fs/ext/ext{2,3,4} 
_foo.c files that could be compiled in or out depending on configured  
FS support, but I would guess that would make it easier on users and  
developers alike.

Cheers,
Kyle Moffett

