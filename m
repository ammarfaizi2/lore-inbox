Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWHBVny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWHBVny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWHBVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:43:54 -0400
Received: from smtp.ono.com ([62.42.230.12]:59113 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932240AbWHBVnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:43:53 -0400
Date: Wed, 2 Aug 2006 23:43:44 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: sergio@sergiomb.no-ip.org
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [2.6.18-rc2-mm1] pata_via fails
Message-ID: <20060802234344.6c2bf2b9@werewolf.auna.net>
In-Reply-To: <1154474307.3819.5.camel@localhost.portugal>
References: <20060802010415.2bebc5fc@werewolf.auna.net>
	<1154474307.3819.5.camel@localhost.portugal>
X-Mailer: Sylpheed-Claws 2.4.0cvs16 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 00:18:27 +0100, Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> On Wed, 2006-08-02 at 01:04 +0200, J.A. Magallón wrote:
> > Jul 10 15:09:46 nada kernel: PCI: VIA IRQ fixup for 0000:00:11.1, from
> > 255 to 0
> > Any ideas ?
> yes, try this patch
> http://lkml.org/lkml/2006/7/28/99
> As you are using -mm tree use just hunk #1 above
> 
> --- linux-2.6.17.i686/drivers/pci/quirks.c.orig	2006-07-28 12:59:04.000000000 +0100
> +++ linux-2.6.17.i686/drivers/pci/quirks.c	2006-07-28 13:26:49.000000000 +0100
> @@ -648,11 +648,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_V
>   *
>   * Some of the on-chip devices are actually '586 devices' so they are
>   * listed here.
> + * 
> + * if flags say that we have working apic(s), we don't need to quirk these
> + * devices
>   */
>  static void quirk_via_irq(struct pci_dev *dev)
>  {
>  	u8 irq, new_irq;
>  
> +	if ((smp_found_config && !skip_ioapic_setup && nr_ioapics) || cpu_has_apic)
> +		return;
> +
>  	new_irq = dev->irq & 0xf;
>  	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
>  	if (new_irq != irq) {
> 

Sorry, it did not help :(.


--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam05 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #2 SMP PREEMPT
