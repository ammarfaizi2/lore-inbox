Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUDNVD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUDNVD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:03:57 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:53958 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261753AbUDNVBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:01:44 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Wed, 14 Apr 2004 23:01:33 +0200
User-Agent: KMail/1.6.1
Cc: Len Brown <len.brown@intel.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       ross@datscreative.com.au
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404142301.33153.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just would like to add that if we cannot get Maciej's 8259 ack patch
> back into the distro then we need an if statement in the check_timer()
> to turn off timer_ack for nforce2 or Christian might get his hi-load back
> and certainly nmi_debug=1 won't work.
>
> e.g. for 2.4.26-rc2 io_apic.c line 1613 or 2.6.5 line 2180
>       if (pin1 != -1) {
>               /*
>                * Ok, does IRQ0 through the IOAPIC work?
>                */
> +             if(acpi_skip_timer_override)
> +                     timer_ack=0;
>               unmask_IO_APIC_irq(0);
>

Also on mainline 2.6.5 this if-statement doesn't seem to be necessary. Len's 
patch worked on this kernel as well, setting the timer interrupt to 
IO-APIC-edge and there is no strange hi-load anymore too.

thanks, christian.
