Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSFGTNT>; Fri, 7 Jun 2002 15:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSFGTNR>; Fri, 7 Jun 2002 15:13:17 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14753 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317326AbSFGTMO>;
	Fri, 7 Jun 2002 15:12:14 -0400
Date: Fri, 7 Jun 2002 13:32:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler hints
Message-ID: <20020607113231.GA133@elf.ucw.cz>
In-Reply-To: <1023206034.912.89.camel@sinai> <3CFDC796.C05FC7E2@aitel.hist.no> <1023293838.917.283.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Seems to me this particular case is covered by increasing
> > priority when grabbing the semaphore and normalizing
> > priority when releasing.  
> > 
> > Only root can do that - but only root does real-time
> > anyway. And I guess only rood should be able to increase 
> > its timeslice too...
> 
> Increasing its priority has no bearing on whether it runs out of
> timeslice, however.  The idea here is to help the task complete its
> critical section (and thus not block other tasks) before being
> preempted.  Only way to achieve that is boost its timeslice.
> 
> Boosting its priority will assure there is no priority inversion and
> that, eventually, the task will run - but it does nothing to avoid the
> nasty "grab resource, be preempted, reschedule a bunch, finally find
> yourself running again since everyone else blocked" issue.
> 
> And I don't think only root should be able to do this.  If we later
> punish the task (take back the timeslice we gave it) then this is
> fair.

Another possibility might be to allow it to *steal* time from another
processes... Of course only processes of same UID ;-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
