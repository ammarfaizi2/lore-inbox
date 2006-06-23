Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWFWN5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWFWN5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWFWN5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:39 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:17643 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750753AbWFWN50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:57:26 -0400
Date: Fri, 23 Jun 2006 09:53:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: 2.6.17: Yet another .config that won't build
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200606230954_MC3-1-C33F-7BD7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, selecting SMP, HIGHMEM64G and X86_GENERICARCH enables NUMA.
Then selecting NUMA automatically selects ACPI_SRAT even when ACPI
is unselected.  The resulting .config won't build:

arch/i386/kernel/srat.c: In function `parse_cpu_affinity_structure':
arch/i386/kernel/srat.c:70: error: dereferencing pointer to incomplete type

static void __init parse_cpu_affinity_structure(char *p)
{
        struct acpi_table_processor_affinity *cpu_affinity =
                                (struct acpi_table_processor_affinity *) p;

70 ===> if (!cpu_affinity->flags.enabled)
                return;         /* empty entry */

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
