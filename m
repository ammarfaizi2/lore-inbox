Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbULWRE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbULWRE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 12:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULWRE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 12:04:57 -0500
Received: from siaag1aa.compuserve.com ([149.174.40.3]:19146 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261268AbULWREt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 12:04:49 -0500
Date: Thu, 23 Dec 2004 11:59:47 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.x BUGs at boot time (APIC related)
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <200412231203_MC3-1-919F-4F48@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> --- linux-2.6.10-rc3.src/arch/i386/kernel/apic.c.old  Mon Dec 20 14:13:59 2004
> +++ linux-2.6.10-rc3.src/arch/i386/kernel/apic.c      Thu Dec 23 08:54:13 2004
> @@ -1250,8 +1250,10 @@
>   */
>  int __init APIC_init_uniprocessor (void)
>  {
> -     if (enable_local_apic < 0)
> +     if (enable_local_apic < 0) {
>               clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
> +             return -1;
> +     }
>  
>       if (!smp_found_config && !cpu_has_apic)
>               return -1;


Mikael Pettersson wrote:

> The early return just hides the real bug, whatever it is.


How about this:

-       if (!smp_found_config && !cpu_has_apic)
+       if (!smp_found_config || !cpu_has_apic)

--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
