Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTEFSBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTEFSBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:01:04 -0400
Received: from fmr01.intel.com ([192.55.52.18]:32485 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263891AbTEFSBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:01:02 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A84725A28E@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Andrew Morton <akpm@digeo.com>, Nicolas <linux@1g6.biz>
Cc: linux-kernel@vger.kernel.org
Subject: RE: oops 2.5.68 ohci1394/ IRQ/acpi
Date: Tue, 6 May 2003 11:13:18 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ohhh so we need to not just return nonzero, but return 1 (aka
IRQ_HANDLED?) Well, then this makes sense. Sorry about that.

btw I think the line in handle_IRQ_event that reads

if (retval != 1) {

should be

if (retval != IRQ_HANDLED) {

but that's just a nit.

Regards -- Andy

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@digeo.com] 
> Sent: Monday, May 05, 2003 2:16 PM
> To: Nicolas
> Cc: linux-kernel@vger.kernel.org; Grover, Andrew
> Subject: Re: oops 2.5.68 ohci1394/ IRQ/acpi
> Importance: High
> 
> 
> Nicolas <linux@1g6.biz> wrote:
> >
> > 
> > May  5 13:36:56 hal9003 kernel: irq 9: nobody cared!
> > ...
> > May  5 13:36:56 hal9003 kernel: handlers:
> > May  5 13:36:56 hal9003 kernel: [acpi_irq+0/17] (acpi_irq+0x0/0x11) 
> > May  5 13:36:56 hal9003 kernel: [<c01c1ff0>] (acpi_irq+0x0/0x11)
> 
> Look like the ACPI IRQ handler isn't returning an appropriate value.
> 
> Can you test this patch?
> 
> diff -puN drivers/acpi/osl.c~acpi-irq-ret-fix drivers/acpi/osl.c
> --- 25/drivers/acpi/osl.c~acpi-irq-ret-fix	Mon May  5 14:14:24 2003
> +++ 25-akpm/drivers/acpi/osl.c	Mon May  5 14:14:38 2003
> @@ -237,7 +237,7 @@ acpi_os_table_override (struct acpi_tabl  
> static irqreturn_t  acpi_irq(int irq, void *dev_id, struct 
> pt_regs *regs)  {
> -	return (*acpi_irq_handler)(acpi_irq_context);
> +	return (*acpi_irq_handler)(acpi_irq_context) ? 
> IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  acpi_status
> 
> _
> 
