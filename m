Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVAKEIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVAKEIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVAKEHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:07:51 -0500
Received: from fmr23.intel.com ([143.183.121.15]:39897 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262393AbVAKEFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:05:10 -0500
Date: Mon, 10 Jan 2005 20:04:25 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Yinghai Lu <yhlu@tyan.com>, "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       jamesclv@us.ibm.com, Matt_Domsch@dell.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050110200425.B30630@unix-os.sc.intel.com>
References: <20050110184437.GA74665@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050110184437.GA74665@muc.de>; from ak@muc.de on Mon, Jan 10, 2005 at 07:44:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YH, I suggest you root cause the exact issue and if it turns out to
be a platform issue, then we can have a kernel workaround for that specific
platform. As Andi mentioned, we don't have any kernel limitations with
BSP apicid != 0.

On Mon, Jan 10, 2005 at 07:44:37PM +0100, Andi Kleen wrote:
> On Mon, Jan 10, 2005 at 10:32:42AM -0800, Yinghai Lu wrote:
> > Case 1: lift core0/node0 to use 16, and core1/node0 to use 17.....
> > Case 2: core0/node0-->0, core1/node0-->1, core0/node1-->18,
> > core1/node1-->19...
> > Case 3: core0/node0-->0, core1/node0-->17, core0/node1-->18,
> > core1/node1-->19...
> > 
> > Case 1 will make jiffies not happy and it will hang on calibrate_dalay. (
> > jiffies is not changing).
> 
> That's because it needs physical APIC mode to handle CPU IDs >7, and that is
>  not implemented in the flat case. I added it now, but you likely don't need 
> it anyways.

Andi, we don't need physical APIC mode just to handle CPU APIC ID's > 7
when the total number of cpu's in the system is < 8. Right?

thanks,
suresh
