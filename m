Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVAHAjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVAHAjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAHAjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:39:32 -0500
Received: from mail.tyan.com ([66.122.195.4]:58889 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261693AbVAHAjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 19:39:08 -0500
Message-ID: <3174569B9743D511922F00A0C94314230729135E@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>, James Cleverdon <jamesclv@us.ibm.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 16:50:43 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But the result looks ugly

I keep core0 and core1 of node0 to use 0/1 got

4407.29 BogoMIPS (lpj=2203648)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 7 -> Node 3
phy_proc_id[0] = 0
phy_proc_id[1] = 0
phy_proc_id[2] = 9
phy_proc_id[3] = 9
phy_proc_id[4] = 10
phy_proc_id[5] = 10
phy_proc_id[6] = 11
phy_proc_id[7] = 11
CPU: Physical Processor ID: 11
 stepping 00
Total of 8 processors activated (35209.21 BogoMIPS).
If only keep core0/node0 to use 0.

Will get
phy_proc_id[0] = 0
phy_proc_id[1] = 8
phy_proc_id[2] = 9
phy_proc_id[3] = 9
phy_proc_id[4] = 10
phy_proc_id[5] = 10
phy_proc_id[6] = 11
phy_proc_id[7] = 11

it separate core0 and core1 of node 1

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Friday, January 07, 2005 4:34 PM
To: James Cleverdon
Cc: YhLu; Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Fri, Jan 07, 2005 at 04:26:57PM -0800, James Cleverdon wrote:
> Already done, although not dividing along AMD vs. Intel lines.  
> phys_pkg_id() indirects through the subarch table.  See 
> genapic_cluster.c and genapic_flat.c for details.
> 
> We may need a third subarch for AMD's Extended APIC mode boxes.

I'm not convinced we do. Things seem to work with BSP APIC-ID = 0.
Is there any real reason to not just require that?

> 
> Can you suggest some heuristics for detecting such a system and 
> discerning it from a clustered APIC box?  (Hopefully, without using MPS 
> or ACPI table ID string lookups.)

Early PCI scan would work in the worst case. All Opterons have a builtin
northbridge with a specific ID.  There is already other code that 
checks for these.

-Andi
