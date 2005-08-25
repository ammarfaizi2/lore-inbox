Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVHYPQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVHYPQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVHYPQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:16:38 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:50860 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751129AbVHYPQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:16:38 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Robert Love <rml@novell.com>, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1124980907.19546.5.camel@localhost>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
	 <1124979228.5039.38.camel@vertex>  <1124980907.19546.5.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 11:16:39 -0400
Message-Id: <1124982999.5110.4.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:41 +0200, Johannes Berg wrote:
> On Thu, 2005-08-25 at 10:13 -0400, John McCutchan wrote:
> 
> > I really don't want 2.6.13 to go out with this bug or the compromise. If
> > we use 0, we will have a lot of wd re-use. Which will cause "strange"
> > problems in inotify using applications that cleanup upon receipt of an
> > IN_IGNORE event.
> 
> What happens when, given bug-free code that doesn't reuse, you hit the
> 8192 limit with wd, even if they're not all open at the same time? Does
> it still add them, or will inotify give an error? And does the idr layer
> handle something like that gracefully without using lots of memory?
> 

The 8192 limit is the total watches in use at one time. If over time,
you use more than 8192 watches but not all at one time you will just
keep getting higher and higher wd's. I'm not 100% sure if idr handles it
gracefully. 

> The background is that the process using this is potentially quite
> long-running and keeps opening/closing wds, so 8192 doesn't sound like a
> high barrier, after all Reuben observed hitting the 1024 limit after 15
> minutes or so.

There isn't a 1024 limit, that is a bug in the idr code. He got to that
number by having used 1024 wd's throughout the life of the program.'


FYI, if we pass 0 to idr_get_new_above, both your test programs work
fine. But the first one re-uses wd's (back and forth between 0 & 1).

-- 
John McCutchan <ttb@tentacle.dhs.org>
