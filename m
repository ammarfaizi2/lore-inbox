Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319395AbSH2WUN>; Thu, 29 Aug 2002 18:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319390AbSH2VxJ>; Thu, 29 Aug 2002 17:53:09 -0400
Received: from holomorphy.com ([66.224.33.161]:36741 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319388AbSH2Vw0>;
	Thu, 29 Aug 2002 17:52:26 -0400
Date: Thu, 29 Aug 2002 14:56:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile-time configurable NR_CPUS
Message-ID: <20020829215646.GI888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <1030635200.939.2561.camel@phantasy> <20020829214230.GH888@holomorphy.com> <1030657461.11553.2693.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1030657461.11553.2693.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 17:42, William Lee Irwin III wrote:
>> Could you make CONFIG_NR_CPUS only for non-NUMA-Q systems and hardwire
>> it to 32 for NUMA-Q, as the bugs in io_apic.c don't have fixes yet and
>> NUMA-Q's have enough IO-APIC's to trigger the bugs.

On Thu, Aug 29, 2002 at 05:44:20PM -0400, Robert Love wrote:
> Linus has not shown any interest in merging, so it is a non-issue at the
> moment...

devfs doesn't hold a candle to io_apic.c

I did 3 runs on a 32x last night, and got 3 panics not present in 2.4:
(1) "Recompile kernel with bigger MAX_IO_APICS!.\n",
	so I bumped up MAX_IO_APICS to "impossibly huge"
(2) "Max APIC ID exceeded!\n", so I removed the physid reprogramming
(3) "ran out of interrupt sources!",
	and I chugged a stiff drink, gave up, & went to bed (this is evil)

Reducing NR_CPUS tends to trigger some kind of physical APIC ID
reprogramming panic() (msg #2 above) that doesn't normally happen.

Cheers,
Bill
