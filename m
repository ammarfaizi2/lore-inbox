Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVHYODG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVHYODG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVHYODG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:03:06 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:28326 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964997AbVHYODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:03:05 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: John McCutchan <ttb@tentacle.dhs.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
In-Reply-To: <1124977807.6301.38.camel@localhost>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977807.6301.38.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 10:03:11 -0400
Message-Id: <1124978591.5039.27.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 15:50 +0200, Johannes Berg wrote:
> On Thu, 2005-08-25 at 09:40 -0400, John McCutchan wrote:
> 
> > On 2.6.13-rc7 the test program fails. It always fails when a wd == 1024.
> > If I skip inotify_rm_watch when wd == 1024, it will fail at wd == 2048.
> > It seems the idr layer has an aversion to multiples of 1024.
> > 
> > When I run your test program I get this a lot:
> 
> I forgot to mention this -- but I just get (on -rc6):
> 
> inotify_add_watch returned wd1 0
> inotify_add_watch returned wd2 1
> inotify_add_watch returned wd1 0
> inotify_add_watch returned wd2 1
> inotify_add_watch returned wd1 0
> inotify_add_watch returned wd2 1

Yeah, pre -rc7 we were always passing in 0 to idr_get_new_above. With
rc7 we pass in the last wd returned.

-- 
John McCutchan <ttb@tentacle.dhs.org>
