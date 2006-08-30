Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWHaDqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHaDqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 23:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWHaDqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 23:46:19 -0400
Received: from alnrmhc14.comcast.net ([206.18.177.54]:14073 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750709AbWHaDqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 23:46:19 -0400
Message-ID: <44F5B933.2010608@gentoo.org>
Date: Wed, 30 Aug 2006 12:13:39 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
References: <1154091662.7200.9.camel@localhost.localdomain>	 <44DE5A6F.50500@gentoo.org> <1156906638.3022.18.camel@localhost.portugal>	 <44F50A0A.2040800@gentoo.org> <1156937128.2624.6.camel@localhost.localdomain>
In-Reply-To: <1156937128.2624.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
>> It does look like this patch was under discussion of being reverted 
>> before. See http://lkml.org/lkml/2005/9/26/183
> 
> To be honest, I prefer put again this :
> 
>  +#ifdef CONFIG_X86_IO_APIC
>  +      if (nr_ioapics && !skip_ioapic_setup)
>  +              return;
>  +#endif
>  +#ifdef CONFIG_ACPI
>  +      if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
>  +              return;
>  +#endif

Isn't this exactly the same as what was being suggested?

> about Linus suggestion : 
> -	new_irq = dev->irq & 0xf;
> +	new_irq = dev->irq;
> +	if (!new_irq || new_irq >= 15)
> +		return;
> 
> no, we have problem with VIA SATA controllers which have irq lower than
> 15 

Any chance you can provide a link to this example so that we can 
document the decision in the commit message?

Thanks,
Daniel

