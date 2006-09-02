Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWIBHVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWIBHVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 03:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWIBHVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 03:21:07 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:41452 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750815AbWIBHVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 03:21:04 -0400
Date: Sat, 2 Sep 2006 09:16:56 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
In-Reply-To: <20060902060939.GB16484@elte.hu>
Message-ID: <Pine.LNX.4.61.0609020914570.24701@yvahk01.tjqt.qr>
References: <1157031054.3384.788.camel@quoit.chygwyn.com>
 <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr> <20060902060939.GB16484@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >+	for (i = ip->i_di.di_height; i--;)
>> >+		mp->mp_list[i] = (__u16)do_div(b, sdp->sd_inptrs);
>> 
>> Drop the cast if possible. do_div returns an integer.
>
>hm, do we need an explicit do_div() in fact, why not just "b / inptrs"?

b is int64 so if we just did b/inptrs, gcc would likely generate calls for 
__udivdi3. Is this udivdi3 dependency satisfied in other code (lib/...?)?

>> How about inverting the if() to:
>> 
>> 	if(ip == NULL)
>> 		return;
>> 	if(test_bit(GLF_DIRTY, &gl->gl_flags))
>> 		gfs_inode_attr_in(ip);
>> 	gfs2_meta_cache_flush(ip);
>
>btw., it should be "if (", not "if(".

There is no such rule in CodingStyle.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
