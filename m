Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVIXKfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVIXKfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 06:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVIXKfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 06:35:46 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17092 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932159AbVIXKfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 06:35:45 -0400
Date: Sat, 24 Sep 2005 12:35:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <20050924051643.GB29052@elte.hu>
Message-ID: <Pine.LNX.4.61.0509241212170.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
 <Pine.LNX.4.61.0509230151080.3743@scrub.home> <1127458197.24044.726.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0509240443440.3728@scrub.home> <20050924051643.GB29052@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Sep 2005, Ingo Molnar wrote:

> > Anyway, the biggest cost is the conversion from/to the 64bit ns value 
> > [...]
> 
> Where do you get that notion from? Have you personally measured the 
> performance and code size impact of it? If yes, would you mind to share 
> the resulting data with us?
> 
> Our data is that the use of 64-bit nsec_t significantly reduces the size 
> of a representative piece of code (object size in bytes):
> 
>                 AMD64    I386        ARM          PPC32       M68K
>    nsec_t_ops   226      284         252          428         206
>    timespec_ops 412      324         448          640         342
> 
> i.e. a ~40% size reduction when going to nsec_t on m68k, in that 
> particular function. Even larger, ~45% code size reduction on a true 
> 64-bit platform.

Without any source these numbers are not verifiable. You don't even 
mention here what that "representative piece of code" is...

Anyway, Thomas mentioned that this would be from the insert/remove code 
and here you omitted the most important part of my mail:

typedef union {
	u64 tv64;
	struct {
#ifdef __BIG_ENDIAN
		u32 sec, nsec;
#else
		u32 nsec, sec;
#endif
	} tv;
} ktimespec;

IOW this would allow to keep the time value in timespec format and use 
your nsec_t_ops for sorting.

bye, Roman
