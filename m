Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWDIVXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWDIVXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 17:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWDIVXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 17:23:25 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.4.205]:28719 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750816AbWDIVXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 17:23:24 -0400
Date: Sun, 09 Apr 2006 17:23:23 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: 2.6.17-rc1-mm2: badness in 3w_xxxx driver
In-reply-to: <20060409124301.44a9567c.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Mail-followup-to: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <20060409212323.GA4811@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060409182306.GA4680@nickolas.homeunix.com>
 <20060409113240.630b9a24.akpm@osdl.org>
 <20060409191256.GA4609@nickolas.homeunix.com>
 <20060409124301.44a9567c.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 12:43:01PM -0700, Andrew Morton wrote:
> Nick Orlov <bugfixer@list.ru> wrote:
> >
> > Confirmed, this patch solves the "badness" problem for me.
> 
> yup, thanks.
> 
> >  I still experiencing a weird hangs though (the box just hangs, no
> >  messages on console/syslog, nothing). I'll try to nail it down.
> > 
> >  2.6.16-mm2 works like a charm with the same config.
> >  Do you know which patches should I try to revert first?
> 
> Gee, 2.6.16-mm2 was a long time ago.
> 
> Tried sysrq?
> 
> 	echo 1 > /proc/sys/kernel/sysrq
> 	<wait for hang>
> 	ALT-SYSRQ-P or ALT-SYSRQ-T
> 
> Is the NMi watchdog enabled?  Boot with `nmi_watchdog=1', make sure that
> the NMI counts are incrementing in /proc/interrupts.
> 
> Failing all that, testing 2.6.17-rc1 would be interesting.

2.6.17-rc1 fails in the same fashion - it hangs "randomly".
Good news that I've found the pattern and solution:
it always happens when 2 applications open /dev/dsp simultaneously.

Applying the following patches published by Takashi Iwai solves the
problem:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114423578508165&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=114424198614019&w=2

Not sure if the first one is enough.

I would probably recommend to put them into the hot-fixes,
since many people can be frustrated because of this.

-- 
With best wishes,
	Nick Orlov.

