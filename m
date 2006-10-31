Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965516AbWJaLQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965516AbWJaLQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965531AbWJaLQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:16:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47256 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965516AbWJaLQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:16:04 -0500
Date: Tue, 31 Oct 2006 12:15:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc3] i386/io_apic: fix compiler warning in create_irq
Message-ID: <20061031111502.GA21450@elte.hu>
References: <tkrat.b1c929dd899e625a@s5r6.in-berlin.de> <20061030090231.GA27146@elte.hu> <20061030170445.1dedce1e.akpm@osdl.org> <1162287457.15286.186.camel@earth> <20061031014914.9af0dde9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031014914.9af0dde9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > this is an initialize-to-zero annotation for a false-positive gcc 
> > warning. If it's not in Jeff tree yet then it should be there ...
> 
> hm, I wouldn't call that "annotation".
> 
> Now, the
> 
> #define SHUT_GCC_UP(x)	= x
> 
> 	...
> 	int foo SHUT_GCC_UP(foo);
> 	...
> 
> (or whatever it was) trick was "annotation".  A good way of doing it 
> too, IMO.

hm, i thought Jeff's tree was doing that ...

we definitely do not want to hide these places. They both make the code 
less readable (why initialize it to some value if that value is never 
used) and they hide the problem from the GCC folks too.

	Ingo
