Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292947AbSBQMiA>; Sun, 17 Feb 2002 07:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292948AbSBQMhu>; Sun, 17 Feb 2002 07:37:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62216 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292947AbSBQMhr>; Sun, 17 Feb 2002 07:37:47 -0500
Date: Sun, 17 Feb 2002 07:36:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: one solution to sys_sync livelock fix
In-Reply-To: <20020215181932.B5074@redhat.com>
Message-ID: <Pine.LNX.3.96.1020217072744.30060E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Stephen C. Tweedie wrote:

> On Wed, Feb 13, 2002 at 05:37:42PM -0500, Bill Davidsen wrote:
> 
> > What would happen if the sync(2) call from a non-root user were treated as
> > if it were an fsync(2) call on every file open for write?
> 
> Then you'd lose writes for files you have written to but since
> closed; and you'd seriously hurt the users of journaling filesystems
> who assume you can "sync" as an unprivileged user and then turn power
> off.

My first thought is that people who do that are going to lose data anyway
if they leave processes writing, since there is pleanty of time between
human perception of the sync ending and the actual power dropping.

And I bet in most cases they don't actually wait for it to come back, or
they would be seeing the long delays which are the symptom of livelock. I
suspect they hit ENTER and then the power switch, something not even the
current sync can help.

I can't see why people would do that anyway, shutdown only take 4-5 sec,
except on Redhat where it sings and dances for ages. I just tried a
Slackware shutdown, 4 sec from ENTER to lights out, less than the five sec
timeout on holding the power switch to force it down.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

