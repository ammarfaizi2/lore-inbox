Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWEUOC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWEUOC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWEUOC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 10:02:28 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:55201 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S964877AbWEUOC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 10:02:27 -0400
Message-ID: <024901c67cdf$1e1ce840$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Chris Wedgwood" <cw@f00f.org>, <linux-kernel@vger.kernel.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs> <20060521102642.GB5582@taniwha.stupidest.org> <44705699.3080401@yahoo.com.au>
Subject: Re: swapper: page allocation failure.
Date: Sun, 21 May 2006 15:58:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Nick Piggin" <nickpiggin@yahoo.com.au>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: "Haar J?nos" <djani22@netcenter.hu>; <linux-kernel@vger.kernel.org>
Sent: Sunday, May 21, 2006 2:01 PM
Subject: Re: swapper: page allocation failure.


> Chris Wedgwood wrote:
> > On Sun, May 21, 2006 at 11:31:12AM +0200, Haar J?nos wrote:
> >
> >
> >>[root@st-0001 /]# uname -a
> >>Linux st-0001 2.6.17-rc3-git1 #2 SMP Sun May 21 01:12:22 CEST 2006 i686
i686 i386 GNU/Linux
> >
> >
> > did earlier kernels work OK?
> >
> >
> >>This is a simple disk node.
> >>It serves the md0 array, and uses mem for buffering-caching.
> >
> >
> > odd, i looks like you've leaked alot of lowmem but i can't think why
> >
> > i've got major (induced) brain-fog right now so i'll have to think
> > about it tomorrow sorry
>
> The buffers are buffercache rather than the usual pagecache; due to
> nbd I guess. Buffercache cannot be satisfied by highmem.
>
> This would be a relatively uncommon setup, which explains why it
> isn't working 100%. I don't know of any reason why reclaim speed
> should be worse for buffercache, however one notable thing will be
> that zone_normal's lowmem reserve that is untouchable by pagecache
> will be eaten by buffercache...
>
> Anyway, increasing /proc/sys/vm/min_free_kbytes should help. Janos,
> perhaps you could try doubling it and see how you go?

I did it allready, and it looks like solves the problem.
Yesterday i have more than 6 random reboots, and after i set from 3800 to
16000 the min free limit, i have none at this point. :-)

 15:51:45 up  7:21,  1 user,  load average: 0.85, 0.79, 0.67

Anyway, i interested about cache/buffer mechanism, because i have some
performance problems too, and i can see, these systems wastes the half of
memory instead of speeds up the operation.

Thanks,
Janos

>
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com

