Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUK0C1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUK0C1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUK0CJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:09:28 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:37024 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262905AbUKZThs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:48 -0500
Subject: Re: Suspend 2 merge:L 12/51: Disable OOM killer when suspending.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125181208.GC1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101294601.5805.237.camel@desktop.cunninghams>
	 <20041125181208.GC1417@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1101419241.27250.34.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 08:47:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 05:12, Pavel Machek wrote:
> Hi!
> 
> > When preparing the image, suspend eats all the memory in sight, both to
> > reduce the image size and to improve the reliability of our stats (We've
> > worked hard to make it work reliably under heavy load - 100+). Of course
> > this can result in the OOM killer being triggered, so this simple test
> > stops that happening.
> 
> andrew's shrink_all_memory should enable you to free memory without
> hacking OOM killer, no?

I do use shrink_all_memory, but I also then allocate those pages that
were freed. We added that when seeking to get Suspend to work well and
reliably under heavy load. IIRC, the issue was that pages that were
freed were immediately getting allocated by other programs. Having said
this, it is a while since I looked at the code for preparing the image.
I can take a look and confirm my thinking.

> If shrink_all_memory is broken... fix it.

Agree.

> > +	if (test_suspend_state(SUSPEND_FREEZER_ON))
> > +		return;
> > +	
> 
> Hmm, yes, something like this migh be usefull for BUG_ONs etc...
> For consistency, right name is probably in_suspend(void).

There is a difference; there is sections of time where we're in_suspend
(test_suspend_state(SUSPEND_RUNNING)) but the freezer isn't on (initial
set up and cleanup). As far as the OOM killer goes, it probably doesn't
matter which is used, but I thought it important to point out that
freezer being on !== in_suspend(). (Freezer could also be on for S3?..
'spose you don't care of OOM killer runs then, though). Would you like
to see in_freezer()?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

