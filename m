Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUH1CEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUH1CEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUH1CEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:04:32 -0400
Received: from holomorphy.com ([207.189.100.168]:13987 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266189AbUH1CDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:03:07 -0400
Date: Fri, 27 Aug 2004 19:02:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] fix target_cpus() for summit subarch
Message-ID: <20040828020257.GX2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
	keith maanthey <kmannth@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>
References: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 05:24:48PM -0700, john stultz wrote:
> I've been hunting down a bug affecting IBM x440/x445 systems where the
> floppy driver would get spurious interrupts and would not initialize
> properly. 
> After digging James Cleverdon pointed out that target_cpus() is routing
> the interrupts to the clustered apic broadcast mask. This was causing
> multiple interrupts to show up, breaking the floppy init code. 
> This one-liner fix simply routes interrupts to the first cpu to resolve
> this issue.
> Any comments or feedback would be appreciated.

You're using fixed delivery mode, so non-singleton destinations break.
If lowest prio delivery mode saw this, you'd have IO-APIC errata.


-- wli
