Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTJWDlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 23:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTJWDlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 23:41:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:46784 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261626AbTJWDln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 23:41:43 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Fix x86 subarch breakage by the patch to allow more APIC irq sources
Date: Wed, 22 Oct 2003 20:41:34 -0700
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1066838206.1781.66.camel@mulgrave>
In-Reply-To: <1066838206.1781.66.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310222041.34245.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops!  You're right.  Sorry, for some reason I thought all the sub-arches 
would inherit the default definition.  Obviously that wasn't the case.

And, I like Linus' solution to it.


On Wednesday 22 October 2003 8:56 am, James Bottomley wrote:
> The problem with this patch was that it defined a new quantity
> NR_IRQ_VECTORS.  However, the definition of NR_IRQ_VECTORS is only in
> mach-default/irq_vectors.h.  Every subarch which defines it's own
> irq_vectors.h (that's voyager, visws and pc9800) now won't compile.
>
> I think the best fix is the attached (although you could clean up
> mach-default/irq_vectors.h with this too).
>
> James
>
> ===== include/asm-i386/irq.h 1.9 vs edited =====
> --- 1.9/include/asm-i386/irq.h	Wed Apr 23 02:49:34 2003
> +++ edited/include/asm-i386/irq.h	Wed Oct 22 10:49:21 2003
> @@ -15,6 +15,10 @@
>  /* include comes from machine specific directory */
>  #include "irq_vectors.h"
>
> +#ifndef NR_IRQ_VECTORS
> +#define NR_IRQ_VECTORS NR_IRQS
> +#endif
> +
>  static __inline__ int irq_canonicalize(int irq)
>  {
>  	return ((irq == 2) ? 9 : irq);

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
