Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWI2N0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWI2N0K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 09:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWI2N0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 09:26:09 -0400
Received: from smtp7.libero.it ([193.70.192.90]:30876 "EHLO smtp7.libero.it")
	by vger.kernel.org with ESMTP id S1751334AbWI2N0H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 09:26:07 -0400
Date: Fri, 29 Sep 2006 15:26:04 +0200
Message-Id: <J6CVZG$70B56AF5DA3ACEC3A5A6E0B89CE334E2@libero.it>
Subject: patch needed in traps.c for linux-abi
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "mtassinari\@libero\.it" <mtassinari@libero.it>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
X-XaM3-API-Version: 4.3 (R1) (B3pl17)
X-SenderIP: 195.110.141.30
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs, 

Trying to keep the linux-abi (a patch to the linux kernel 
that allows a linux system to run foreign binaries see 
sourceforge.net/projects/linux-abi) run with current kernels, 
a change must be done to arch/i386/kernel/traps.c.

the patch commit 522e93e3fcdbf00ba85c72fde6df28cfc0486a65 modified descriptor and trap table. 

Could somebody suggest how to change the following code:

static void __init set_call_gate(void *a, void *addr)
{
        _set_gate(a,12,3,addr,__KERNEL_CS);
}

needed in the linux-abi patched traps.c to conform to the new ceanups?

It should probably look like:

static void __init set_call_gate(void *a, void *addr)
{
        _set_gate(a, 0xnn | DESCTYPE_DPL3, addr, __KERNEL_CS); }

with some value for 0xnn, formerly 12.

Any help will be greatly appreciated.

Regards

Mauro Tassinari

mtassinari@cmanet.it


