Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266109AbSKGAha>; Wed, 6 Nov 2002 19:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266239AbSKGAha>; Wed, 6 Nov 2002 19:37:30 -0500
Received: from mailc.telia.com ([194.22.190.4]:45536 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S266109AbSKGAh3>;
	Wed, 6 Nov 2002 19:37:29 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Preempt count check when leaving IRQ? (Was: Re: 2.5.44 (now 2.5.46-c929): Strange oopses triggered by .)
Date: Thu, 7 Nov 2002 01:41:09 +0100
User-Agent: KMail/1.5
References: <6C6A40E5238@vcnet.vc.cvut.cz>
In-Reply-To: <6C6A40E5238@vcnet.vc.cvut.cz>
Cc: Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200211070141.09537.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 November 2002 22.49, Petr Vandrovec wrote:
> On  6 Nov 02 at 23:09, Petr Vandrovec wrote:
> > 
> > I'm getting really nervous :-( Is kdb able to track who caused unbalanced
> > in_atomic() incrementation? 
> > 
> > After more than week of stable system I run simple 
> > "arp vanicka.vc.cvut.cz" few minutes ago, and after arp output I got 
> > sleeping function called from illegal context, quickly followed by two
> > scheduling while atomic, and finally it died because of userspace faults 
> > when in_atomic() is != 0 are treated as kernel ones...
> > 
> > As I saw nobody else reporting this or simillar problem, I'll start
> > looking at e100 driver I use. Maybe it did not occured because of I
> > was running -acX kernels since 25th Oct until yesterday. Anybody knows?
> 
> -acX use special stack for hardware IRQs, and preempt_count() is
> copied only from task -> hwirq, not other way around (because of it
> assumes that preempt_count() is same on exit as it was on enter...).
> That's probably reason why -acX was working for me almost two weeks,
> but as soon as I returned back to non-ac, it died.
>                                                     Petr Vandrovec
>                                                     vandrove@vc.cvut.cz
>                                                     

This is another CHECK to do then.

Make a copy of preempt count when entering an IRQ.
Check that we have the same value when leaving.
(using -acX we only have to add the check when leaving)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

