Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVG1Rt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVG1Rt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVG1RsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:48:18 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:43257 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261773AbVG1RrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:47:10 -0400
Date: Thu, 28 Jul 2005 10:52:26 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do the work)
Message-ID: <20050728175226.GH9985@gaz.sfgoth.com>
References: <1122473595.29823.60.camel@localhost.localdomain> <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1122513928.29823.150.camel@localhost.localdomain> <1122519999.29823.165.camel@localhost.localdomain> <1122521538.29823.177.camel@localhost.localdomain> <1122522328.29823.186.camel@localhost.localdomain> <42E8564B.9070407@yahoo.com.au> <1122551014.29823.205.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122551014.29823.205.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 28 Jul 2005 10:52:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> In the thread "[RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO
> configurable" I discovered that a C version of find_first_bit is faster
> than the asm version

There are probably other cases of this in asm-i386/bitopts.h.  For instance
I think the "btl" instruction is pretty slow on modern CPUs so
constant_test_bit() will probably outperform variable_test_bit() even if
you feed it a non-constant "nr".  I'd be happy to be proven wrong, though :-)

When testing these optimizations you should also probably check the resulting
vmlinux size.

-Mitch
