Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWGEUgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWGEUgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWGEUgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:36:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964785AbWGEUge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:36:34 -0400
Date: Wed, 5 Jul 2006 13:36:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
In-Reply-To: <20060705131824.52fa20ec.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
References: <20060705084914.GA8798@elte.hu> <20060705023120.2b70add6.akpm@osdl.org>
 <20060705093259.GA11237@elte.hu> <20060705025349.eb88b237.akpm@osdl.org>
 <20060705102633.GA17975@elte.hu> <20060705113054.GA30919@elte.hu>
 <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Andrew Morton wrote:
> 
> OK, but what happened to the 35-bytes-per-callsite saving?

I really don't think it existed.

Maybe there's something else going on. In particular, I wonder if sections 
like the "debug_loc" fection end up being counted towards text-size? They 
never actually get _loaded_, but they can be absolutely enormous if 
CONFIG_DEBUG_INFO is enabled.

Doing "make allnoconfig" would have turned off not only modules, but also 
indirectly turned off gratuitous debug info bloat like that..

				Linus
