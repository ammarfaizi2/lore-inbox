Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWIISew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWIISew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWIISew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 14:34:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:12878 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751362AbWIISew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 14:34:52 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,136,1157353200"; 
   d="scan'208"; a="128041283:sNHT17686844"
Message-ID: <4503091C.1050501@intel.com>
Date: Sat, 09 Sep 2006 11:34:04 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org, segher@kernel.crashing.org,
       davem@davemloft.net
Subject: Re: Opinion on ordering of writel vs. stores to RAM
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 9 Sep 2006, Paul Mackerras wrote:
>> Do you have an opinion about whether the MMIO write in writel() should
>> be ordered with respect to preceding writes to normal memory?
> 
> It shouldn't. It's too expensive. The fact that PC's have nice memory 
> consistency models means that most of the testing is going to be with the 
> PC memory ordering, but the same way we have "smp_wmb()" (which is also a 
> no-op on x86) we should probably have a "mmiowb()" there.
> 
> Gaah. Right now, mmiowb() is actually broken on x86 (it's an empty define, 
> so it may cause compiler warnings about statements with no effects or 
> something).
> 
> I don't think anyting but a few SCSI drivers that are used on some ia64 
> boxes use mmiowb(). And it's currently a no-op not only on x86 but also on 
> powerpc. Probably because it's defined to be a barrier between _two_ MMIO 
> operations, while we should probably have things like

it seems to be a growing virus with network drivers too. bnx2, s2io, tg3 and 
bcm43xx (which has like 40 of them) are already resorting to it. We're even 
planning on putting one in to e1000.

I'm not sure what bcm43xx chip will work with IA64, or if people actually have 
itanium laptops(!) or MIPS, but for e1000 it definately fixes ordering problems 
on IA64.

Auke

