Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967860AbWLDX5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967860AbWLDX5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967863AbWLDX5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:57:37 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:54114
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967860AbWLDX5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:57:36 -0500
Date: Mon, 4 Dec 2006 15:57:26 -0800
To: bert hubert <bert.hubert@netherlabs.nl>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Cc: "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH 0/4] lock stat for 2.6.19-rt1
Message-ID: <20061204235726.GA5707@gnuppy.monkey.org>
References: <20061204015323.GA28519@gnuppy.monkey.org> <20061204122129.GA2626@outpost.ds9a.nl> <20061204170856.GA32398@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204170856.GA32398@gnuppy.monkey.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 09:08:56AM -0800, Bill Huey wrote:
> On Mon, Dec 04, 2006 at 01:21:29PM +0100, bert hubert wrote:
> > How tightly is your work bound to -rt? Iow, any chance of separating the
> > two? Or should we even want to?
> 
> There's other uses for it as well. Think about RCU algorithms that need
> to spin-try to make sure the update of an element or the validation of
> it's data is safe to do. If an object was created to detect those spins
> it'll track what is effectively contention as well as it is represented
> in that algorithm. I've seen an RCU radix tree implementation do something
> like that.

That was a horrible paragraph plus I'm bored at the moment. What I meant is
that lockless algorithms occasionally have a spin-try associated with it as
well that might possibly validate the data that's updated against the entire
data structure for some kind of consistency cohernecy or possibly on an
individual element. That retry or spin can be considered a contention as well
and it can be made aware to this lock-stat patch just by connecting the
actually occurance of retry logic against a backing object.

I need to be more conscious about proofreading what I write before sending
it off. Was this clear ?

bill

