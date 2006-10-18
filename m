Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422789AbWJRToW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789AbWJRToW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422790AbWJRToW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:44:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422789AbWJRToV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:44:21 -0400
Date: Wed, 18 Oct 2006 12:44:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, ebiederm@xmission.com
Subject: Re: sysctl
Message-Id: <20061018124415.e45ece22.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 14:52:21 -0400 (EDT)
Cal Peake <cp@absolutedigital.net> wrote:

> On Wed, 18 Oct 2006, Linus Torvalds wrote:
> 
> > There's apparently some library functions that has used it in the past, 
> > and I've seen a few effects of that:
> > 
> > 	warning: process `wish' used the removed sysctl system call
> > 
> > but the users all had fallback positions, so I don't think anything 
> > actually broke.
> 
> Agreed, nothing seems to have broken by removing it but the warnings sure 
> are ugly. Is there any reason to have them? If a program relies on sysctl 
> and the call fails the program should properly handle the error. That 
> should be all the warning that's needed (i.e. report the broken program 
> and get it fixed).

We should have added the sysctl numbers to that warning.

Lots of things do sysctl(KERN_VERSION), including FC5's date(1).  Andi's
proposal to put some hard-wired KERN_VERSION emulator in there sounds
reasonable to me, depending upon how many other things we'll need to
emulate (which we don't know yet).

> > (The situation may be different with older libraries, which is why it's 
> > still an option to compile in sysctl. None of the machines I had access 
> > to cared at all, though).
> 
> So leave it as is for now, default to off with option to compile in if 
> EMBEDDED and then remove it completely in a few months?

It should always be an objective to remove code if we can feasibly find a
way to do so.  For us to give up now and to leave all that goop in there
forever would be sad.

A patch which enhances that printk would be appreciated...
