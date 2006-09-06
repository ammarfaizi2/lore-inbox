Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWIFNpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWIFNpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWIFNpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:45:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22509 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751010AbWIFNpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:45:50 -0400
Message-ID: <44FED108.7090301@in.ibm.com>
Date: Wed, 06 Sep 2006 19:15:44 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 5/13] BC: user interface (syscalls)
References: <44FD918A.7050501@sw.ru> <44FD9699.705@sw.ru>
In-Reply-To: <44FD9699.705@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Add the following system calls for BC management:
>  1. sys_get_bcid     - get current BC id
>  2. sys_set_bcid     - change exec_ and fork_ BCs on current
>  3. sys_set_bclimit  - set limits for resources consumtions 
>  4. sys_get_bcstat   - return br_resource_parm on resource
> 
> Signed-off-by: Pavel Emelianov <xemul@sw.ru>
> Signed-off-by: Kirill Korotaev <dev@sw.ru>
> 
> --- ./include/asm-powerpc/systbl.h.bcsys	2006-07-10 12:39:19.000000000 +0400
> +++ ./include/asm-powerpc/systbl.h	2006-09-05 12:47:21.000000000 +0400
> @@ -304,3 +304,7 @@ SYSCALL_SPU(fchmodat)
>  SYSCALL_SPU(faccessat)
>  COMPAT_SYS_SPU(get_robust_list)
>  COMPAT_SYS_SPU(set_robust_list)
> +SYSCALL(sys_get_bcid)
> +SYSCALL(sys_set_bcid)
> +SYSCALL(sys_set_bclimit)
> +SYSCALL(sys_get_bcstat)


Fix a build error for powerpc boxes. While compiling on powerpc, Vaidyanathan
Srinivasan caught this error. System calls on powerpc do not need sys_ prefix.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
Signed-off-by: Vaidyanathan Srinivasan <svaidy@in.ibm.com>
---

  include/asm-powerpc/systbl.h |    8 ++++----
  1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/asm-powerpc/systbl.h~fix-powerpc-build 
include/asm-powerpc/systbl.h
--- linux-2.6.18-rc5/include/asm-powerpc/systbl.h~fix-powerpc-build	2006-09-06 
19:03:18.000000000 +0530
+++ linux-2.6.18-rc5-balbir/include/asm-powerpc/systbl.h	2006-09-06 
19:03:38.000000000 +0530
@@ -304,7 +304,7 @@ SYSCALL_SPU(fchmodat)
  SYSCALL_SPU(faccessat)
  COMPAT_SYS_SPU(get_robust_list)
  COMPAT_SYS_SPU(set_robust_list)
-SYSCALL(sys_get_bcid)
-SYSCALL(sys_set_bcid)
-SYSCALL(sys_set_bclimit)
-SYSCALL(sys_get_bcstat)
+SYSCALL(get_bcid)
+SYSCALL(set_bcid)
+SYSCALL(set_bclimit)
+SYSCALL(get_bcstat)
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
