Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWFZQ5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWFZQ5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWFZQ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:57:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750925AbWFZQ5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:57:17 -0400
Date: Mon, 26 Jun 2006 09:57:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, arjan@linux.intel.com,
       pavel@suse.cz
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
Message-Id: <20060626095702.8b23263d.akpm@osdl.org>
In-Reply-To: <1151060089.30819.2.camel@lappy>
References: <1151060089.30819.2.camel@lappy>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:54:49 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Some folks find 128KB of env+arg space too little. Solaris provides them with
> 1MB. Manually changing MAX_ARG_PAGES worked for them so far, however they
> would like to run the supported vendor kernel.
> 
> In the interest of not penalising everybody with the overhead of just
> setting it larger, provide a sysctl to change it.
> 
> Compiles and boots on i386.

AFAICS, the main downside of simply increasing MAX_ARG_PAGES is that
fixed-size array in `struct linux_binprm'.  You've solved that via kmalloc,
so can we avoid the sysctl?  We can now increase MAX_ARG_PAGES to something
ridiculous with basically no cost?  It's swappable memory and should be
limited by the RLIMIT_RSS which we don't implement ;)

Also, I'm not sure that we need max_arg_pages_min and max_arg_pages_max -
it's a privileged operation and we can just let root decide whether or not
to screw up the machine.
