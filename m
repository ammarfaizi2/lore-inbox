Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbSITERX>; Fri, 20 Sep 2002 00:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274925AbSITERX>; Fri, 20 Sep 2002 00:17:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32178 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S274920AbSITERW>; Fri, 20 Sep 2002 00:17:22 -0400
Date: Thu, 19 Sep 2002 21:20:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] x86_udelay_tsc not honoring notsc
Message-ID: <467492138.1032470424@[10.10.2.3]>
In-Reply-To: <20020920040905.GG3530@holomorphy.com>
References: <20020920040905.GG3530@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point in the past, I wrote:
>>> If so, it's probably not worth mucking around with the bootstrap
>>> sequence to deal with something this minor. It's not like it can
>>> be mistaken for having hung, as console output is very consistent.
>>> Maybe we should give NUMA-Q a couple of minutes instead of 5s?
> 
> On Thu, Sep 19, 2002 at 09:00:09PM -0700, Martin J. Bligh wrote:
>> Nah, just recode the boot sequence to make them all boot in 
>> parallel ;-)
> 
> Do you think cpu wakeup alone could be doing this? If so, then doing
> that bit would be relatively isolated (though a slightly larger diff
> than changing an NMI oopser timeout).

Seems odd that you didn't get it in previous versions ... ? But 
running the NMI oops detection whilst stealing NMIs in order to
bootstrap the CPUs is probably a Bad Idea (tm).
 
> Does 0xFF broadcast cluster, broadcast low nybble work or is waking
> them a cluster at a time required?  This thing is not swift to boot...

Well, you don't want to send an NMI to yourself (the BSP), I presume?
That would probably make it unhappy ;-) The NMIs have to be logically addressed, which precludes the allbutself thingy, IIRC. So you have
a choice of serialised unicast (which is probably quite fast enough)
or cluster at a time, being careful to exclude yourself when you do
the BSP's cluster. 

But I think you'd be far better off just disabling the NMI oopser
until we've booted - the dual use is too much nefarious incest for
my liking.

M.
