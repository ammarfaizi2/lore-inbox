Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264636AbSKDC7M>; Sun, 3 Nov 2002 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSKDC7M>; Sun, 3 Nov 2002 21:59:12 -0500
Received: from holomorphy.com ([66.224.33.161]:62865 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264636AbSKDC7L>;
	Sun, 3 Nov 2002 21:59:11 -0500
Date: Sun, 3 Nov 2002 19:04:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021104030420.GV23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com> <200211040028.gA40S8600593@devserv.devel.redhat.com> <20021104002813.GZ16347@holomorphy.com> <20021103194249.A1603@devserv.devel.redhat.com> <20021104005339.GA16347@holomorphy.com> <1036372685.752.7.camel@phantasy> <20021104014224.GR23425@holomorphy.com> <1036378887.750.96.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036378887.750.96.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 20:42, William Lee Irwin III wrote:
>> I'll go figure out why before posting a follow-up. This is not doing
>> what I wanted it to because the only one I originally wanted was (1),
>> having to do with interrupt-time recursion on rwlocks and writer
>> starvation caused by it.

On Sun, Nov 03, 2002 at 10:01:24PM -0500, Robert Love wrote:
> You can do #1, but you need to figure out if your interrupt is the only
> interrupt using the lock or not (possibly hard).
> In other words, a lock unique to your interrupt handler does not need to
> disable interrupts (since only that handler can grab the lock and it is
> disabled).
> If other handlers can grab the lock, interrupts need to be disabled.
> So a test of irqs_disabled() would show a false-positive in the first
> case.  No easy way to tell..
> 	Robert Love

Sounds like I rip out that check and ignore the fact it's useless for
its original intended purpose. No matter, it'll turn up something.

Incoming.

Bill
