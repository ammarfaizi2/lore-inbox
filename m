Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293553AbSBRCbD>; Sun, 17 Feb 2002 21:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293549AbSBRCax>; Sun, 17 Feb 2002 21:30:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7689 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293548AbSBRCak>; Sun, 17 Feb 2002 21:30:40 -0500
Date: Sun, 17 Feb 2002 21:29:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69FB14.167B899E@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020217212146.32237A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Andrew Morton wrote:

> Thing is, at shutdown all the tasks which are generating write
> traffic should have been killed off, and the filesystems unmounted
> or set readonly.    There's no obvious way in which this shutdown
> sequence can be indefinitely stalled by the problem we're discussing here.
> 
> If the shutdown scripts are calling sys_sync() *before* killing
> everything then yes, the scripts could hang indefinitely.  Is
> this the case?
> 
> If "yes" then the scripts are dumb.  Just remove the `sync' call.
> 
> If "no" then something else is causing the hang.

I recently had the Linux version of Cyclone (usenet transit server) get
unhappy and start growing load without bounds. At L.A. 60 I issued a
killall the the application (which ran on happily), then a killall (-9)
which also didn't kill the processes (there is a problems there, a process
shouldNOT keep running after ill -9!). There a "reboot" which hung, and
finally a "reboot -n" which actually rebooted the machine.

Since -n only means "do sync but don't wait" I have to think that the
problem is not that the script doesn't issue a kill, but that the kill
doesn't work. I think making the sync(2) a single pass write of current
dirty buffers is the only way to avoid stuff like this. making kill -9
work would be great too, there seems to be a long term problem with
threaded programs which are hard to kill.

Just another data point, the bug in this case is not in shutdown.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

