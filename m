Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSKKVwU>; Mon, 11 Nov 2002 16:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSKKVwT>; Mon, 11 Nov 2002 16:52:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:53986 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261418AbSKKVwT>; Mon, 11 Nov 2002 16:52:19 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: john stultz <johnstul@us.ibm.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200211112057.gABKvS620539@localhost.localdomain>
References: <200211112057.gABKvS620539@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Nov 2002 13:58:44 -0800
Message-Id: <1037051926.3844.4.camel@cornchips>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 12:57, J.E.J. Bottomley wrote:
> As a beginning, what about the attached patch?  It eliminates the compile time 
> TSC options (and thus hopefully the sources of confusion).  I've exported 
> tsc_disable, so it can be set by the subarchs if desired (voyager does this) 
> and moved the notsc option into the timer_tsc code (which is where it looks 
> like it belongs).

Looks good to me.

We'd still need to go back and yank out the #ifdef CONFIG_X86_TSC'ed 
macros in profile.h and pksched.h or replace them w/ inlines that wrap
the rdtsc calls w/ if(cpu_has_tsc && !tsc_disable) or some such line. 

But yea, its a start, assuming no one screams about not being able to
optimize out the timer_pit code.

thanks
-john

