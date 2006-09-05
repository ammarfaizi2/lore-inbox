Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWIELaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWIELaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWIELaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:30:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55509 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751290AbWIELaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:30:17 -0400
Date: Tue, 5 Sep 2006 13:22:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
Message-ID: <20060905112239.GA11064@elte.hu>
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

> >Secondly, whenever we have curly braces in the first block, we tend to 
> >do it in the second block too, for easier parsing. I.e.:
> >
> >	if ((char *)cur + cur_rec_len > bh_end) {
> >		gfs2_consist_inode(dip);
> >		return -EIO;
> >	} else {
> >		if ((char *)cur + cur_rec_len == bh_end)
> >			return -ENOENT;
> >	}
> 
> I would very much like to do just this
> 
> 		many insns;
> 	} else if(...) {
> 		single insn;
> 	}

yeah, almost - what we want is:

		many insns;
	} else if (...) {
		single insn;
	}

;-)

> but again, some people think no {} should be there because it's just a 
> single insn. [...]

i used to be such a person but got converted: it makes visual sense to 
have symmetry of curly braces. So it's fine to have:

	if (...)
		single insn;
	else
		single insn;

but otherwise, if any of the blocks grows larger than 1 line, it should 
be curly braces all around.

	Ingo
