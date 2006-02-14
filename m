Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWBNKZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWBNKZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbWBNKZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:25:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63383
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030553AbWBNKZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:25:43 -0500
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060214074151.GA29426@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
	 <1139827927.4932.17.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602131208050.30994@scrub.home>
	 <20060214074151.GA29426@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 11:26:09 +0100
Message-Id: <1139912769.2480.529.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 08:41 +0100, Ingo Molnar wrote:
> ok, lets go back to this one:
> 
> * Roman Zippel <zippel@linux-m68k.org> wrote:
> 
> > Let's assume a get_time() which simply returns xtime and so has a 
> > resolution of around TICK_NSEC. This means the real time when one 
> > calls get_time() is somewhere between xtime and xtime+TICK_NSEC.  
> > Assuming the real time is xtime+TICK_NSEC-1, get_time() will return 
> > xtime and a relative timer with TICK_NSEC-1 will expire immediately.
> 
> i agree that on systems where get_time() has a TICK_NSEC resolution, 
> such short timeouts are bad.
> 
> i dont agree with the fix though: it penalizes platforms where 
> ->get_time() resolution is sane.

Thats true, but we have no information about get_time() resolution at
all. So the only way to work around that for now is Romans fix even if
we add the penalty to _all_ platforms.

	tglx




