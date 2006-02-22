Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWBVQUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWBVQUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBVQUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:20:00 -0500
Received: from fmr22.intel.com ([143.183.121.14]:37003 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751357AbWBVQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:19:59 -0500
Message-Id: <200602221619.k1MGJog18578@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: IA64 non-contiguous memory space bugs
Date: Wed, 22 Feb 2006 08:19:51 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcY3RTV2RLzpbjZmR9yMXCkSFsznyAAQF+lg
In-Reply-To: <20060222001359.GA23574@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> --- working-2.6.orig/include/linux/mm.h	2004-09-07 10:38:00.000000000 +1000
> +++ working-2.6/include/linux/mm.h	2004-09-24 15:02:18.172776168 +1000
> @@ -41,6 +41,13 @@
>  #define MM_VM_SIZE(mm)	TASK_SIZE
>  #endif
>  
> +#ifndef REGION_MAX
> +#define REGION_MAX(addr)	TASK_SIZE
> +#endif
> +
> +#define GOOD_TASK_VM_RANGE(addr, len) \
> +	( ((addr)+(len) >= (addr)) || ((addr)+(len) <= TASK_SIZE) \
> +	  || ((addr)+(len) <= REGION_MAX(addr)) )

Looks like the logic is reversed, should be && instead of ||.

- Ken

