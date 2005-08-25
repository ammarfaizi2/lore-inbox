Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVHYTFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVHYTFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVHYTFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:05:37 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:34170 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932511AbVHYTFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:05:34 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: george@mvista.com, Robert Love <rml@novell.com>, jim.houston@ccur.com,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124996592.19546.12.camel@localhost>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124976814.5039.4.camel@vertex>
	 <1124983117.6810.198.camel@betsy>  <430E13D8.8070005@mvista.com>
	 <1124996592.19546.12.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 15:06:17 -0400
Message-Id: <1124996777.16219.5.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 21:03 +0200, Johannes Berg wrote:
> On Thu, 2005-08-25 at 11:54 -0700, George Anzinger wrote:
> 
> > I think the best thing is to take idr into user space and emulate the 
> > problem usage.  
> 
> Good plan, I guess. Do you think that's easy?
> 
> > To this end, from the log it appears that you _might_ be 
> > moving between 0, 1 and 2 entries increasing the number each time.  It 
> > also appears that the failure happens here:
> > add 1023
> > add 1024
> > find 1024  or is it the remove that fails?  It also looks like 1024 got 
> > allocated twice.  Am I reading the log correctly?
> 
> Remove 1024 fails, but add(please make it >1024) seems to return 1024,
> and find(1024) also seems to fail. Well, remove() probably has to
> find(), but I'm not really sure what inotify does (maybe find first, to
> see if it's valid).

Just to clarify, the remove() he is talking about isn't idr_remove, it
is inotify's remove. idr_find() is failing at 1024 which causes
inotify's remove to fail.

-- 
John McCutchan <ttb@tentacle.dhs.org>
