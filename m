Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVJDQB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVJDQB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVJDQB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:01:59 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:10764 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S964835AbVJDQB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:01:58 -0400
Date: Tue, 4 Oct 2005 18:02:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marius Schrecker <marius@schrecker.org>
Subject: Re: it87x / buggy bios workaround
Message-Id: <20051004180202.7434ae85.khali@linux-fr.org>
In-Reply-To: <2484.81.191.59.180.1128409573.squirrel@webmail.bluecom.no>
References: <2484.81.191.59.180.1128409573.squirrel@webmail.bluecom.no>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Marius,

> I have a Biostar K8NBD-S9 motherboard with the IT8712F super i/o chip.
> 
> The board suffers from the buggy BIOS which causes the manual PWM feature
> of the chip to be unreliable to initialize.
> 
> After much googling I found this thread which indicates that Jonas Munsin
> and Jean Delvare were working on a workaround for this back in January:
> 
>  http://lkml.org/lkml/2005/1/14/94
> 
> The thread also suggests that the patch was destined for the -mm tree.
> 
> I have looked as well as I can at the 2.6.14 -mm patches, but can't see
> any reference to it87.
> 
> Currently running 2.6.13 vanilla (with some patches). The it87 driver
> seems to implement the bug testing function which Jonas and Jean were
> talking about in the 2.6.10 /2.6.11 days, but doesn't contain any
> workaround beyond disabling PWM once the problem is identified.

I already replied to Marius in private, but as he asked here too, I
think I should answer here as well if others are interested in the
solution.

The feature Marius is asking for does exist in 2.6.13 already, in the
form of the fix_pwm_polarity parameter to the it87 driver. Setting this
to 1 did work for Marius.

More generally, if you have an IT8705F or IT8712F chip and loading the
it87 driver complains about suspicious PWM polarity, here are the things
to try in order:

1* Look for a BIOS upgrade, which might fix it.

2* Try modprobe it87 fix_pwm_polarity=1 and physically ensure that the
fans still spin.

3* Experiment with manual PWM. Higher PWM values (up to 254) should make
the fan spin faster, lower PWM values should make it slower.

4* - If PWM works now, you should complain to your motherboard
manufacturer and ask them for a fixed BIOS.
- If PWM still doesn't work, this means that the motherboard was simply
not wired for PWM operations, which explains why the BIOS did not take
care of properly initializing the PWM polarity.

Hope that helps,
-- 
Jean Delvare
