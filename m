Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWIBGRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWIBGRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 02:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWIBGRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 02:17:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38792 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750814AbWIBGQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 02:16:59 -0400
Date: Sat, 2 Sep 2006 08:09:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
Message-ID: <20060902060939.GB16484@elte.hu>
References: <1157031054.3384.788.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >+	if (!PageUptodate(page)) {
> 
> BTW (general question), who had the idea of developing so many 
> camelcase-named VM functions?

Linus :-) It's a reminder that the HungarianNotationIsAReallyBadIdea ;)

> >+	for (i = ip->i_di.di_height; i--;)
> >+		mp->mp_list[i] = (__u16)do_div(b, sdp->sd_inptrs);
> 
> Drop the cast if possible. do_div returns an integer.

hm, do we need an explicit do_div() in fact, why not just "b / inptrs"?

> >+static inline u64 *metapointer(struct buffer_head *bh, int *boundary,
> >+			       unsigned int height, const struct metapath *mp)
> >+{
> >+	unsigned int head_size = (height > 0) ?
> >+		sizeof(struct gfs2_meta_header) : sizeof(struct gfs2_dinode);
> >+	u64 *ptr;
> >+	*boundary = 0;
> >+	ptr = ((u64 *)(bh->b_data + head_size)) + mp->mp_list[height];
> >+	if (ptr + 1 == (u64*)(bh->b_data + bh->b_size))
>                            ^
> Add a space, to go in line with the other casts.

and add a newline after variable definitions. The cast is probably not 
even needed, because b_data is void *.

> How about inverting the if() to:
> 
> 	if(ip == NULL)
> 		return;
> 	if(test_bit(GLF_DIRTY, &gl->gl_flags))
> 		gfs_inode_attr_in(ip);
> 	gfs2_meta_cache_flush(ip);

btw., it should be "if (", not "if(".

	Ingo

-- 
VGER BF report: H 0.0197994
