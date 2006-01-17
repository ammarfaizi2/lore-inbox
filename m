Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWAQGnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWAQGnZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 01:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWAQGnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 01:43:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750976AbWAQGnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 01:43:24 -0500
Date: Mon, 16 Jan 2006 22:42:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mita@miraclelinux.com,
       Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch 2.6.15-current] i386: multi-column stack backtraces
Message-Id: <20060116224234.5a7ca488.akpm@osdl.org>
In-Reply-To: <200601170126_MC3-1-B602-EFCB@compuserve.com>
References: <200601170126_MC3-1-B602-EFCB@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Print stack backtraces in multiple columns, saving screen space.
> Number of columns is configurable and defaults to one so 
> behavior is backwards-compatible.
> 
> Also removes the brackets around addresses when printing more
> that one entry per line so they print as:
>     <address>
> instead of:
>     [<address>]
> This helps multiple entries fit better on one line.
> 
> Original idea by Dave Jones, taken from x86_64.
> 

Presumably this is going to bust ksymoops.  Also the various other custom
oops-parsers which people have written themselves.

> +config STACK_BACKTRACE_COLS

It's pretty sad to go and make something like this a config option.  But
given that it is, believe it or not, an exported-to-userspace interface, I
guess there's not much choice.

The patch is a desirable change (I do get seasick reading x86_64 traces,
but I'll get over it), but it'll cause various bits of downstream grief.
