Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWBNHnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWBNHnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWBNHnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:43:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2789 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030344AbWBNHnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:43:33 -0500
Date: Tue, 14 Feb 2006 08:41:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
Message-ID: <20060214074151.GA29426@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home> <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602131208050.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, lets go back to this one:

* Roman Zippel <zippel@linux-m68k.org> wrote:

> Let's assume a get_time() which simply returns xtime and so has a 
> resolution of around TICK_NSEC. This means the real time when one 
> calls get_time() is somewhere between xtime and xtime+TICK_NSEC.  
> Assuming the real time is xtime+TICK_NSEC-1, get_time() will return 
> xtime and a relative timer with TICK_NSEC-1 will expire immediately.

i agree that on systems where get_time() has a TICK_NSEC resolution, 
such short timeouts are bad.

i dont agree with the fix though: it penalizes platforms where 
->get_time() resolution is sane.

	Ingo
