Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753907AbWKFXFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbWKFXFa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 18:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbWKFXFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 18:05:30 -0500
Received: from kilderkin.sout.netline.net.uk ([213.40.66.40]:12787 "EHLO
	kilderkin.sout.netline.net.uk") by vger.kernel.org with ESMTP
	id S1753907AbWKFXFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 18:05:30 -0500
Message-ID: <454FBFB7.10102@supanet.com>
Date: Mon, 06 Nov 2006 23:05:27 +0000
From: Andrew Benton <b3nt@supanet.com>
User-Agent: Thunderbird 3.0a1 (X11/20061019)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 Microcode Update causes a ten second wait
References: <454FAA44.1080000@supanet.com> <1162850624.3138.83.camel@laptopd505.fenrus.org>
In-Reply-To: <1162850624.3138.83.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Supanet-AV-out: Mail Scanned as virus free, although you should still use a local virus scanner.
X-Supanet: This was sent via a www.supanet.com mail server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> you're lucky, for me it hangs forever until I add this patch:
> 
> --- linux-2.6.18/arch/i386/kernel/microcode.c.org	2006-11-06 14:50:37.000000000 +0100
> +++ linux-2.6.18/arch/i386/kernel/microcode.c	2006-11-06 14:52:30.000000000 +0100
> @@ -577,7 +577,7 @@ static void microcode_init_cpu(int cpu)
>  	set_cpus_allowed(current, cpumask_of_cpu(cpu));
>  	mutex_lock(&microcode_mutex);
>  	collect_cpu_info(cpu);
> -	if (uci->valid)
> +	if (uci->valid && system_state==SYSTEM_RUNNING)
>  		cpu_request_microcode(cpu);
>  	mutex_unlock(&microcode_mutex);
>  	set_cpus_allowed(current, old);
> 

Thanks, that patch fixes the problem for me.

Andy

