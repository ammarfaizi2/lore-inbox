Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbUDLUPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUDLUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:15:36 -0400
Received: from pD9E57A79.dip.t-dialin.net ([217.229.122.121]:6923 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263037AbUDLUPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:15:34 -0400
Date: Mon, 12 Apr 2004 20:08:36 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, paulus@au.ibm.com, benh@kernel.crashing.org,
       jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
       wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [1/3]
Message-ID: <20040412200835.A5625@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
	rth@twiddle.net, spyro@f2s.com, rmk@arm.linux.org.uk,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org> <20040412075704.B5198@Marvin.DL8BCU.ampr.org> <16506.50767.128817.828166@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <16506.50767.128817.828166@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, Apr 12, 2004 at 09:39:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 09:39:43AM -0700, David Mosberger wrote:
> >>>>> On Mon, 12 Apr 2004 07:57:05 +0000, Thorsten Kranzkowski <dl8bcu@dl8bcu.de> said:
> 
>   Thorsten> Introducing PIC_TIC_RATE.
> 
> What's this meant for?  At least for IA-64, there is zero guarantee
> that there will be a timer ticking at this rate.  There are some
> machines where this is the case (the ones using Intel chipsets, I
> believe), but it isn't true for most machines with non-Intel chipsets
> (which are common).

This is the base frequency of the programmable interrupt timer/counter 
(originally a 8253 I think) that on some architectures serves as the 
system timer but on even more architectures drives the system speaker
with it's 3rd timer.

There are these lines in the pcspkr.c (and the other *spkr.c):

        if (value > 20 && value < 32767)
                count = PIC_TICK_RATE / value;

Thos evaluates the count the timer is programmed to generate a
given frequency (value).
In 2.6.5 this reads CLOCK_TICK_RATE which is definitely not correct
as the system clock is not necessarily driven by this chip (timer 0).
Older versions (kernel 2.4.x) of the speaker driver used a hardcoded
value but there seem to exist at least some strange i386 variants where 
this frequency is not the traditional one. 

So I thought an architectural define was appropriate. Maybe timex.h is
not the best place to put it in.


Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
