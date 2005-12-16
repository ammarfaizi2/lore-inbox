Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVLPTcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVLPTcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVLPTcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:32:15 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:24612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932383AbVLPTcO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:32:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NYyhfPNfq7TN1hKUljNDaNAPoMad1SQkWkqJZRCAzdm5kzw81X2guTmgG2gudf7RAnz2OMkX+++n4D6XonTS72h9ej4Xf9XNchoJE5tM2dkMgOmmhGkqzyF+zOHeMvKsxY7tGv0rjmwyD+87nnbIF1pBFORq0GcrfKt3HDRVkVg=
Message-ID: <170fa0d20512161132g34c62593p39b109f07cf30b7d@mail.gmail.com>
Date: Fri, 16 Dec 2005 14:32:13 -0500
From: Mike Snitzer <snitzer@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1134758219.2992.52.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051216141002.2b54e87d.diegocg@gmail.com>
	 <20051216140425.GY23349@stusta.de>
	 <20051216163503.289d491e.diegocg@gmail.com>
	 <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com>
	 <dnv0d3$4jl$1@sea.gmane.org>
	 <1134758219.2992.52.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2005-12-16 at 13:18 -0500, Giridhar Pemmasani wrote:
> > Kyle Moffett wrote:
> >
> > > I have yet to see any resistance to the 4Kb patch this time around
> > > that was not "*whine* don't break my ndiswrapper plz".   There are
> >
> > I haven't seen anyone demanding others not to have 4k stacks; only requests
> > to leave 4k/8k stack option as it is.
>
> in hindsight making this a config option was a mistake. Why? Because
> we're not making every single patch we add to the kernel a config
> option, nor should it be. Config options for drivers or expensive debug
> options are fine, debug options for random patches... aren't really. To
> be fair the config option was intended to be really temporary, like 1
> kernel release, until it was sure there were no kinks. Oh well, there's
> too many people moaning now about ndiswrapper that I fear we'll never
> get rid of it.
>
> And no I do not think a kernel with 9000 config options is still useful;
> not every single trivial thing should be a config option.

You're using overly generalized assertions to try to convince others
that the configurability of a particularly important (to some, albeit
not you) config option is unnecessary.  4K vs 8K is hardly a "trivial"
configuration option of the Linux kernel.  At this point in time it
has not been sufficiently demonstrated that 4K "just works".

Taking a step back, I'm all for -mm being a 4K only tree to force the
issue; but even once all in-tree code is deemed 4K clean people still
may want to be extremely cautious by enabling 8K stacks (possibly
_with_ IRQ stacks).  Its merely a question of can/will Linux (or some
vendor) provide this level of stack overflow safety as is; or does one
need to patch the kernel to get the desired safety?  IF upstream
kernel.org doesn't even provide the knobs to ensure safety at all
costs (and vendors like Redhat have people at the helm who are
advocating 4K stacks in the "Enterprise" Linux kernel configurations
of the world) how does one get a Linux kernel that provides a sizable
safety net that is _SUPPORTED_ for true enterprise-grade applications?

Simply put 4K vs 8K is not as trivial a decision as you'd have people believe.

Mike
