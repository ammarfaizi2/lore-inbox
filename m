Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264440AbTDPOxK (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbTDPOxK 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:53:10 -0400
Received: from zero.aec.at ([193.170.194.10]:57348 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264440AbTDPOxJ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:53:09 -0400
Date: Wed, 16 Apr 2003 17:04:27 +0200
From: Andi Kleen <ak@muc.de>
To: Matthew Wilcox <willy@debian.org>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
       akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030416150427.GA2496@averell>
References: <20030415112430.GA21072@averell> <20030416.054521.26525548.davem@redhat.com> <20030416140715.GA2159@averell> <20030416.072638.65480350.davem@redhat.com> <20030416144312.GA2327@averell> <20030416145532.GA1505@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416145532.GA1505@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 04:55:32PM +0200, Matthew Wilcox wrote:
> On Wed, Apr 16, 2003 at 04:43:12PM +0200, Andi Kleen wrote:
> > On sparc64. But is that true too for all other 64bit architectures supported?
> > 
> > e.g. How about PA-RISC? (always seems to do things differently)
> 
> As you know our only two atomic ops are load-and-clear 32-bit quantity and
> load-and-clear 64-bit quantity.  so we take one of the hashed spinlocks ..

Sure, but you use a 64bit read/store in set_bit/clear_bit etc., right? 

If yes then you can't use this unless you rewrite them to use 32bit store
- otherwise it will conflict with the atomic_t counter in the 64bit slot
which is not protected.

I think my current patch is fine for you - you can still optimize it
this way, but it should already work. Jakub's version would break though.

-Andi
