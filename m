Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSI2Xid>; Sun, 29 Sep 2002 19:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSI2Xid>; Sun, 29 Sep 2002 19:38:33 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:58503 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261839AbSI2Xic>; Sun, 29 Sep 2002 19:38:32 -0400
Date: Mon, 30 Sep 2002 01:39:26 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Gerald Britton <gbritton@alum.mit.edu>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020930013926.A11768@brodo.de>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020928134739.A11797@light-brigade.mit.edu> <20020929111603.F1250@brodo.de> <20020929121018.A811@brodo.de> <20020929155648.A20308@light-brigade.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020929155648.A20308@light-brigade.mit.edu>; from gbritton@alum.mit.edu on Sun, Sep 29, 2002 at 03:56:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 03:56:48PM -0400, Gerald Britton wrote:
> On Sun, Sep 29, 2002 at 12:10:18PM +0200, Dominik Brodowski wrote:
> > I think I found the problem: it should be GFP_ATOMIC and not GFP_KERNEL in
> > the allocation of struct cpufreq_driver. Will be fixed in the next release.
> 
> Nope.  That should be fine, it's in a process context and not holding any
> locks, so GFP_KERNEL should be fine.  I found the bug though:
>  
> -driver->policy = (struct cpufreq_policy *) (driver + sizeof(struct cpufreq_driver));
> +driver->policy = (struct cpufreq_policy *) (driver + 1);
>  
> Remember your pointer arithmetic.

yes, you're right. I've just merged your patch into CVS, and I'll send a
patch to Linus really soon. 

<snip>
> [rounding] 
> There probably isn't a lot that can be done about these unfortunately, but
> they won't necessarily converge to a stable value so things may eventually
> start to fail.
Yes, that's a problem; but as cpufreq doesn't change speed dynamically yet
(and thus the number of transitions is somewhat limited) it shouldn't cause
too much trouble _yet_. But I'll try to think of a better solution _soon_.

	Dominik
