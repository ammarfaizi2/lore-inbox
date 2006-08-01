Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbWHAEyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWHAEyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWHAEyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:54:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751571AbWHAEyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:54:52 -0400
Date: Mon, 31 Jul 2006 21:54:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: paulmck@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synchronous signal in the blocked signal context
In-Reply-To: <20060731191449.B4592@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0607312152240.4168@g5.osdl.org>
References: <20060731191449.B4592@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 Jul 2006, Siddha, Suresh B wrote:
>
> This patch (b0423a0d9cc836b2c3d796623cd19236bfedfe63)
> 
> [PATCH] Remove duplicate code in signal.c
> 
> reverts a patch introduced by Linus long time back.

Good catch.

> Was this intentional?
> 
> With the current mainline code, SIGSEGV inside a SIGSEGV handler will endup
> in linux handling endless recursive faults.
> 
> Just wondering if this has been discussed before and is intentional.

It certainly wasn't discussed, and I don't think it was intentional. We 
should _not_ just unblock a blocked signal. We should kill the process, 
because sending the signal is actually very very wrong.

Paul? Should I just revert, or did you have some deeper reason for it?

		Linus
