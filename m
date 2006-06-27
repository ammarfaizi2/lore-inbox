Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWF0MRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWF0MRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWF0MRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:17:16 -0400
Received: from fmr18.intel.com ([134.134.136.17]:24270 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932335AbWF0MRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:17:15 -0400
Message-ID: <44A12190.40806@linux.intel.com>
Date: Tue, 27 Jun 2006 14:16:16 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org> <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org> <20060626223526.GA18579@elte.hu> <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org> <20060627110954.GA23672@elte.hu>
In-Reply-To: <20060627110954.GA23672@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> at copy_strings_kernel() time we dont yet know where in the target VM to 
> install the pages. A binformat might want to install all sorts of stuff 
> on the stack first, before it constructs the envp and copies the strings 
> themselves. So we dont know the precise alignment needed.
> 
> delaying the copying to setup_arg_pages() time does not seem to work 
> either, because that gets called after the old MM has been destroyed.
> 
> [ delaying the copying will also change behavior in error cases - 
>   instead of returning with an error if the string pointers are bad 
>   we'll have to kill the execve()ing process. ]
> 
> am i missing something?

we could always just have the  binfmt use mremap() equivalent to move it 
into the place it wants...
