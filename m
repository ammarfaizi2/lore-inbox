Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUDBWZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUDBWZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:25:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22493 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261221AbUDBWZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:25:21 -0500
Subject: Re: [Patch 6/23] mask v2 - Replace cpumask_t with one using mask
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040401131136.792495fa.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
	 <20040401131136.792495fa.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-peOxaTSCWUCvdUT91V7S"
Organization: IBM LTC
Message-Id: <1080944675.9787.113.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Apr 2004 14:24:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-peOxaTSCWUCvdUT91V7S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-04-01 at 13:11, Paul Jackson wrote:
> Patch_6_of_23 - Rework cpumasks to use new mask ADT
> 	Removes many old include/asm-<arch> and asm-generic cpumask files
> 	Add intersects, subset, xor and andnot operators.
> 	Provides temporary emulators for obsolete const, promote, coerce
> 	Presents entire cpumask API clearly in single cpumask.h file

<snip>

> +#else /* !CONFIG_SMP */
> +
> +#define	cpu_online_map		     cpumask_of_cpu(0)
> +#define	cpu_possible_map	     cpumask_of_cpu(0)

I mentioned earlier that there's probably a better way to do this for
UP...  What do you think about this?

-Matt

--=-peOxaTSCWUCvdUT91V7S
Content-Disposition: attachment; filename=UP-cpu_online_map.patch
Content-Type: text/x-patch; name=UP-cpu_online_map.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-pj_mask_v2/include/linux/cpumask.h linux-2.6.4-UP_online_map/include/linux/cpumask.h
--- linux-2.6.4-pj_mask_v2/include/linux/cpumask.h	Fri Apr  2 14:03:21 2004
+++ linux-2.6.4-UP_online_map/include/linux/cpumask.h	Fri Apr  2 14:13:54 2004
@@ -134,8 +134,12 @@ extern cpumask_t cpu_possible_map;
 
 #else /* !CONFIG_SMP */
 
-#define	cpu_online_map		     cpumask_of_cpu(0)
-#define	cpu_possible_map	     cpumask_of_cpu(0)
+#define	cpu_online_map				\
+({						\
+	cpumask_t m = MASK_ALL1(NR_CPUS);	\
+	m;					\
+})
+#define	cpu_possible_map	     cpu_online_map
 
 #define num_online_cpus()	     1
 #define num_possible_cpus()	     1

--=-peOxaTSCWUCvdUT91V7S--

