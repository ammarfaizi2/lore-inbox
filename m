Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265017AbSJWOVw>; Wed, 23 Oct 2002 10:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSJWOVv>; Wed, 23 Oct 2002 10:21:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:48578 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265017AbSJWOVu>; Wed, 23 Oct 2002 10:21:50 -0400
Date: Wed, 23 Oct 2002 07:25:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>, Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>, rusty@rustcorp.com.au
Subject: Re: 2.5.44-mm3
Message-ID: <2746454582.1035357946@[10.10.2.3]>
In-Reply-To: <20021023184317.A32662@in.ibm.com>
References: <20021023184317.A32662@in.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My machine did not boot with CONFIG_NR_CPUS = 4.  Same .config as one
> used for 2.5.44-mm2.  Could be the __node_to_cpu_mask redifinition from
> the larger-cpu-masks patch .... 

I think Rusty is asleep now, but he sent me this earlier ... want
to try it? I just cut & pasted, so you'll have to apply it by hand.
As it is, you'll get 0 size for NR_CPUS < 8 I think.

M.

2.5.44-mm3-node-fix/include/asm-generic/topology.h
--- linux-2.5.44-mm3/include/asm-generic/topology.h	2002-10-23 12:03:14.000000000 +1000
+++ working-2.5.44-mm3-node-fix/include/asm-generic/topology.h	2002-10-23 19:47:36.000000000 +1000
@@ -42,7 +42,7 @@
 #define __node_to_first_cpu(node)	(0)
 #endif
 #ifndef __node_to_cpu_mask
-#define __node_to_cpu_mask(mask, node)	(memset((mask), 0xFF, NR_CPUS/8))
+#define __node_to_cpu_mask(mask, node)	(memset((mask), 0xFF, (NR_CPUS+7)/8))
 #endif
 #ifndef __node_to_memblk
 #define __node_to_memblk(node)		(0)


