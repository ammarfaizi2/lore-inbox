Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTE0Cb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTE0Cb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:31:26 -0400
Received: from holomorphy.com ([66.224.33.161]:13257 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262494AbTE0CbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:31:23 -0400
Date: Mon, 26 May 2003 19:44:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@digeo.com>, davem@redhat.com, andrea@suse.de,
       davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527024419.GF8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andrew Morton <akpm@digeo.com>, davem@redhat.com, andrea@suse.de,
	davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
	mbligh@aracnet.com, linux-kernel@vger.kernel.org
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527015307.GC8978@holomorphy.com> <20030526185920.64e9751f.akpm@digeo.com> <20030527021002.GD8978@holomorphy.com> <Pine.LNX.4.50.0305262212070.2265-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305262212070.2265-100000@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003, William Lee Irwin III wrote:
>> The number of interrupt sources on a system ends up scaling this up to
>> numerous IO-APIC RTE reprograms and ioapic_lock acquisitions per-second
>> (granted, with a 5s timeout between reprogramming storms) where it
>> competes against IO-APIC interrupt acknowledgements.
>> Making the lock per- IO-APIC would at least put a bound on the number
>> of competitors mutually interfering with each other, but a tighter
>> bound on the amount of work than NR_IRQS would be more useful than that.

On Mon, May 26, 2003 at 10:15:23PM -0400, Zwane Mwaikambo wrote:
> Ok there are 16 IOAPICs on an 8quad, but really if we start banging on 
> that lock someone is doing way too much hardware access...

It's done to acknowledge every interrupt. Also, there is additional
cost associated with bouncing the lock's cacheline.


-- wli
