Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272198AbRHWDPE>; Wed, 22 Aug 2001 23:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272200AbRHWDOo>; Wed, 22 Aug 2001 23:14:44 -0400
Received: from ns.suse.de ([213.95.15.193]:43538 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272198AbRHWDOm>;
	Wed, 22 Aug 2001 23:14:42 -0400
To: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allocation of sk_buffs in the kernel
In-Reply-To: <OF55D2E221.5E62CB41-ONC1256AB0.0052D2D3@de.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2001 05:14:56 +0200
In-Reply-To: "Jens Hoffrichter"'s message of "22 Aug 2001 17:15:19 +0200"
Message-ID: <oupd75no4b3.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jens Hoffrichter" <HOFFRICH@de.ibm.com> writes:

> I'm currently writing a kernel patch where it is essential to get known
> when a sk_buff is allocated. Or better said I have to get known when a
> sk_buff is effectively a new packet in the kernel-

I don't want to guess why you need that...

> 
> I currently identified 3 functions in the kernel where sk_buffs are
> allocated: alloc_skb (of course), skb_linearize and pskb_expand_head. Or at
> least there new data is defined for the sk_buffs.
> 
> Now I monitor a TCP session, a FTP download better said, and on the
> interface arrives around 30000 packets for 50 MB of data. But in my kernel
> patch only 2000 packets are allocated, or at least I see only the
> allocation of 2000 packets.
> 
> Can anyone help me where I can find my missing packets? ;)) I need them
> badly! *GG*

There should be no skbuff allocation outside net/core/skbuff.c and all
normal[1] networking drivers also don't use private pools. Perhaps
you forgot to instrument a case there.

-Andi

[1] There may be a few unnormal ones that do; e.g. vendor driver
writers seem to frequently try to reuse skbuffs privately because they're
used to that from other OS. It is discouraged and somewhat tricky, but
possible.


