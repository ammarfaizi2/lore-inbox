Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUHBWBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUHBWBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUHBWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:01:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8833 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264002AbUHBWBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:01:15 -0400
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Paul Jackson <pj@sgi.com>, zwane@linuxpower.ca,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040801134112.GU2334@holomorphy.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
	 <20040731232126.1901760b.pj@sgi.com>
	 <Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
	 <20040801124053.GS2334@holomorphy.com> <20040801060529.4bc51b98.pj@sgi.com>
	 <20040801131004.GT2334@holomorphy.com> <20040801063632.66c49e61.pj@sgi.com>
	 <20040801134112.GU2334@holomorphy.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091484032.4415.55.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 02 Aug 2004 15:00:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-01 at 06:41, William Lee Irwin III wrote:
> No problem.
> 
> 
> Index: hotplug-2.6.8-rc2/include/linux/cpumask.h
> ===================================================================
> --- hotplug-2.6.8-rc2.orig/include/linux/cpumask.h	2004-07-29 04:44:59.000000000 -0700
> +++ hotplug-2.6.8-rc2/include/linux/cpumask.h	2004-08-01 06:32:31.615472016 -0700
> @@ -207,13 +207,13 @@
>  #define first_cpu(src) __first_cpu(&(src), NR_CPUS)
>  static inline int __first_cpu(const cpumask_t *srcp, int nbits)
>  {
> -	return find_first_bit(srcp->bits, nbits);
> +	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
>  }
>  
>  #define next_cpu(n, src) __next_cpu((n), &(src), NR_CPUS)
>  static inline int __next_cpu(int n, const cpumask_t *srcp, int nbits)
>  {
> -	return find_next_bit(srcp->bits, nbits, n+1);
> +	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
>  }
>  
>  #define cpumask_of_cpu(cpu)						\

I'll add the nodemask.h fix here, too.

-Matt

--- linux-2.6.8-rc2-mm1/include/linux/nodemask.h	2004-07-28 10:50:51.000000000 -0700
+++ linux-2.6.8-rc2-mm1/include/linux/nodemask.h.fixed	2004-08-02 14:56:12.000000000 -0700
@@ -216,13 +216,13 @@ static inline void __nodes_shift_left(no
 #define first_node(src) __first_node(&(src), MAX_NUMNODES)
 static inline int __first_node(const nodemask_t *srcp, int nbits)
 {
-	return find_first_bit(srcp->bits, nbits);
+	return min_t(int, nbits, find_first_bit(srcp->bits, nbits));
 }
 
 #define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
 static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
 {
-	return find_next_bit(srcp->bits, nbits, n+1);
+	return min_t(int, nbits, find_next_bit(srcp->bits, nbits, n+1));
 }
 
 #define nodemask_of_node(node)						\


