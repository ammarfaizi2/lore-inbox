Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTH0QJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTH0QI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:08:56 -0400
Received: from mail.starbak.net ([68.162.198.3]:57821 "EHLO mail.starbak.net")
	by vger.kernel.org with ESMTP id S263610AbTH0QHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:07:54 -0400
Message-ID: <028801c36cb4$c5b6a3e0$65c7a244@cage>
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "Takao Indoh" <indou.takao@soft.fujitsu.com>
Cc: "Mike Fedyk" <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: cache limit
Date: Wed, 27 Aug 2003 12:03:36 -0400
Organization: STARBAK Communications
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was premature about the test case, but still, a process (or several) that
mmap several GB's of files and dont unmap what they don't need has caused
issues in the past.

-joe

----- Original Message ----- 
From: "Joseph Malicki" <jmalicki@starbak.net>
To: "William Lee Irwin III" <wli@holomorphy.com>; "Takao Indoh"
<indou.takao@soft.fujitsu.com>
Cc: "Mike Fedyk" <mfedyk@matchmail.com>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, August 27, 2003 12:01 PM
Subject: Re: cache limit


> I've had experience with unneeded, *mapped* pages that would be ideally
> flushed oppressing needed mapped and unmapped pages.
> Test case: grep --mmap SOME_STRING_I_WONT_FIND some_multi-GB-file
>
> Sure, it's bad programming etc, but in that case, once those pages are
> mapped, they can't be forcibly unmapped even though
> in a utopian VM they would be discarded as unneeded.
>
> This could very well be the problem?
>
> -joe
>
> ----- Original Message ----- 
> From: "William Lee Irwin III" <wli@holomorphy.com>
> To: "Takao Indoh" <indou.takao@soft.fujitsu.com>
> Cc: "Mike Fedyk" <mfedyk@matchmail.com>; <linux-kernel@vger.kernel.org>
> Sent: Wednesday, August 27, 2003 5:45 AM
> Subject: Re: cache limit
>
>
> > On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
> > > This problem happened a few month ago and the detailed data does not
> > > remain. Therefore it is difficult to know what is essential cause for
> > > this problem, but, I guessed that pagecache used as I/O cache grew
> > > gradually during system running, and finally it oppressed memory.
> >
> > But this doesn't make any sense; the only memory you could "oppress"
> > is pagecache.
> >
> >
> > On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
> > > Besides this problem, there are many cases where increase of pagecache
> > > causes trouble, I think.
> > > For example, DBMS.
> > > DBMS caches index of DB in their process space.
> > > This index cache conflicts with the pagecache used by other
> applications,
> > > and index cache may be paged out. It cause uneven response of DBMS.
> > > In this case, limiting pagecache is effective.
> >
> > Why is it effective? You're describing pagecache vs. pagecache
> > competition and the DBMS outcompeting the cooperating applications for
> > memory to the detriment of the workload; this is a very different
> > scenario from what "limiting pagecache" sounds like.
> >
> > How do you know it would be effective? Have you written a patch to
> > limit it in some way and tried running it?
> >
> >
> > On Tue, 26 Aug 2003 02:46:34 -0700, William Lee Irwin III wrote:
> > >> One thing I thought of after the post was whether they actually had
in
> > >> mind tunable hard limits on _unmapped_ pagecache, which is, in fact,
> > >> useful. OTOH that's largely speculation and we really need them to
> > >> articulate the true nature of their problem.
> >
> > On Wed, Aug 27, 2003 at 06:36:10PM +0900, Takao Indoh wrote:
> > > I also think that is effective. Empirically, in the case where
pagecache
> > > causes memory shortage, most of pagecache is unmapped page. Of course
> > > real problem may not be pagecashe, as you or Mike said.
> >
> > How do you know most of it is unmapped?
> >
> > At any rate, the above assigns a meaningful definition to the words you
> > used; it does not necessarily have anything to do with the issue you're
> > trying to describe. If you could start from the very basics, reproduce
> > the problem, instrument the workload with top(1) and vmstat(1), and find
> > some way to describe how the performance is inadequate (e.g. performance
> > metrics for your running DBMS/whatever in MB/s or transactions/s etc.),
> > it would be much more helpful than proposing a solution up front.
> > Without any evidence, we can't know it is a solution at all, or that
> > it's the right solution.
> >
> >
> > -- wli
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>

