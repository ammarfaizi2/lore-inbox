Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWFKTh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWFKTh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWFKTh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:37:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750890AbWFKTh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:37:26 -0400
Date: Sun, 11 Jun 2006 12:33:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: use C code for current_thread_info()
In-Reply-To: <200606111512_MC3-1-C229-37D@compuserve.com>
Message-ID: <Pine.LNX.4.64.0606111225380.5498@g5.osdl.org>
References: <200606111512_MC3-1-C229-37D@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jun 2006, Chuck Ebbert wrote:
>
> Using C code for current_thread_info() lets the compiler optimize it.

Ok, me likee. I just worry that this might break some older gcc version. 
Have you checked with gcc-3.2 or something?

We've had that "current_stack_pointer" thing for a long while, but we only 
use it in the irq-stack path (where it's really very incidental: the whole 
use of the "previous_esp" thing is only for the oops tracing. Maybe there 
was some reason (like gcc generating bad code) for not using it earlier?

(Admittedly, a more likely reason is probably just nobody looking at it, 
but it sounds like we should check it out anyway, just in case)

		Linus
