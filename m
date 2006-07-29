Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWG2CGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWG2CGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWG2CGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:06:22 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25929 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030250AbWG2CGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:06:21 -0400
Date: Fri, 28 Jul 2006 20:04:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-reply-to: <1154112339.037481.119210@p79g2000cwp.googlegroups.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: iforone <floydstestemail@yahoo.com>
Message-id: <44CAC249.1010605@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1153931278.034068.54630@h48g2000cwc.googlegroups.com>
 <1153933737.200164.160870@m73g2000cwd.googlegroups.com>
 <1154007393.940693.259680@i42g2000cwa.googlegroups.com>
 <1154112339.037481.119210@p79g2000cwp.googlegroups.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iforone wrote:
> see why above (mostly)... That doesn't necessarily mean that some kind
> of certain 'config' doesn't need to be compiled into the kernel. Yet
> I'm not sure exactly which options are necessary, if any, nor am I sure
> you can achieve your goal using what *seems* (Robert Hancock's
> reponses) to be essentially an Intel DualCore 32bit CPU(s). I'm having
> a bit of trouble understanding (or believing) that an EM64T system
> isn't capable of seeing more than 4GB RAM (although the Mobo max for
> that Desktop mobo is 4GB) -- BUT then again, that is not a Server grade
> Mobo either -- it's a Desktop mobo (perhaps using an
> unsupporting(cheaper) Chipset(?). Yet; the BIOS detects all 4GB (which
> shoots down my chipset theory) - so maybe it's a kerenl specific issue
> (harkens back to General S's response about 2.6.15+ kernels only).
> In my earlier post, I hadn't realized you were using a 64bit kernel.

The BIOS can see that all 4GB of memory is there, but it has no way of 
moving it out of the way to make room for the PCI/PCI-E memory-mapped IO 
space, so it has to map that IO space over the RAM in that part of the 
address space, rendering it inaccessible. There's no way that the kernel 
can fix this, regardless of whether you are using 32 or 64 bit or what 
configuration options are set.

Athlon 64/Opteron CPUs have support for moving this part of the RAM 
above 4GB to allow it to be used. This is part of the CPU's on-die 
memory controller so no special chipset support is needed. On Intel 
systems this support has to be provided by the chipset, and on the 
desktop boards, it's not.

You can see what's going on from the BIOS e820 memory map that's printed 
in the dmesg output at the start of bootup. If you calculate out the 
amount of address space reported as "usable" then you will get your 
value of 3.2GB or so which is all the kernel has access to. If the 
system supported memory remapping then you would see another region 
starting at 0x0000000100000000 (4GB) which would account for this 
missing 800MB or so.

Probably the main reason Intel didn't bother including this support in 
the desktop boards is that current non-server versions of Windows (at 
least 32-bit) won't use any memory that is mapped above 4GB anyway even 
though PAE is enabled - a purely artificial limit that MS put in place 
to discourage using desktop Windows on such large memory machines..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

