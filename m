Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWFZCTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWFZCTP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 22:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWFZCTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 22:19:15 -0400
Received: from mail.gmx.de ([213.165.64.21]:57262 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751364AbWFZCTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 22:19:14 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060625184244.GA11921@atjola.homenet>
References: <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
	 <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
	 <1151211993.8519.6.camel@Homer.TheSimpsons.net>
	 <20060625111238.GB8223@atjola.homenet>
	 <20060625142440.GD8223@atjola.homenet>
	 <1151257451.7858.45.camel@Homer.TheSimpsons.net>
	 <1151257397.4940.45.camel@laptopd505.fenrus.org>
	 <20060625184244.GA11921@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Date: Mon, 26 Jun 2006 04:23:22 +0200
Message-Id: <1151288602.7470.22.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 20:42 +0200, Björn Steinbrink wrote:
> I just booted with both patches applied, mine and Mike's, and that
> actually makes a difference in hardirq cpu time accounting. With my
> patch only, hi is 0 in top while the box gets a ping flood. With both
> patches, I get about 1% hi. Mike's patch causes update_process_times()
> to be called twice on UP, but that alone shouldn't change the
> percentages, right?

Yes, you definitely need to comment out the other call if you test the
SMP path on UP+IO-APIC.

> OTOH top shows "hi" as zero with 8K stacks as well unless Mike's patch
> is applied, so the results with Mike's patch are bogus (if so, why?) or
> hardirq accounting is broken in general.

Something is certainly still b0rken.  I still get three different
answers to the question "what is my cpu usage" depending on
configuration.  With stock UP kernel with no IO-APIC, interrupt load is
all hi.  With your patch and IO-APIC, it's all si.  SMP shows a mix of
both.

I like the result of using the SMP path if you have an IO-APIC best,
though I haven't verified them against a profile for accuracy.  Taking a
peek at the profile confirms that it is indeed mixed, so anything
showing the load as being either hi or si has to be wrong.

	-Mike

