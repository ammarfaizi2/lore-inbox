Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVLBTqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVLBTqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVLBTqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:46:43 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:63410 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750988AbVLBTqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:46:42 -0500
Date: Fri, 2 Dec 2005 21:46:51 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Hugh Dickins <hugh@veritas.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Ryan Richter <ryan@tau.solarneutrino.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.61.0512021836100.4940@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.63.0512022131440.4506@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org> 
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> 
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <1133468882.5232.14.camel@mulgrave>
 <Pine.LNX.4.63.0512012304240.5777@kai.makisara.local>
 <Pine.LNX.4.61.0512021325020.1507@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0512021932590.4506@kai.makisara.local>
 <Pine.LNX.4.61.0512021836100.4940@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Hugh Dickins wrote:

> On Fri, 2 Dec 2005, Kai Makisara wrote:
> > On Fri, 2 Dec 2005, Hugh Dickins wrote:
> > I include at the end of this message the patch I sent to linux-scsi 
> > earlier. It should clarify what are the useful parts of the later patch.
> 
> Thanks, yes.  I'll leave out updating the verstr[],
> I think that should be sent by you alone.
> 
> > I think the release_buffering() call at the end of st_read must say 1. All 
> > returns use the same path (except the one returning -ERESTARTSYS).
> 
> Okay, if you insist.  Yes, all those returns pass that way, but if it
> actually did some reading into the memory, it called read_tape, which
> did the effective release_buffering immediately after st_do_scsi.
> 
> But perhaps I'm misreading it, and even if not, someone will come
> along and "correct" it later, or change things around and make my
> not-dirty assumption wrong.
> 
Your analysis is correct. It is not necessary or useful to use dirtied = 1 
at the end of st_read(). It has been a long time since I introduced 
release_buffering() into st.c and I did not read all of the code now.

> It's just that after seeing how sg.c is claiming to dirty even readonly
> memory, I'm excessively averse to saying we've dirtied memory we haven't.
> My hangup, I'll get over it!
> 
Please don't. I have a very conservative attitude to these things: my 
priority is to make sure that the data is correct even if it is not the 
fastest code. I will happily let others point out when I am too 
conservative.

-- 
Kai
