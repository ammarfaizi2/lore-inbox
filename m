Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWAEOej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWAEOej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWAEOei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:34:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27783 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751337AbWAEOef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:34:35 -0500
Date: Thu, 5 Jan 2006 09:30:48 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       Matt Mackall <mpm@selenic.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105143048.GT22293@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136463553.2920.22.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:19:12PM +0100, Arjan van de Ven wrote:
> obvious candidates for __rare are
> * pm suspend/resume functions
> * error handling functions
> * initialization stuff (including mount time stuff for filesystems,
>   and hardware setup for drivers)
> 
> I wonder if gcc can be convinced to put all unlikely() code sections
> into a .text.rare as well, that'd be really cool.

gcc 4.1 calls them .text.unlikely and you need to use
-freorder-blocks-and-partition
switch.  But I haven't been able to reproduce it on a short testcase I
cooked up, so maybe it is broken ATM (it put the whole function into
.text rather than the expected part into .text.unlikely and left
empty .text.unlikely).

	Jakub
