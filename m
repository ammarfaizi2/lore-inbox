Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbVKRMcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVKRMcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbVKRMcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:32:39 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17806 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161064AbVKRMci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:32:38 -0500
Date: Fri, 18 Nov 2005 18:02:32 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, ak@suse.de,
       ebiederm@xmission.com
Subject: Re: [PATCH 2/10] kdump: dynamic per cpu allocation of memory for saving cpu registers
Message-ID: <20051118123232.GC7217@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117140138.454c59a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117140138.454c59a8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 02:01:38PM -0800, Andrew Morton wrote:
> 
> Please always generate diffs against the latest kernel!  I changed the
> patch to reflect the new location of ppc64's machine_kexec.c.
> 

Hi Andrew, I just noticed in 2.6.15-rc1-mm2 that ppc64/machine_kexec.c has
been moved to powerpc/machine_kexec_64.c. So my and your changes have not
taken effect.  I am attaching an incremental patch.

Thanks
Vivek



o The file ppc64/machine_kexec.c has now become powerpc/machine_kexec_64.c
  This patch removes the crash_notes definition from machine_kexec_64.c
  as crash_notes definition now has become architecture independent. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-mm2-1M-root/arch/powerpc/kernel/machine_kexec_64.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN arch/powerpc/kernel/machine_kexec_64.c~kdump-powerpc-remove-crash-notes arch/powerpc/kernel/machine_kexec_64.c
--- linux-2.6.15-rc1-mm2-1M/arch/powerpc/kernel/machine_kexec_64.c~kdump-powerpc-remove-crash-notes	2005-11-18 17:15:19.000000000 +0530
+++ linux-2.6.15-rc1-mm2-1M-root/arch/powerpc/kernel/machine_kexec_64.c	2005-11-18 17:15:45.000000000 +0530
@@ -28,9 +28,6 @@
 
 #define HASH_GROUP_SIZE 0x80	/* size of each hash group, asm/mmu.h */
 
-/* Have this around till we move it into crash specific file */
-note_buf_t crash_notes[NR_CPUS];
-
 /* Dummy for now. Not sure if we need to have a crash shutdown in here
  * and if what it will achieve. Letting it be now to compile the code
  * in generic kexec environment
_
