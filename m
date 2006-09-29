Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWI2NiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWI2NiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 09:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWI2NiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 09:38:10 -0400
Received: from vmaila.mclink.it ([195.110.128.108]:25356 "EHLO
	vmaila.mclink.it") by vger.kernel.org with ESMTP id S964863AbWI2MeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:34:05 -0400
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: <rusty@rustcorp.com.au>, <andi@basil.nowhere.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: patch needed in traps.c for linux-abi
Date: Fri, 29 Sep 2006 14:33:50 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAA29r/sWKdAk6N1kbiT0APrAEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs, 

Trying to keep the linux-abi (a patch to the linux kernel 
that allows a linux system to run foreign binaries see 
http://sourceforge.net/projects/linux-abi) run with current kernels,
a change must be done to arch/i386/kernel/traps.c.

the patch commit 522e93e3fcdbf00ba85c72fde6df28cfc0486a65 modified
descriptor and trap table. 

Could somebody suggest how to change the following code:

static void __init set_call_gate(void *a, void *addr)
{
        _set_gate(a,12,3,addr,__KERNEL_CS);
}

needed in the linux-abi patched traps.c to conform to the new ceanups?

It should probably look like:

static void __init set_call_gate(void *a, void *addr)
{
        _set_gate(a, 0xnn | DESCTYPE_DPL3, addr, __KERNEL_CS);
}

with some value for 0xnn, formerly 12.

Any help will be greatly appreciated.

Regards

Mauro Tassinari

