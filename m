Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751694AbWCCXnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWCCXnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWCCXnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:43:39 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:49825 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751202AbWCCXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:43:37 -0500
Date: Fri, 3 Mar 2006 18:43:30 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060303234330.GA14401@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
	Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
	Ingo Molnar <mingo@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <200603011647.34516.ak@suse.de> <20060301180714.GD20092@ti64.telemetry-investments.com> <200603011929.59307.ak@suse.de> <1141240611.5860.176.camel@mindpipe> <20060303191822.GE32407@ti64.telemetry-investments.com> <1141421204.3042.139.camel@mindpipe> <4408BEB5.7000407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4408BEB5.7000407@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 05:09:57PM -0500, Jeff Garzik wrote:
> Or sata_nv/libata is to blame.
 
In case you are coming late to the thread:

The lost ticks are closely correlated with sata_nv disk activity on
multiple disks, and the problem is easily reproducable with "find /usr |
cpio -o >/dev/null" on an MD RAID1 -- but not on a single disk.

Andi suggested:

   Yes, I bet something forgets to turn on interrupts again and it's
   picked up by (and blamed on) the next guy who does an unconditional
   sti, which happens to be __do_sofitrq or idle.

That sounds right to me.

I built 2.6.16-rc5-git6 yesterday, and it still suffers from the same
issue.

	-Bill
