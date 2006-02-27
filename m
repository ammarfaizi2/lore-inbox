Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWB0XG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWB0XG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWB0XG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:06:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751837AbWB0XG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:06:27 -0500
Date: Mon, 27 Feb 2006 15:06:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] i386: make bitops safe
In-Reply-To: <200602271700_MC3-1-B969-F4A5@compuserve.com>
Message-ID: <Pine.LNX.4.64.0602271502410.22647@g5.osdl.org>
References: <200602271700_MC3-1-B969-F4A5@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Feb 2006, Chuck Ebbert wrote:
>
> Make i386 bitops safe.  Currently they can be fooled, even on
> uniprocessor, by code that uses regions of the bitmap before
> invoking the bitop.  The least costly way to make them safe
> is to add a memory clobber and tag all of them as volatile.

Actually, the least costly way should be to make the "ADDR" define work 
right again.

It used to do something magic like

	struct fake_area {
		unsigned long members[1000];
	};

	#define ADDR (*(volatile struct fake_area *)addr)

which was correct. I forget why it got broken into using just a "long *" 
(it happened a long long time ago).

		Linus
