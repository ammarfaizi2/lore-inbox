Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWIEL1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWIEL1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIEL1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:27:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:43725 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751247AbWIEL1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:27:07 -0400
Date: Tue, 5 Sep 2006 13:19:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
Message-ID: <20060905111926.GB8195@elte.hu>
References: <1157031298.3384.797.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr> <1157445854.3384.965.camel@quoit.chygwyn.com> <20060905084334.GA16788@elte.hu> <Pine.LNX.4.61.0609051111480.28583@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609051111480.28583@yvahk01.tjqt.qr>
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

> >> > >+	if ((char *)cur + cur_rec_len >= bh_end) {
> >> > >+		if ((char *)cur + cur_rec_len > bh_end) {
> >> > >+			gfs2_consist_inode(dip);
> >> > >+			return -EIO;
> >> > >+		}
> >> > >+		return -ENOENT;
> >> > >+	}
> >> > 
> >> > if((char *)cur + cur_rec_len > bh_end) {
> >> > 	gfs2_consist_inode(dip);
> >> > 	return -EIO;
> >> > } else if((char *)cur + cur_rec_len == bh_end)
> >> > 	return -ENOENT;
> >> > 
> >> ok
> >
> >this one is not OK! Firstly, Jan, and i mentioned this before, please 
> >stop using 'if(', it is highly inconsistent and against basic taste. We 
> >only use this construct for function calls (and macros), not for C 
> >statements.
> 
> Now there is no rule in CodingStyle for this yet. [...]

as i told you before, it is basic taste. Show me the CodingStyle rules 
that forbids this construct:

	if((((i+-+-+-+-+1-1))))
		var=0;;;;;;;

instead of:

	if (i)
		var = 0;

?

You will find no explicit rule in CodingStyle that explicitly forbids 
any aspect of this line, because CodingStyle mainly concentrates on the 
harder to follow rules. So please use common sense in combination with 
CodingStyle.

(And even if you dont agree with the taste, "if ( )" is done by 98% of 
core code, so for the sake of consistency it's the thing to follow.)

> 11:17 gwdg-wb04A:~/linux > grep -Pri '(if|for|while)\(' . | wc -l
> 24242
> 
> [To be honest, I also present the other number:]
> 11:17 gwdg-wb04A:~/linux > grep -Pri '(if|for|while) \(' . | wc -l
> 380895
> 
> Although a minority, it does not seem so uncommon.

What is your point?

ugly code is not at all uncommon, sadly - but i'm glad that it's only 6% 
in this particular case (and 1.9% for core kernel code).

> [...] Plus, I was wanting to show how to reorder the construct, so 
> change in whitespace between "if" and "(" is outoftopic.

it is not offtopic, because you _are_ nitpicking over style issues 
(which is OK and desirable, if not overdone), while still seeming to 
believe that "if(" is fine :-) The one who judges others is judged by 
higher standards. In other words, i'm trying to fix the guy who is 
fixing others ;-)

	Ingo
