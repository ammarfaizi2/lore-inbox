Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWH3LZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWH3LZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWH3LZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 07:25:34 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:53974 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1750748AbWH3LZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 07:25:34 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu
In-Reply-To: <44F50A0A.2040800@gentoo.org>
References: <1154091662.7200.9.camel@localhost.localdomain>
	 <44DE5A6F.50500@gentoo.org> <1156906638.3022.18.camel@localhost.portugal>
	 <44F50A0A.2040800@gentoo.org>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 12:25:28 +0100
Message-Id: <1156937128.2624.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 23:46 -0400, Daniel Drake wrote:
> Sergio Monteiro Basto wrote:
> > I remember check my emails that I send to Len Brown about this subject.
> > And I found, what I want, is just revert one patch of Bjorn Helgaas :)
> > between kernel 2.6.12-rc5 and 6.13.
> 
> It does look like this patch was under discussion of being reverted 
> before. See http://lkml.org/lkml/2005/9/26/183

To be honest, I prefer put again this :

 +#ifdef CONFIG_X86_IO_APIC
 +      if (nr_ioapics && !skip_ioapic_setup)
 +              return;
 +#endif
 +#ifdef CONFIG_ACPI
 +      if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
 +              return;
 +#endif

about Linus suggestion : 
-	new_irq = dev->irq & 0xf;
+	new_irq = dev->irq;
+	if (!new_irq || new_irq >= 15)
+		return;

no, we have problem with VIA SATA controllers which have irq lower than
15 

Thanks,

> 
> The following comment still stands when we just revert Bjorn's change:
> 
> >> I'm reasonably certain that this patch will apply the quirks on the 
> >> affected systems again, so I'm happy for it to be applied, people will 
> >> be able to use their hardware again. However I'm not sure how good a 
> >> solution it is, because in some circumstances it will apply the quirks 
> >> to VIA PCI cards on non-VIA boards, which was the reason we messed with 
> >> this code in the first place. We could possibly merge it with the 
> >> southbridge detection hack, but it gets a bit silly at that point...
> 
> So perhaps the best solution is a combination of reverting Bjorn's 
> patch, adding Linus' suggested change, and adding my southbridge hack.
> 
> Daniel

