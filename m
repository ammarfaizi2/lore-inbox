Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbULWJM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbULWJM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbULWJM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:12:58 -0500
Received: from holomorphy.com ([207.189.100.168]:43445 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261185AbULWJM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:12:56 -0500
Date: Thu, 23 Dec 2004 01:12:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x BUGs at boot time (APIC related)
Message-ID: <20041223091243.GA771@holomorphy.com>
References: <200412221731.20105.vda@port.imtp.ilyichevsk.odessa.ua> <200412231102.10171.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412231102.10171.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 December 2004 17:31, Denis Vlasenko wrote:
>>         if (!apic_id_registered())
>>                 BUG();   <=========================

On Thu, Dec 23, 2004 at 11:02:09AM +0000, Denis Vlasenko wrote:
> Tested with noapic nolapic boot params. Still happens.
> Call chain is init() -> APIC_init_uniprocessor() ->
> ->  setup_local_APIC(). I am a bit suspicious why
> APIC_init_uniprocessor() does not bail out
> if enable_local_apic<0 (i.e. if I boot with "nolapic"):
> int __init APIC_init_uniprocessor (void)
> {
>         if (enable_local_apic < 0)
>                 clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
> 		<===== missing "return -1"?
> 
>         if (!smp_found_config && !cpu_has_apic)
>                 return -1;
> ...

Sounds pretty serious. What happens if you add the missing return -1?

-- wli
