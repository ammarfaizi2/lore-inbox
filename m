Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbTJQXZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTJQXZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:25:20 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:8852 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263632AbTJQXZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:25:14 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Date: Fri, 17 Oct 2003 17:25:10 -0600
User-Agent: KMail/1.5.3
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200310171610.36569.bjorn.helgaas@hp.com> <20031017155028.2e98b307.akpm@osdl.org>
In-Reply-To: <20031017155028.2e98b307.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310171725.10883.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 October 2003 4:50 pm, Andrew Morton wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >
> > Old behavior:
> > 
> >     # dd if=/dev/mem of=/dev/null
> >     <unrecoverable machine check>
> 
> I recently fixed this for ia32 by changing copy_to_user() to not oops if
> the source address generated a fault.  Similarly copy_from_user() returns
> an error if the destination generates a fault.
> 
> In other words: drivers/char/mem.c requires that the architecture's
> copy_*_user() functions correctly handle faults on either the source or
> dest of the copy.

If we really believe copy_*_user() must correctly handle *all* faults,
isn't the "p >= __pa(high_memory)" test superfluous?

I don't know how ia32 handles a read to non-existent physical memory.
Are you saying that copy_*_user() can deal with that just like it does
a garden-variety TLB fault?

On ia64, a read to non-existent physical memory causes the processor
to time out and take a machine check.  I'm not sure it's even possible
to recover from that.

Bjorn

