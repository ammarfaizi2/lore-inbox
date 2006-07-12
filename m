Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWGLV7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWGLV7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWGLV7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:59:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932333AbWGLV7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:59:16 -0400
Date: Wed, 12 Jul 2006 14:55:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       andrea <andrea@cpushare.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
In-Reply-To: <200607121739_MC3-1-C4D3-28B9@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607121453230.5623@g5.osdl.org>
References: <200607121739_MC3-1-C4D3-28B9@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jul 2006, Chuck Ebbert wrote:
>
> We can just fold the TSC disable stuff into the new thread_flags test
> at context-switch time:

I really think that this should be cleaned up to _not_ confuse the issue 
of TSC with any "secure computing" issue.

The two have nothing to do with each other from a technical standpoint. 

Just make the flag be called "TIF_NOTSC", and then any random usage 
(whether it be seccomp or anything else) can just set that flag, the same 
way ioperm() sets TIF_IO_BITMAP.

Much cleaner. 

There's no point in mixing up an implementation detail like SECCOMP with a 
feature like this.

			Linus
