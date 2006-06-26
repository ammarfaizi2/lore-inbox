Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWFZR7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWFZR7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFZR6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:58:38 -0400
Received: from mail.gmx.de ([213.165.64.21]:57568 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751245AbWFZR6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:58:35 -0400
X-Authenticated: #5039886
Date: Mon, 26 Jun 2006 19:58:44 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
Message-ID: <20060626175844.GA3822@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Mike Galbraith <efault@gmx.de>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, danial_thom@yahoo.com,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <1151166193.8516.8.camel@Homer.TheSimpsons.net> <20060624192523.GA3231@atjola.homenet> <1151211993.8519.6.camel@Homer.TheSimpsons.net> <20060625111238.GB8223@atjola.homenet> <20060625142440.GD8223@atjola.homenet> <1151257451.7858.45.camel@Homer.TheSimpsons.net> <1151257397.4940.45.camel@laptopd505.fenrus.org> <20060625184244.GA11921@atjola.homenet> <1151288602.7470.22.camel@Homer.TheSimpsons.net> <1151291114.7611.8.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1151291114.7611.8.camel@Homer.TheSimpsons.net>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.26 05:05:14 +0200, Mike Galbraith wrote:
> On Mon, 2006-06-26 at 04:23 +0200, Mike Galbraith wrote:
> 
> > Something is certainly still b0rken.  I still get three different
> > answers to the question "what is my cpu usage" depending on
> > configuration.  With stock UP kernel with no IO-APIC, interrupt load is
> > all hi.  With your patch and IO-APIC, it's all si.  SMP shows a mix of
> > both.
> 
> I didn't say that quite right.
> 
> The third case for my box is XT-PIC and your patch.  Previously, top
> showed the 10% interrupt load of a flood ping as all hi.  Now it's both
> hi and si when using XT-PIC, but it's no longer the 10% that agreed with
> the profile, it's  10% hi, but with an added ~7% si.

I see the following here, when a box is being ping flooded:

UP/SMP  stack-size  PIC-type  hi si
-----------------------------------
UP      8K          IO-APIC  0  16
UP      8K          XT-PIC   7  7
UP      4K          IO-APIC  0  16
UP      4K          XT-PIC   7  7

SMP     8K          IO-APIC  5  4 (forcedeth)
SMP     8K          IO-APIC  0  11 (tg3)

The UP system is a Thinkpad which only has a tg3 driven NIC. The SMP
system is x86_64, so there's no 4K stacks to test with, maybe I'll fetch
a i386 live CD to do some more valid tests on SMP.

The UP tests seem to show the IO-APIC hardirq are completely deferred
to be handled in a softirq, as the sum of "hi" and "si" with XT-PIC is
about equal to the "si" value with IO-APIC (the numbers are guessed
averages of the observed values, so the 2% difference is not too be
taken too serious).
The results for the forcedeth driven NIC do not agree though, and your
results differ from what I see as well, right? So I'm kinda lost again.

Björn
