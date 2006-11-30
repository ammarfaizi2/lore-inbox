Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031005AbWK3UAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031005AbWK3UAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031279AbWK3UAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:00:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031005AbWK3UAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:00:34 -0500
Date: Thu, 30 Nov 2006 11:59:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Avi Kivity <avi@qumranet.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-Id: <20061130115957.c3761331.akpm@osdl.org>
In-Reply-To: <20061130154425.GB28507@elte.hu>
References: <456AD5C6.1090406@qumranet.com>
	<20061127121136.DC69A25015E@cleopatra.q>
	<20061127123606.GA11825@elte.hu>
	<20061130142435.GA13372@infradead.org>
	<20061130154425.GB28507@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 16:44:25 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > [...] Pretty similar to things like the msr or mtrr driver that expose 
> > cpu features as character drivers aswell.
> 
> you can expose everything as character drivers and ioctls, but that 
> doesnt make it the right solution. It might /start out/ as a driver, 
> because that's an easy to hack model, but the moment something becomes 
> important enough (and virtualization certainly is such a model) it 
> demands a system call.

Actually fourteen syscalls and counting, and some of those have `mode'
arguments.

It's a fat, complex, presumably arch-specific, presumably frequently-changing
API.  So whatever we do will be unpleasant - that's unavoidable in this case,
I suspect.

(hmm, the interface isn't versioned at present - should it be?)

Maybe, perhaps, one day it _should_ be a syscall API.  But right now if we
did that it would become a versioned syscall API with obsolete slots and
various other warts.

I get the feeling we'd be best off if we were to revisit this in a year or
so.

