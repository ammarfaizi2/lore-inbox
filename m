Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTDPVPC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTDPVPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:15:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55186 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264590AbTDPVPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:15:00 -0400
Date: Wed, 16 Apr 2003 22:26:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Matthew Wilcox <willy@debian.org>, ak@muc.de, davem@redhat.com,
       linux-kernel@vger.kernel.org, anton@samba.org, schwidefsky@de.ibm.com,
       davidm@hpl.hp.com, matthew@wil.cx, ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030416212651.GF1505@parcelfarce.linux.theplanet.co.uk>
References: <20030415112430.GA21072@averell> <20030416.054521.26525548.davem@redhat.com> <20030416140715.GA2159@averell> <20030416.072638.65480350.davem@redhat.com> <20030416144312.GA2327@averell> <20030416145532.GA1505@parcelfarce.linux.theplanet.co.uk> <20030416150427.GA2496@averell> <20030416151112.GB1505@parcelfarce.linux.theplanet.co.uk> <20030416133539.0ac01968.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416133539.0ac01968.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 01:35:39PM -0700, Andrew Morton wrote:
> Matthew Wilcox <willy@debian.org> wrote:
> >
> > Jacob's would break if we hashed to different spinlocks.  But we don't, we
> > shift right by 8, so we get the same spinlock for atomic things that are on
> > the same "cacheline" (i think PA cachelines are actually 64 or 128 bytes,
> > depending on model).
> > 
> 
> Are you prepared to cast this in stone?

I think so.  It makes sense to me that we lock an entire cacheline for
this kind of thing.  Indeed, locking a smaller amount would probably break
other stuff.  Remember set_bit() et al take a pointer to an unsigned long...
but can take a bit number > number of bits in an unsigned long.  If anything,
we should maybe expand the range covered by a single lock to a larger amount
than 256 bytes.  How big are ext2 bitmaps, for example?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
