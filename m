Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311208AbSCLOO1>; Tue, 12 Mar 2002 09:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311209AbSCLOOR>; Tue, 12 Mar 2002 09:14:17 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:10145 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311208AbSCLOOF>; Tue, 12 Mar 2002 09:14:05 -0500
Date: Tue, 12 Mar 2002 15:58:07 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
        Adam K Kirchhoff <adamk@voicenet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP & APIC problem.
In-Reply-To: <132630000.1015893417@flay>
Message-ID: <Pine.LNX.4.44.0203121556530.32078-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin J. Bligh wrote:

> There's also an esr_disable flag variable I put in a while back
> when doing bringup of NUMA-Q to smack the ESR into submission. 
> You might want to try tweaking that on in smp.h. It's not like we
> actually do anything with the errors anyway. (all assuming my
> mind isn't faulty, and this is actually the same thing). The read / 
> write protocol for ESR is really .... wierd, and it seems to need
> smacking multiple times to accept a write.

We noticed that ;)

void __init setup_local_APIC (void)
{
        unsigned long value, ver, maxlvt;

        /* Pound the ESR really hard over the head with a big hammer - mbligh */
        if (esr_disable) {
                apic_write(APIC_ESR, 0);
                apic_write(APIC_ESR, 0);
                apic_write(APIC_ESR, 0);
                apic_write(APIC_ESR, 0);
        }

Cheers,
	Zwane


