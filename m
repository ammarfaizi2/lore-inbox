Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVAHCiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVAHCiO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 21:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAHCiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 21:38:14 -0500
Received: from aun.it.uu.se ([130.238.12.36]:38655 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261623AbVAHCiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:38:09 -0500
Date: Sat, 8 Jan 2005 03:37:50 +0100 (MET)
Message-Id: <200501080237.j082booI005302@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: YhLu@tyan.com, ak@muc.de
Subject: Re: 256 apic id for amd64
Cc: Matt_Domsch@dell.com, discuss@x86-64.org, jamesclv@us.ibm.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005 22:12:00 +0100, Andi Kleen wrote:
>On Fri, Jan 07, 2005 at 01:14:24PM -0800, YhLu wrote:
>> After keep the bsp using 0, the jiffies works well. Werid?
>
>Probably a bug somewhere.  But since BSP should be always 
>0 I'm not sure it is worth tracking down.

I hope by "0" you're referring to a Linux kernel defined
software value and _not_ what the HW or BIOS conjured up!

Case in point: I was involved a while ago in tracking down
and fixing a local APIC enumeration bug in the x86-32 (i386)
kernel code, where the kernel failed miserably on some
dual K7 boxes because (a) only one CPU socket was populated,
(b) the BIOS assigned that CPU a non-zero ID, and (c) the
kernel (apic.c) had a bug which triggered when BSP ID != 0.

Never trust a BIOS to DTRT.

/Mikael
