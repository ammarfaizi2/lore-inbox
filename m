Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVAHAP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVAHAP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVAHAPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:15:05 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:35741 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261743AbVAHAMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:12:47 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: YhLu <YhLu@tyan.com>
Subject: Re: 256 apic id for amd64
Date: Fri, 7 Jan 2005 16:12:43 -0800
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@muc.de>, Matt Domsch <Matt_Domsch@dell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       suresh.b.siddha@intel.com
References: <3174569B9743D511922F00A0C943142307291355@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C943142307291355@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501071612.43247.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clustered APIC systems need the phys_proc_id to come from the APIC ID 
register.  Intel prefers that non-clustered systems get their 
phys_proc_id from the cpuid opcode.

So, using c->x86_apicid is unlikely to satisfy both parties.


On Friday 07 January 2005 04:04 pm, YhLu wrote:
> arch/x86_64/kernel/setup.c
>
> static void __init detect_ht(struct cpuinfo_x86 *c)
>
>                 phys_proc_id[cpu] = phys_pkg_id(index_msb);
>
> --->
> 			  Phy_proc_id[cpu] = cpu_to_node[cpu];
> Or
>    	      // that is initial apicid
>           phys_proc_id[cpu] = c->x86_apicid >>
> hweight32(c->x86_num_cores - 1);
>
> YH
>
> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de]
> Sent: Friday, January 07, 2005 2:18 PM
> To: YhLu
> Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
> jamesclv@us.ibm.com; suresh.b.siddha@intel.com
> Subject: Re: 256 apic id for amd64
>
> On Fri, Jan 07, 2005 at 01:44:19PM -0800, YhLu wrote:
> > Can you consider to use c->x86_apicid to get phy_proc_id, that is
> > initial apicid.?
>
> Where?
>
> -Andi

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
