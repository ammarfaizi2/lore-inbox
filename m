Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVATAOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVATAOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVATANQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:13:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:44451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261996AbVATAKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:10:07 -0500
Date: Wed, 19 Jan 2005 16:09:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cputime_t patches broke RLIMIT_CPU
In-Reply-To: <200501192054.j0JKsiFw002526@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0501191605380.8178@ppc970.osdl.org>
References: <200501192054.j0JKsiFw002526@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jan 2005, Roland McGrath wrote:
>
> The RLIMIT_CPU limit is in seconds, not in jiffies.

This patch would seem to have its own problems, though. See:

	#define secs_to_cputime(__secs)           (msecs_to_jiffies(__secs * HZ))

which means that since there is no overflow checking (not in the current 
tree, and not in the fixed one that uses proper parenthesis and *1000, you 
can easily end up overflowing in the *1000 case, and causing nasty things.

So would it not be nicer to just keep everything in seconds instead? 
Alternatively, seriously fix "secs_to_cputime()" to do the proper thing?
Or did I miss a patch and you already did that?

		Linus
