Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310438AbSCUXgq>; Thu, 21 Mar 2002 18:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310468AbSCUXgh>; Thu, 21 Mar 2002 18:36:37 -0500
Received: from holomorphy.com ([66.224.33.161]:27534 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S310438AbSCUXgb>;
	Thu, 21 Mar 2002 18:36:31 -0500
Date: Thu, 21 Mar 2002 15:35:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <20020321233533.GB785@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020320202401.GA785@holomorphy.com> <Pine.LNX.4.44.0203210849320.32455-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, William Lee Irwin III wrote:
>> There is/was at least one simulator that shoots the kernel (and
>> everything else) dead in response to frobbing the PIC while the local
>> APIC timer etc. are going, and I wouldn't be surprised if there were
>> some real hardware that did so as well.

On Thu, Mar 21, 2002 at 08:54:53AM +0200, Zwane Mwaikambo wrote:
> The problem was that the the simulator didn't support polling mode, which 
> linux 2.4 seems to use for handling the timer interrupt. The simulator PIC 
> implementation wasn't complete if it didn't support polling mode. You 
> shouldn't see this on real hardware.

Polling mode on the PIC wasn't there, true, so it did trigger a
simulator bug -- but the PIC should never have been touched. It was
using the local APIC timer etc. Or at least it certainly seems
counterintuitive to me that the PIC is set into polling mode and EOI'd
when the local APIC is whose timer is used and is where the interrupt
came from. We're using the APIC... why are we touching the PIC?


Cheers,
Bill
