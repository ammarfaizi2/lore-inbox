Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVIXFQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVIXFQP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 01:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVIXFQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 01:16:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:11982 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751430AbVIXFQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 01:16:14 -0400
Date: Sat, 24 Sep 2005 07:16:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
Message-ID: <20050924051643.GB29052@elte.hu>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509201247190.3743@scrub.home> <1127342485.24044.600.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com> <Pine.LNX.4.61.0509230151080.3743@scrub.home> <1127458197.24044.726.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509240443440.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509240443440.3728@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Fri, 23 Sep 2005, Thomas Gleixner wrote:
> 
> > The idea of ktimers is to use the requested time given by a timespec in
> > human time without any corrections, so we actually can avoid the above.
> > 
> > Also doing time ordered insertion into a list introduces incompabilities
> > between 32/64 bit storage formats.
> 
> Except that the (time) range of the list would be limited I don't really 
> see a big difference.
> Anyway, the biggest cost is the conversion from/to the 64bit ns value 
> [...]

Where do you get that notion from? Have you personally measured the 
performance and code size impact of it? If yes, would you mind to share 
the resulting data with us?

Our data is that the use of 64-bit nsec_t significantly reduces the size 
of a representative piece of code (object size in bytes):

                AMD64    I386        ARM          PPC32       M68K
   nsec_t_ops   226      284         252          428         206
   timespec_ops 412      324         448          640         342

i.e. a ~40% size reduction when going to nsec_t on m68k, in that 
particular function. Even larger, ~45% code size reduction on a true 
64-bit platform.

	Ingo
