Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVAJSwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVAJSwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVAJSvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:51:10 -0500
Received: from colin2.muc.de ([193.149.48.15]:9233 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262286AbVAJSor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:44:47 -0500
Date: 10 Jan 2005 19:44:37 +0100
Date: Mon, 10 Jan 2005 19:44:37 +0100
From: Andi Kleen <ak@muc.de>
To: Yinghai Lu <yhlu@tyan.com>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050110184437.GA74665@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:32:42AM -0800, Yinghai Lu wrote:
> Resend
> 
> Andi, 
> 
> I want to repeat the request:
> Please consider to compute the phy_proc_id with x86_apicid (or the initial
> apic id).

Not sure what you want me to do exactly. 

The phys_proc_id[] array? First that isn't really used for anything and then 
it is filled from CPUID 1 anyways. Or phys_pkg_id()? That uses cpuid too.

If you think something is wrong best you send a patch that makes it 
clear what you're talking about.
> 
> The reason is 
> Phy_proc_id will be used in smpboot.c to produce cpu_siblings_map.
> 
> The two systems I mentioned really exist.
> System 1. 8 ways dual core opteron system and with 3 io apic.
> System 2. 4 ways dual core opteron system and with 15 io apic (7 amd 8131
> and 1 amd 8111).
> 
> We have to lift the apicid of cpus to make io apic to use 0-15.

I don't understand why you want to do that. The IO-APIC and the local APIC ID 
space should separate as far as I know, so you could use 0 for both a CPU 
and an IO-APIC. But in theory it should work anyways even with an BSP 
CPU ID != 0.

> Case 1: lift core0/node0 to use 16, and core1/node0 to use 17.....
> Case 2: core0/node0-->0, core1/node0-->1, core0/node1-->18,
> core1/node1-->19...
> Case 3: core0/node0-->0, core1/node0-->17, core0/node1-->18,
> core1/node1-->19...
> 
> Case 1 will make jiffies not happy and it will hang on calibrate_dalay. (
> jiffies is not changing).

That's because it needs physical APIC mode to handle CPU IDs >7, and that is
 not implemented in the flat case. I added it now, but you likely don't need 
it anyways.

-Andi

