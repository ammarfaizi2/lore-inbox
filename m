Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVIMUBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVIMUBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVIMUBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:01:35 -0400
Received: from postage-due.permabit.com ([66.228.95.230]:38041 "EHLO
	postage-due.permabit.com") by vger.kernel.org with ESMTP
	id S932698AbVIMUBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:01:33 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>
	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
	<784q8qrsad.fsf@sober-counsel.permabit.com>
	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
	<788xy2qas0.fsf@sober-counsel.permabit.com>
	<20050913183948.GE14889@dmt.cnet>
	<784q8okdfn.fsf@sober-counsel.permabit.com>
	<20050913193539.GB17222@dmt.cnet>
From: Assar <assar@permabit.com>
Date: 13 Sep 2005 16:01:11 -0400
In-Reply-To: <20050913193539.GB17222@dmt.cnet>
Message-ID: <784q8oivp4.fsf@sober-counsel.permabit.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Permabit-Spam: SKIPPED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> > That's one problem.
> > 
> > > If thats the reason, you don't need the "-1" there?
> > 
> > It also writes a 0 byte.  I think it looks like this:
> > 
> > ---- ------------ -
> > len  string...    0
> 
> If an overflow happens (len > rcvbuf->page_len) the last character will get 
> truncated anyway, so there is no need for the "-1" AFAICS.

I'm not sure I follow.

The code writes a 0 at rcvbuf->pages[0][sizeof(u32) + len], right?
Doesn't that make the maximum allowed value of len should be
'rcvbuf->page_len - sizeof(u32) - 1' ?
