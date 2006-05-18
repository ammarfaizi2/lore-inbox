Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWERCx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWERCx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 22:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWERCx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 22:53:56 -0400
Received: from andromeda.dapyr.net ([69.45.6.104]:63169 "EHLO
	andromeda.dapyr.net") by vger.kernel.org with ESMTP
	id S1750785AbWERCxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 22:53:55 -0400
From: Konrad Rzeszutek <konradr@us.ibm.com>
Reply-To: konradr@us.ibm.com
To: linux-kernel@vger.kernel.org, konradr@redhat.com, konradr@us.ibm.com,
       arjan@linux.intel.com
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the e820 table.
Date: Wed, 17 May 2006 21:53:35 -0500
User-Agent: KMail/1.8.1
Organization: IBM Corp
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605172153.35878.konradr@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> There have been several machines that don't have a working MMCONFIG,
> often because of a buggy MCFG table in the ACPI bios. This patch adds a
> simple sanity check that detects a whole bunch of these cases, and when
> it detects it, linux now boots rather than crash-and-burns. 
> [snip]

Arjan,

I am not sure if your analysis and your solution to the problem is correct. 
It was my understanding that any memory NOT defined in the E820 tables 
is NOT considered system memory. Therefore memory addresses defined in the 
ACPI MCFG table do not have to show up in the E820 table.

Also the ACPI spec v3.0 (pg 405 of PDF, section 14.2, titled:
"E820 Assumptions and Limitations") agrees with this:

"The BIOS does not return a range description for the memory mapping
of PCI devices, ISA Option ROMs, and the ISA PNP cards because the OS
has mechanisms available to detect them."

(The ACPI v2.0c spec has this in section 15.2).

Obviously specifications are sometimes outdated, or assumptions are made in
some specifications which are not in other specification, so I was wondering 
if you could tell me which specification defines that the memory addresses 
in ACPI MCFG table have to be reserved in the E820 tables?

If this is not a specification issue, I was wondering if perhaps for the 
machines you refer to, their BIOS bug is that the E820 have memory ranges
which also encompass what MMCONF points to?

Thanks!

Konrad Rzeszutek
IBM, (617)-693-1718
