Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423108AbWJ0HDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423108AbWJ0HDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 03:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423758AbWJ0HDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 03:03:22 -0400
Received: from styx.suse.cz ([82.119.242.94]:26324 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1423108AbWJ0HDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 03:03:21 -0400
Date: Fri, 27 Oct 2006 09:03:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Andi Kleen <ak@muc.de>, Om Narasimhan <om.turyx@gmail.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, bob.picco@hp.com
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Message-ID: <20061027070319.GA24559@suse.cz>
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com> <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com> <20061027024238.GC58088@muc.de> <20061027055708.GA20270@suse.cz> <4541A758.9010504@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4541A758.9010504@kolumbus.fi>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 09:29:44AM +0300, Mika Penttilä wrote:

> >JFYI: The new per-cpu timekeeping code doesn't need the HPET legacy bit,
> >thus not replacing IRQ0 (PIT) and IRQ13 (RTC). It still can do that, but
> >will work just as well without it.

> There seems to be lot of confusion here. Current code isn't using hpet 
> as tick source if legacy is not supported. This patch adds 
> hpet_lrr_force but it's not clear how it interacts with hpet_use_timer - 
> in some places it is hpet_use_timer and some (hpet_use_timer && 
> hpet_lrr_force).

Sorry about my share of confusion introduced: Jiri Bohac
(jbohac@suse.cz) is currently working on a new timekeeping code for
x86-64 that takes a significantly different approach that allows for
precise and fast gettimeofday even on CPUs with unsynchronized TSCs.

This rewrite depends even less on hpet_use_timer than the current code.
The current code can cope with hpet_use_timer == 0, but that mode of
operation is far from optimal.

> The timer is routed to ioapic pin 2 which is irq0 with source override. 
> With this patch with hpet_lrr_force=1 timer irq is set to 2 for x86_64 
> and 0 for i386, that can't be right?
 
It doesn't seem right to me, unless someone at Sun really misread the
specification when designing the mainboard.

-- 
Vojtech Pavlik
Director SuSE Labs
