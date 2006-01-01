Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWAAL0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWAAL0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 06:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAAL0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 06:26:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12515 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751099AbWAAL0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 06:26:20 -0500
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
From: Arjan van de Ven <arjan@infradead.org>
To: Bradley Reed <bradreed1@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060101115121.034e6bb7@galactus.example.org>
References: <20051231202933.4f48acab@galactus.example.org>
	 <1136106861.17830.6.camel@laptopd505.fenrus.org>
	 <20060101115121.034e6bb7@galactus.example.org>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 12:26:12 +0100
Message-Id: <1136114772.17830.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> DO YOU REALLY PREFER USERS NOT REPORT BUGS?

It is better to not have any reports than to have "bad" bugreports (bad
in the sense that they are caused by external kernel components), that
much is obvious, since such reports cost a lot of time from the
developers, time that could better be spent on "real" bugs. Often you
can deal with 3 real bugs in the time it takes to find out that a
bugreport is really a "bad" one (because you end up looking for things
that aren't there compared to things that are there and usually are
found quicker).

So the question is, are all tainted bugreports bad bugreports. The
answer again is simple, "no, not all". However, many are. So where to
draw the line?
A rather good line is "is it reproducable without the external
components"; if it is, then it's clearly a non-bad report (and the
non-tainted reproducer means the developer even has a chance to try it
during debugging). If it's not, there is a pretty high chance that it's
a "bad" report; this from my experience of being on the receiving end of
a distros bugreporting system for a long time. If the reported can't or
can't be bothered to reproduce it, the developer spending time on it is
generally a waste of time. 

What you have here is a bit of a gray area; you're using one of the
maybe-illegal binary modules that has a really long history of
introducing bugs that, just from the oops, may appear unrelated to this
module, and you can't reproduce it without. Just not because the bug
won't happen, but because you state that the application that triggers
it won't run without it. In this case, someone else apparently reported
the same issue but without external influences, so it looks like a real
bug. But we only know that because someone else saw it, not because of
your report... 

So getting back to your question:
I would say that I think it's generally better that bugs that cannot be
reproduced on an untainted kernel are not reported on lkml, but reported
to the vendor of the tainting module instead, simply because it's very
likely that it'll waste precious debug time. (debugging isn't the most
favorite task developers do, having it be a waste of time only makes it
more so)



