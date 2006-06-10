Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWFJT1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWFJT1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWFJT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:27:36 -0400
Received: from smtpout.mac.com ([17.250.248.171]:29916 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161000AbWFJT1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:27:35 -0400
In-Reply-To: <4489C580.7080001@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com>
Cc: Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Date: Sat, 10 Jun 2006 15:27:17 -0400
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 9, 2006, at 15:01:20, Jeff Garzik wrote:
> Chase Venters wrote:
>> Now, granted, I really do agree with you about the whole code  
>> sharing thing. A fresh start is often just what you need. I'm just  
>> questioning if it wouldn't be better to do this fresh start  
>> immediately after going 48-bit, rather than before. That way,  
>> existing users that want that extra umph can have it today.
>
> Then you continue to crap up the code with
>
> 	if (48bit)
> 		...
> 	else
> 		...
>
> etc.
>
> The proper way to do this is "cp -a ext3 ext4" (excluding JBD as  
> Andrew mentioned), and then let evolution take its course.

Why not: "extX_ops.do_something_useful();", then have fs/ext/ext 
{2,3,4}_ops.c which implement those various operations just like we  
do for the Virtual Filesystem Switch?  Much as there are  
commonalities between all filesystems that get moved into the VFS;  
perhaps we should have a Virtual Ext Filesystem Switch (VEFS?  
VextFS?) which abstracts out the commonalities between the evolving  
ext{2,3} code and data format?  Such code would also provide a  
library of common routines which could be used to implement other  
specialized filesystems in the future.  Imagine a cluster-extfs which  
reuses some of the core extXfs code despite changing the on-disk  
format considerably!

Cheers,
Kyle Moffett

