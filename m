Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSGLMFF>; Fri, 12 Jul 2002 08:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSGLMFE>; Fri, 12 Jul 2002 08:05:04 -0400
Received: from ns.suse.de ([213.95.15.193]:40713 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316088AbSGLMFE>;
	Fri, 12 Jul 2002 08:05:04 -0400
Date: Fri, 12 Jul 2002 14:07:51 +0200
From: Dave Jones <davej@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Message-ID: <20020712140751.A14671@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Daniel Phillips <phillips@arcor.de>, Jesse Barnes <jbarnes@sgi.com>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SWXm-0002BL-00@starship> <20020711180326.GH709072@sgi.com> <E17SjRh-0002VI-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17SjRh-0002VI-00@starship>; from phillips@arcor.de on Thu, Jul 11, 2002 at 09:17:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 09:17:44PM +0200, Daniel Phillips wrote:
 > On Thursday 11 July 2002 20:03, Jesse Barnes wrote:
 > > How about this?
 > 
 > It looks good, the obvious thing we don't get is what the actual lock
 > count is, and actually, we don't care because we know what it is in
 > this case.

Something I've been meaning to hack up for a while is some spinlock
debugging code that adds a FUNCTION_SLEEPS() to (ta-da) functions that
may sleep. This macro then checks whether we're currently holding any
locks, and if so printk's the names of locks held, and where they were taken.

When I came up with the idea[1] I envisioned some linked-lists frobbing,
but in more recent times, we can now check the preempt_count for a
quick-n-dirty implementation (without the additional info of which locks
we hold, lock-taker, etc).

        Dave

[1] Not an original idea, in fact I think Ingo came up with an
    implementation back in `98 or so.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
