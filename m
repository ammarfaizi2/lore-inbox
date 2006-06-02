Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWFBGCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWFBGCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBGCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:02:41 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:54443 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751145AbWFBGCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:02:40 -0400
Date: Fri, 2 Jun 2006 08:02:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602060258.GA7525@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com> <20060601183836.d318950e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601183836.d318950e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5007]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 1 Jun 2006 17:58:48 -0700
> "Barry K. Nathan" <barryn@pobox.com> wrote:
> 
> > Ok, the kernel that I now have booting is 2.6.17-rc5-mm2 + my
> > pata_pdc2027x patch + the 3 hotfixes that I saw when I started trying
> > to build the kernel (i.e. without git-scsi-target-fixup but with the
> > other 3 that are now present).
> > 
> > During boot of my Debian sarge system, this kernel always gives this
> > warning at "Starting MTA:"
> > http://static.flickr.com/47/158326090_35d0129147_b_d.jpg
> 
> That's the mysterious lockdep warning - I'm not sure we've got to the
> bottom of that.

Barry, if the system boots up fine with LLC disabled (and if you still 
get the lockdep warning), then please apply the following patch:

  http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch

accept all the default 'make oldconfig' options and reboot into the 
patched kernel. If everything goes well then the system should still 
boot up fine, you should still get the lockdep warning - but this time 
there should be a long trace in /proc/latency_trace. Please upload that 
trace - it gives us the kernel's function trace, leading up to the 
warning.

	Ingo
