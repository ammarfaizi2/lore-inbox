Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWCPPI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWCPPI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWCPPI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:08:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45456 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751213AbWCPPI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:08:27 -0500
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
	ticks on PM timer]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060315220046.GA20469@elte.hu>
References: <200602280022.40769.darkray@ic3man.com>
	 <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
	 <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu>
	 <20060315220046.GA20469@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2006 15:13:39 +0000
Message-Id: <1142522019.13318.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-03-15 at 23:00 +0100, Ingo Molnar wrote:
> so my guess would be that this device doesnt do MMIO, and the PIO inb() 
> causes some bad BIOS-based SMM handler/emulator to trigger, which takes 
> 16.6 msecs. If indeed the device is not in MMIO mode, is there a way to 
> force it into MMIO mode, to test this theory?

There is a much more reliable way to check this. Use the profiling
registers to check the instruction issue count before/after the I/O and
you'll know if its something like SMM or just a bus stall.

I can believe the bus stall because some devices will queue a large FIFO
of data for the disk and the status read may require flushing it all
out.

