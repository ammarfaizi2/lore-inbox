Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVIUIOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVIUIOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVIUIOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:14:37 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:45748 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1750757AbVIUIOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:14:36 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Wed, 21 Sep 2005 10:13:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] NTP shift_right cleanup (v. A3)
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       joe-lkml@rameria.de, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, yoshfuji@linux-ipv6.org
Message-ID: <43313241.19315.AC261D7@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <4330EE96.6070801@yahoo.com.au>
References: <1127273050.11080.34.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.95.0+V=3.95+U=2.07.102+R=04 July 2005+T=108296@20050921.080921Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Sep 2005 at 15:24, Nick Piggin wrote:

> john stultz wrote:
> 
> > 
> >+/* Required to safely shift negative values */
> >+#define shift_right(x, s) ({	\
> >+	__typeof__(x) __x = (x);	\
> >+	__typeof__(s) __s = (s);	\
> >+	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
> >+})
> >+
> >
> 
> I'd hate to be the one to make you do another version of this ;)
> 
> However, how about having something more descriptive than shift_right?
> signed_shift_right / shift_right_signed, maybe?

Hi,

I'm against "signed shift right", because the reason for the macro is exaclty that 
CPUs do a "signed" shift right. John does a "signum(arg) * right_shift(abs(arg), 
number_of_positions)". So maybe it's the signed_unsigned_shift_right(), susr() to 
be cryptic ;-)

I'm only surprised that there are many places where such a routine is needed, and 
still it's missing in sime bitops.h #include.

Regards,
Ulrich

