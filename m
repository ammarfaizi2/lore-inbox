Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVCOANb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVCOANb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVCOAMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:12:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21149 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262145AbVCOAI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:08:59 -0500
Date: Tue, 15 Mar 2005 01:08:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: George Anzinger <george@mvista.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       "J. Bruce Fields" <bfields@fieldses.org>,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock error in arch/i386/kernel/time.c on APM resume
Message-ID: <20050315000612.GF9873@elf.ucw.cz>
References: <20050312131143.GA31038@fieldses.org> <4233111A.5070807@mvista.com> <Pine.LNX.4.61.0503120918130.2166@montezuma.fsmlabs.com> <42332F18.5050004@mvista.com> <20050313183549.GC1427@elf.ucw.cz> <42362301.2080804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42362301.2080804@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I agree.  Still in all that follows, no one has addressed the apparent 
> >>race described above.  The reason the system reported the errors that 
> >>started this thread is that the APM restore code was trying to read the 
> >>cmos clock (I assume to set the xtime clock) WHILE the timer interrupt 
> >>code what trying to set the cmos clock from xtime.  In other words, it is 
> >>destroying the time it is trying to read.  I repeat "Possibly the APM 
> >>code should change time_status to STA_UNSYNC on the way into the sleep."  
> >>I am not sure how ntp is supposed to react to the resume but I suspect 
> >>that the system time is rather out of sync...
> >
> >
> >It needs to work without NTP, too. You don't get NTP on plane (etc)
> >where suspend is most usefull.
> >
> >We have CMOS clock, it should be possible to get time from there
> >without resorting to NTP..
> 
> Eh... sure, but... the bug was reported because the system was attempting 
> to update the cmos clock (which it does every ~11 min.) during APM exit.   
> It does this IF AND ONLY IF the system is synced to an external source as 
> indicated by the STA_UNSYNC bit being cleared in the time_state.  Now, I 
> don't know what or how APM and NTP are supposed to play together, but I 
> suspect that on entry to APM time is no longer synced, thus my comment.
> 
> As to your comment, the bug would never have shown its ugly face if the 
> system wasn't using NTP.

Uh, ok, you are right. We should set time to STA_UNSYNC so that we do
not write back to CMOS during/shortly after resume. I did not realize
what STA_UNSYNC means. Perhaps you have patch to  do that somewhere?
;-))))
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
