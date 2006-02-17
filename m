Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWBQWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWBQWON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWBQWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:14:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751720AbWBQWON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:14:13 -0500
Date: Fri, 17 Feb 2006 14:14:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: another possible singlestep fix
In-Reply-To: <200602171652_MC3-1-B8AC-373E@compuserve.com>
Message-ID: <Pine.LNX.4.64.0602171412210.916@g5.osdl.org>
References: <200602171652_MC3-1-B8AC-373E@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Feb 2006, Chuck Ebbert wrote:
>
> When entering kernel via int80, TIF_SINGLESTEP is not set
> when TF has been set in eflags by the user.  This patch
> does that.

This really shouldn't matter.

When we enter the kernel through "int 0x80", we don't need to do anything 
about TIF_SINGLESTEP, because unlike the "sysenter" path, the "int" 
instruction will automatically do the right thing (save old eflags on the 
stack).

So afaik, this won't actually do anything (except make _the_ most 
timing-critical path in the kernel slower). Have you actually seen any 
effects of it?

		Linus
