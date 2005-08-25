Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbVHYONu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbVHYONu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVHYONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:13:49 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:41865 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965011AbVHYONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:13:48 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124977672.32272.10.camel@phantasy>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 10:13:48 -0400
Message-Id: <1124979228.5039.38.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 09:47 -0400, Robert Love wrote:
> On Thu, 2005-08-25 at 09:40 -0400, John McCutchan wrote:
> 
> > I get that message a lot. I know I have said this before (and was wrong)
> > but I think the idr layer is busted.
> 
> This time I think I agree with you.  ;-)
> 
> Let's just pass zero for the "above" parameter in idr_get_new_above(),
> which is I believe the behavior of the other interface, and see if the
> 1024-multiple problem goes away.  We definitely did not have that
> before.
> 

I will test this.

> If it does, and we don't have another solution, let's run with that for
> 2.6.13.  I don't want this bug released.

I really don't want 2.6.13 to go out with this bug or the compromise. If
we use 0, we will have a lot of wd re-use. Which will cause "strange"
problems in inotify using applications that cleanup upon receipt of an
IN_IGNORE event.

The problem will manifest it self when a program does this:

inotify_add_watch "/x" returns 1
inotify_rm_watch 1
[IN_IGNORE event is queued with wd == 1]
inotify_add_watch "/y" returns 1
application reads events
cleans up data structures associated with wd == 1.

-- 
John McCutchan <ttb@tentacle.dhs.org>
