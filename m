Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbUJ1X55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbUJ1X55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUJ1Xn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:43:59 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45517 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263092AbUJ1XfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:35:25 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: Chris Wright <chrisw@osdl.org>, ak@suse.de
Subject: Re: [PATCH] clustered apic patch missing APIC_DFR_CLUSTER def
Date: Thu, 28 Oct 2004 16:35:23 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20041028112715.D14339@build.pdx.osdl.net>
In-Reply-To: <20041028112715.D14339@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281635.23848.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm...  The patch containing APIC_DFR_CLUSTER and friends went
into the -mm tree in the June/July timeframe.  It must not have
been pushed with the main cluster patch.

You're right, we're using the generic version of
cpu_present_to_apicid().  The cluster one can go.


On Thursday 28 October 2004 11:27 am, Chris Wright wrote:
> The cluster apic support does not compile.  I added the
> APIC_DFR_CLUSTER def to asm-x86_64/apicdef.h (stolen from i386 one). 
> Also added APIC_DFR_FLAT while there.  This may only be papering over
> real fix.
>
> Additionally, cluster_cpu_present_to_apicid() is defined but not used
> anywhere.  So remove it.
>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
>
> ===== include/asm-x86_64/apicdef.h 1.6 vs edited =====
> --- 1.6/include/asm-x86_64/apicdef.h	2004-10-28 00:39:50 -07:00
> +++ edited/include/asm-x86_64/apicdef.h	2004-10-28 11:15:19 -07:00
> @@ -32,6 +32,8 @@
>  #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
>  #define			APIC_ALL_CPUS		0xFFu
>  #define		APIC_DFR	0xE0
> +#define			APIC_DFR_CLUSTER		0x0FFFFFFFu
> +#define			APIC_DFR_FLAT			0xFFFFFFFFu
>  #define		APIC_SPIV	0xF0
>  #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
>  #define			APIC_SPIV_APIC_ENABLED		(1<<8)
> ===== arch/x86_64/kernel/genapic_cluster.c 1.1 vs edited =====
> --- 1.1/arch/x86_64/kernel/genapic_cluster.c	2004-10-28 00:39:50
> -07:00 +++ edited/arch/x86_64/kernel/genapic_cluster.c	2004-10-28
> 11:18:10 -07:00 @@ -57,14 +57,6 @@
>  	apic_write_around(APIC_LDR, val);
>  }
>
> -static int cluster_cpu_present_to_apicid(int mps_cpu)
> -{
> -	if ((unsigned)mps_cpu < NR_CPUS)
> -		return (int)bios_cpu_apicid[mps_cpu];
> -	else
> -		return BAD_APICID;
> -}
> -
>  /* Start with all IRQs pointing to boot CPU.  IRQ balancing will
> shift them. */
>
>  static cpumask_t cluster_target_cpus(void)

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

