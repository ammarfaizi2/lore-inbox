Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTDIGIC (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTDIGIC (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:08:02 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:45071 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262785AbTDIGIB (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 02:08:01 -0400
Date: Wed, 9 Apr 2003 02:19:38 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Variable PTE_FILE_MAX_BITS
Message-ID: <20030409021938.A19512@devserv.devel.redhat.com>
References: <20030409011653.A9103@devserv.devel.redhat.com> <20030408225514.478469e0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030408225514.478469e0.akpm@digeo.com>; from akpm@digeo.com on Tue, Apr 08, 2003 at 10:55:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > would you be so kind to take this and forward to Linus?
> > I think this segment of the code is your brainchild.
> 
> y'know, as I was writing that code I thought "no architecture could be dumb
> enough to make PTE_FILE_MAX_BITS variable".

Two different PTE formats.

> > +	/* This needs to be evaluated at runtime on some platforms */
> > +	if (PTE_FILE_MAX_BITS < BITS_PER_LONG)
> > +		if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
> > +			return err;
> 
> The reason I didn't do this in the first place is that if PTE_FILE_MAX_BITS
> is 32 (as it is for ia32 PAE), the compiler generates a warning about the
> (1<<32).  I guess it generates a bug, too.
> 
> Ho hum.  I shall make it "1ULL".

Wait, that would be a pessimization. Let me think about it. 

I am thinking that perhaps I can arrange is so that the number
bits on different sparcs would end the same.

-- Pete
