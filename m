Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbULEKd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbULEKd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 05:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULEKd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 05:33:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44729 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261290AbULEKdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 05:33:24 -0500
Date: Sun, 5 Dec 2004 11:33:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] NX: Fix noexec kernel parameter / x86_64
Message-ID: <20041205103317.GB26964@elte.hu>
References: <Pine.LNX.4.61.0412041135570.6378@montezuma.fsmlabs.com> <Pine.LNX.4.61.0412042356340.6378@montezuma.fsmlabs.com> <20041205065921.GA26964@elte.hu> <Pine.LNX.4.61.0412050007010.6378@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412050007010.6378@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

> > > +		if (!memcmp(from, "noexec=", 7)) {
> > > +			extern void nonx_setup(char *str);
> > > +	
> > > +			nonx_setup(from + 7);
> > > +		}
> > 
> > looks good, but please put the prototype into a header.
> 
> I bet Andrew is going to say the same thing... It just seems odd
> putting a prototype in a header for a function with one call site and
> gets freed after boot. Since i'll have to rediff, i'm also going to
> change the nonx_setup parameter type to const char * as suggested by
> someone in a private email.

too many times did stuff break in the past due to some function changing
some attribute later on but the prototype being misdefined in another
place and the compiler having no chance to detect it.

	Ingo
