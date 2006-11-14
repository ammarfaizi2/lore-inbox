Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755448AbWKNGs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755448AbWKNGs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbWKNGs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:48:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755448AbWKNGs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:48:57 -0500
Subject: Re: [2.6 patch] arch/i386/kernel/io_apic.c: handle a negative
	return value
From: Ingo Molnar <mingo@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20061113164256.805a7497.akpm@osdl.org>
References: <20061112174826.GC3382@stusta.de>
	 <20061113164256.805a7497.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 07:46:52 +0100
Message-Id: <1163486812.28401.42.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 16:42 -0800, Andrew Morton wrote:
>         pin  = find_isa_irq_pin(8, mp_INT);
> +       if (pin == -1) {
> +               printk(KERN_ERR "unlock_ExtINT_logic:
> find_isa_irq_pin()
> +                               "failed\n");
> +               return;
> +       }
>         apic = find_isa_irq_apic(8, mp_INT);
> -       if (pin == -1)
> +       if (apic == -1) {
> +               printk(KERN_ERR "unlock_ExtINT_logic:
> find_isa_irq_apic()
> +                               "failed\n");
>                 return;
> +       } 

as i mentioned it in my mail yesterday, if find_isa_irq_apic() returns
-1 then find_isa_irq_pin() has to return -1 too. But this is obscure and
needs to be documented at least - and your patch is good for
documentation purposes too :-)

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

