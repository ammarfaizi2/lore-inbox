Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271655AbRIGJfC>; Fri, 7 Sep 2001 05:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271649AbRIGJep>; Fri, 7 Sep 2001 05:34:45 -0400
Received: from ns.suse.de ([213.95.15.193]:65297 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271648AbRIGJeX>;
	Fri, 7 Sep 2001 05:34:23 -0400
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Defragmentation proposal: preventative maintenance and  cleanup [LONG]
In-Reply-To: <20010907062851Z16136-26184+30@humbolt.nl.linux.org.suse.lists.linux.kernel> <1426827386.999856726@[169.254.198.40].suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Sep 2001 11:34:41 +0200
In-Reply-To: Alex Bligh - linux-kernel's message of "7 Sep 2001 11:13:45 +0200"
Message-ID: <oupwv3buyxa.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel <linux-kernel@alex.org.uk> writes:

> I'd be especially interested to know how we'd solve this for the
> network stuff, which currently relies on physically contiguous packets
> in memory. This is a *HUGE* change I think (larger than any we'd
> make to the VM system).

It's already fixed in the network stack for at least the most important
protocols. The 2.4 stack supports iovecs of pages in skbs and also linked
lists of skbs for a single packet. The biggest killer used to be 
defragmentation; that will just pass around a linked list now. There are
cases where defragmentation-into-a-big-buffer is still needed (e.g. for 
most of netfilter), but fixing that is just small incremental change.

-Andi
