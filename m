Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSJMWUq>; Sun, 13 Oct 2002 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSJMWUq>; Sun, 13 Oct 2002 18:20:46 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:54533 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261737AbSJMWUp>; Sun, 13 Oct 2002 18:20:45 -0400
Date: Sun, 13 Oct 2002 23:26:36 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: mikpe@csd.uu.se
Subject: Re: kernel api for application profiling
Message-ID: <20021013222636.GA2289@compsoc.man.ac.uk>
References: <200210132217.AAA07121@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210132217.AAA07121@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 12:17:23AM +0200, Mikael Pettersson wrote:

> The HW resources in question are the local APIC LVTPC entry
> and the performance counter MSRs. Agreed?

Right.

> The NMI watchdog can either be special-cased so that the resource
> manager knows that it is a low-priority default owner of the HW,
> or we can try to encode this in the interface to the manager, using
> callbacks like "are you willing to release the HW?" and results
> like "yes, but please call this FUNC when you're done with the HW".

I've been thinking along the exact same lines. I even started to
implement something like this originally, but ended up doing a simpler
save/restore thing in oprofile. It would be fairly easy to implement,
the biggest difficulty being the hand-off of the power management
routines and the NMI handler where appropriate.

I agree that it doesn't make sense to split up the resources (though at
some point I'd like to maintain the watchdog functionality even with
oprofile running). In fact, for now, I think the simple exclusive CONFIG
solution is the simplest - the things don't get on together, after all.

regards
john
-- 
"That's just kitten-eating wrong."
	- Richard Henderson
