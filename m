Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVHLLN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVHLLN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 07:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVHLLN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 07:13:56 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:36957 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932105AbVHLLNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 07:13:55 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,103,1122847200"; 
   d="scan'208"; a="13990044:sNHT26973548"
Message-ID: <42FC8461.2040102@fujitsu-siemens.com>
Date: Fri, 12 Aug 2005 13:13:37 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, wli@holomorphy.com
Cc: Gerhard Wichert <Gerhard.Wichert@fujitsu-siemens.com>
Subject: APIC version and 8-bit APIC IDs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William, hello everyone,

The MP_valid_apicid() function [arch/i386/kernel/mpparse.c] checks 
whether the APIC version field is >=20 in order to determine whether the 
CPU supports 8-bit physical APIC ids.

We currently have two modern processors oin our labs (Intel Xeon MP, AMD 
Dual-Core Opteron 875) for which this test is wrong because their APIC 
ids are both 16, but they _do_ support 8-bit APIC ids. This leads to 
erratic error messages and to valid CPUs not being detected.

Unfortunately I cannot tell why this is so, and what test should be used 
instead to make sure a CPU supports 8-bit APIC IDs.

The AMD BIOS and kernel developer's guide for Athlon64 and Opteron 
processors says

"When both ApicExtId and ApicExtBrdCst in the HyperTransport" 
Transaction Control Register are set, all 8 bits of APIC ID are used."

This refers to the TCR register. Reading that would require PCI 
configuration space access before the APICs are set up, I don't know if 
that's possible.
(http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26094.PDF)

The Intel Manual simply says
"For the Pentium 4 and Intel Xeon Processors, the xAPIC specification 
extends the local APIC field to 8 bits". The CPUs we have are Xeon MP 
(family 15, model 4); their local APIC version is 16, and they do 
support 8-bit APIC-IDs.

I guess it's up to the Intel an AMD people to have a final word on this,
but the current implementation is clearly wrong for these latest CPU types.

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
