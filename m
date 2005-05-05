Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVEEMFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVEEMFi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVEEMFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:05:38 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:22544 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262067AbVEEMF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:05:29 -0400
Message-ID: <427A0BBA.1080803@shadowen.org>
Date: Thu, 05 May 2005 13:04:10 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
CC: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com
Subject: Re: [2/3] add memory present for ppc64
References: <E1DTQVJ-0002WU-Fd@pinky.shadowen.org> <20050505023119.GA20283@austin.ibm.com>
In-Reply-To: <20050505023119.GA20283@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> On Wed, May 04, 2005 at 09:29:57PM +0100, Andy Whitcroft wrote:
> 
> 
>>diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/Kconfig current/arch/ppc64/Kconfig
>>--- reference/arch/ppc64/Kconfig	2005-05-04 20:54:50.000000000 +0100
>>+++ current/arch/ppc64/Kconfig	2005-05-04 20:54:50.000000000 +0100
>>@@ -212,8 +212,8 @@ config ARCH_FLATMEM_ENABLE
>> source "mm/Kconfig"
>> 
>> config HAVE_ARCH_EARLY_PFN_TO_NID
>>-	bool
>>-	default y
>>+	def_bool y
>>+	depends on NEED_MULTIPLE_NODES
> 
> 
> Ok, time to show my lack of undestanding here, but when can we ever be
> CONFIG_NUMA and NOT need multiple nodes?
> 
> 
>>@@ -481,6 +483,7 @@ static void __init setup_nonnuma(void)
>> 
>> 	for (i = 0 ; i < top_of_ram; i += MEMORY_INCREMENT)
>> 		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = 0;
>>+	memory_present(0, 0, init_node_data[0].node_end_pfn);
> 
> 
> Isn't the memory_present stuff and numa_memory_lookup_table two
> implementations doing the same thing (mapping memory to nodes)?
> Can we kill numa_memory_lookup_table with this?

This table basically is part of the DISCONTIGMEM implementation and used
lightly by SPARSEMEM.  In the i386 port we have already pushd that out
into a discontigmem implementation of memory_present.  That is a logical
next step in this port and I've got some of it already done.  That
should sit nicely on this lot.  I'll work on this one.

-apw
