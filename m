Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWHAWot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWHAWot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWHAWot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:44:49 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:39073 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750710AbWHAWos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:44:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17615.55638.314556.722153@cargo.ozlabs.ibm.com>
Date: Wed, 2 Aug 2006 08:44:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jan Blunck <jblunck@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vmstat per cpu usage
In-Reply-To: <20060801140707.a55a0513.akpm@osdl.org>
References: <20060801173620.GM4995@hasse.suse.de>
	<20060801140707.a55a0513.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> On Tue, 1 Aug 2006 19:36:21 +0200
> Jan Blunck <jblunck@suse.de> wrote:
> 
> > The per cpu variables are used incorrectly in vmstat.h.
[snip]
> > -	__get_cpu_var(vm_event_states.event[item])++;
> > +	__get_cpu_var(vm_event_states).event[item]++;
> >  }
> 
> How odd.  Are there any negative consequences to the existing code?

That sort of thing - i.e. using __get_cpu_var on something which isn't
just a simple variable name - works with the current per-cpu macro
definitions, because they are pretty simple, but one can imagine other
reasonable implementations of __get_cpu_var which need the argument to
be a simple variable name.  I struck this when I was experimenting
with using __thread variables for per-cpu data.

Paul.
