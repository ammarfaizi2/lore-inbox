Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264413AbTDPOrQ (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTDPOrQ 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:47:16 -0400
Received: from zero.aec.at ([193.170.194.10]:54020 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264413AbTDPOrP 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:47:15 -0400
Date: Wed, 16 Apr 2003 16:58:53 +0200
From: Andi Kleen <ak@muc.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, akpm@digeo.com, linux-kernel@vger.kernel.org, anton@samba.org,
       schwidefsky@de.ibm.com, davidm@hpl.hp.com, matthew@wil.cx,
       ralf@linux-mips.org, rth@redhat.com
Subject: Re: Reduce struct page by 8 bytes on 64bit
Message-ID: <20030416145853.GA2421@averell>
References: <20030416140715.GA2159@averell> <20030416.072638.65480350.davem@redhat.com> <20030416144312.GA2327@averell> <20030416.073814.124147956.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416.073814.124147956.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 04:38:14PM +0200, David S. Miller wrote:
>    From: Andi Kleen <ak@muc.de>
>    Date: Wed, 16 Apr 2003 16:43:12 +0200
>    
>    On sparc64. But is that true too for all other 64bit architectures supported?
>    
>    e.g. How about PA-RISC? (always seems to do things differently)
>    
> It cannot require more than the existing API requires, which is
> "unsigned long *bitmask", ie. anything equivalent in behavior to an
> unsigned long pointer is good enough.

Sure, but perhaps it does assume all accesses to this bitmap are going
through the set_bit functions. e.g. consider an implementation that
uses a spinlock for this - parisc seems to do that for example
from a quick look into their bitops.h. And they have an 64bit kernel
too.

In this case part of the unsigned long could be accessed directly 
using the aliasing.

-Andi


