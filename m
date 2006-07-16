Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWGPR0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWGPR0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 13:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWGPR0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 13:26:23 -0400
Received: from main.gmane.org ([80.91.229.2]:39616 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750851AbWGPR0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 13:26:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <Lexington.Luthor@gmail.com>
Subject: Re: reiserFS?
Date: Sun, 16 Jul 2006 18:26:03 +0100
Message-ID: <e9dsrg$jr1$1@sea.gmane.org>
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local> <20060716165648.GB6643@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
In-Reply-To: <20060716165648.GB6643@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> If the disk is known to be bad, yes, and the number of bad blocks is
> growing.  On the other hand, disks can and will have a few bad blocks,
> or bad writes that don't mean the disk is going bad, and a modern
> filesystem should be robust enough that a single failed sector doesn't
> cause the filesystem to go completely kaput.

I never trust a single hard drive with data that cannot be instantly 
re-generated anyway (eg squid caches). The fact that some people have 
hardware errors should not require every single fs to accommodate random 
bad-sectors. Feel free to use ext3 or other fs which handles this 
situation (and other situations) better, but reiserfs works fine on good 
hardware. It has been my root filesystem on many systems with no 
problems whatsoever, even with cheap SATA drives.

> In fact, one of the scary trends with hard drives is that size is
> continuing to grow expoentially, access times linearly (more or less),
> and error rates (errors per kilobytes per unit time) are remaining
> more or less constant.
> 
> The fact that reiserfs uses a single B-tree to store all of its data
> means that very entertaining things can happen if you lose a sector
> containing a high-level node in the tree.  It's even more entertaining
> if you have image files (like initrd files) in reiserfs format stored
> in reiserfs, and you run the recovery program on the filesystem.....
> 
> Yes, I know that reiserfs4 is alleged to fix this problem, but as far
> as I know it is still using a single unitary tree, with all of the
> pitfalls that this entails.
> 
> Now, that being said, that by itself is not a reason not to decide not
> to include reseirfs4 into the mainline sources.  (I might privately
> get amused when system administrators use reiserfs and then report
> massive data loss, but that's my own failure of chairty; I'm working
> on it.)  For the technical reasons why resierfs4 hasn't been
> integrated, please see the mailing list archives.
> 

I read the archives, and most of the problems pointed out during the 
review were fixed relatively quickly, followed by a flame war due to 
some suggesting that reiser4 should not be able to affect VFS semantics, 
and other such matters (which IMO should be outside of the scope of a 
code review). There has been no follow-up review as far as I can tell. 
The discussion quickly degenerated into a personality argument against 
Mr Reiser, with several developers taking a strong position against 
reiser4 (the exact reasons for which are not specified).

I don't quite know where reiser4 stands at the moment, given that it is 
in -mm and has been for a very long time. I also looked at the patch 
again, and it is indeed quite well isolated from the rest of the kernel 
so I don't understand why it is not being merged as an EXPERIMENTAL option.

Regardless, it is available in -mm for anyone to use, and last I 
checked, works incredibly well leaving other filesystems miles behind in 
terms of speed. I haven't tested it enough to comment on the 
reliability, but if it is as reliable as reiserfs, it is sufficient for 
me and many others who use RAID and a UPS.

Regards,
LL

