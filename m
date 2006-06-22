Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932834AbWFVHto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbWFVHto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWFVHto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:49:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932831AbWFVHtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:49:43 -0400
Date: Thu, 22 Jun 2006 00:49:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: michal.k.k.piotrowski@gmail.com, mingo@elte.hu, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       robert.moore@intel.com
Subject: Re: 2.6.17-mm1 - possible recursive locking detected
Message-Id: <20060622004931.60234590.akpm@osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6CF0D02@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0D02@hdsmsx411.amr.corp.intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 03:40:36 -0400
"Brown, Len" <len.brown@intel.com> wrote:

> >> Nothing jumps out at me as incorrect above, so 
> >> at this point it looks like a CONFIG_LOCKDEP artifact --
> >> but lets ask the experts:-)
> >
> >Yes, lockdep uses the callsite of spin_lock_init() to detect 
> >the "type" of
> >a lock.
> >
> >But the ACPI obfuscation layers use the same spin_lock_init() site to
> >initialise two not-the-same locks, so lockdep decides those 
> >two locks are of the same "type" and gets confused.
> 
> interesting definition of "type".  I guess it works
> in practice or others would be complaining...

It works out that way, yes.

> >We had earlier decided to remove that ACPI code which kmallocs a single
> >spinlock.  When that's done, lockdep will become unconfused.
> 
> Yes, that change is already on the way.

Is good.

> The key thing here is that our recent changes in
> how the locks are _used_ is okay -- and I think it is.

Well.  We don't know that.  We just know that this report of unokayness
wasn't right.  With Ingo's Linux-only patch we're in a position to verify
that the locking is probably OK.

