Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWC0Wo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWC0Wo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWC0Wo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:44:29 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:55992 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751196AbWC0Wo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:44:28 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: uptime increases during suspend
Date: Tue, 28 Mar 2006 00:43:12 +0200
User-Agent: KMail/1.9.1
Cc: Jonathan Black <vampjon@gmail.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060325150238.GA9023@beacon.dhs.org> <1143484821.2168.16.camel@leatherman>
In-Reply-To: <1143484821.2168.16.camel@leatherman>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603280043.13004.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 27 March 2006 20:40, john stultz wrote:
> On Sat, 2006-03-25 at 16:02 +0100, Jonathan Black wrote:
> > I'd like to enquire about the following behaviour:
> > 
> > $ uptime && sudo hibernate && uptime
> >  14:18:51 up 1 day, 4:12,  2 users,  load average: 0.58, 3.30, 2.42
> >  14:23:46 up 1 day, 4:17,  2 users,  load average: 20.34, 7.74, 3.91
> > 
> > I.e. the system was suspended to disk for 5 minutes, but the value
> > reported by 'uptime' has increased by as much, as if it had actually
> > continued running during that time.
> 
> Yes, I don't know exactly when it was changed, but jiffies is now
> updated when we return from suspend, which causes the uptime to
> effectively increase while we are suspended.

IIRC on x86_64 jiffies has always been updated in timer_resume(),
but this did not cause uptime to behave like that until recently.

There must have been an unrelated change somewhere in the time-handling
code that made this behavior appear, but I haven't found it yet.

> [snip]
> > The way it is now, one can essentially "cheat": suspend a machine, put
> > it in the cupboard for a couple of weeks, resume it and claim a
> > respectable uptime, because the uptime value only reflects how long ago
> > the system was first booted up, with no regard to how much of that time
> > it has actually been running.
> 
> Well, anyone can hack their kernel to say whatever uptime they want, so
> I'm not to worried about cheating. Are you seeing an actual bug here?
>  
> > Would it be possible to get the old behaviour back?
> 
> Why exactly do you want this behavior? Maybe a better explanation would
> help stir this discussion.

Apparently it makes some people's setups break.

Greetings,
Rafael
