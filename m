Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268136AbUHXB2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268136AbUHXB2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267961AbUHXB2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:28:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:29418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268136AbUHXBXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:23:08 -0400
Date: Mon, 23 Aug 2004 18:21:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
Subject: Re: [PATCH] Writeback page range hint
Message-Id: <20040823182109.6af19081.akpm@osdl.org>
In-Reply-To: <20040824011822.GB15668@redhat.com>
References: <200408232138.i7NLcfJd019125@hera.kernel.org>
	<20040824010723.GA15668@redhat.com>
	<20040823181400.7d721370.akpm@osdl.org>
	<20040824011822.GB15668@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Mon, Aug 23, 2004 at 06:14:00PM -0700, Andrew Morton wrote:
> 
>  > >   > +	int nonblocking:1;		/* Don't get stuck on request queues */
>  > >   > +	int encountered_congestion:1;	/* An output: a queue is full */
>  > >   > +	int for_kupdate:1;		/* A kupdate writeback */
>  > >   > +	int for_reclaim:1;		/* Invoked from the page allocator */
>  > > 
>  > >  Causes sparse spew..
>  > > 
>  > >  include/linux/writeback.h:54:19: warning: dubious one-bit signed bitfield
>  > >  include/linux/writeback.h:55:30: warning: dubious one-bit signed bitfield
>  > >  include/linux/writeback.h:56:19: warning: dubious one-bit signed bitfield
>  > >  include/linux/writeback.h:57:19: warning: dubious one-bit signed bitfield
>  > 
>  > That's fussy of it.  I assume this shuts it up?
> 
> very likely (its 2am, and I'm feeling too lazy to check).

That's the middle of the working day.

> though, is there any real reason why they are bitfields at all ?

That should have been in the changelog.  Bad Suparna.

These structures are allocated on the stack in the (deep) writeback paths. 
Saving a few bytes there does seem to be worth the increased code size.

