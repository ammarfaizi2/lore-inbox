Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269885AbUICWTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269885AbUICWTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269875AbUICWTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:19:11 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:36558 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269885AbUICWRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:17:34 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: hpt366 ptr use before NULL check.
Date: Sat, 4 Sep 2004 00:17:07 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20040903211546.GY26419@redhat.com> <20040903215332.GA7812@redhat.com>
In-Reply-To: <20040903215332.GA7812@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409040017.08272.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bogus, hwif can't be NULL
please remove checks instead

On Friday 03 September 2004 23:53, Dave Jones wrote:
> On Fri, Sep 03, 2004 at 10:15:47PM +0100, Dave Jones wrote:
>  > Another picked up with the coverity checker.
>  > 
>  > Signed-off-by: Dave Jones <davej@redhat.com>
>  > 
>  > --- linux-2.6.8/drivers/ide/pci/hpt366.c~	2004-09-03 22:13:46.870500672 +0100
>  > +++ linux-2.6.8/drivers/ide/pci/hpt366.c	2004-09-03 22:14:53.095432952 +0100
>  > @@ -773,13 +773,17 @@
>  >  static int hpt3xx_tristate (ide_drive_t * drive, int state)
>  >  {
>  >  	ide_hwif_t *hwif	= HWIF(drive);
>  > -	struct pci_dev *dev	= hwif->pci_dev;
>  > -	u8 reg59h = 0, reset	= (hwif->channel) ? 0x80 : 0x40;
>  > -	u8 regXXh = 0, state_reg= (hwif->channel) ? 0x57 : 0x53;
>  > +	struct pci_dev *dev;
>  > +	u8 reg59h = 0, reset;
>  > +	u8 regXXh = 0, state_reg;
>  >  
>  >  	if (!hwif)
>  >  		return -EINVAL;
>  >  
>  > +	dev = hwif->pci_dev;
>  > +	reset = (hwif->channel) ? 0x80 : 0x40;
>  > +	state_reg = (hwif->channel) ? 0x57 : 0x53;
>  > +
>  >  //	hwif->bus_state = state;
>  >  
>  >  	pci_read_config_byte(dev, 0x59, &reg59h);
> 
> Oops, missed one.
> 
> 		Dave
> 
> 
> --- linux-2.6.8/drivers/ide/pci/hpt366.c~	2004-09-03 22:15:56.848740976 +0100
> +++ linux-2.6.8/drivers/ide/pci/hpt366.c	2004-09-03 22:16:33.470173672 +0100
> @@ -813,13 +813,14 @@
>  static int hpt370_busproc(ide_drive_t * drive, int state)
>  {
>  	ide_hwif_t *hwif	= HWIF(drive);
> -	struct pci_dev *dev	= hwif->pci_dev;
> +	struct pci_dev *dev;
>  	u8 tristate = 0, resetmask = 0, bus_reg = 0;
>  	u16 tri_reg;
>  
>  	if (!hwif)
>  		return -EINVAL;
>  
> +	dev = hwif->pci_dev;
>  	hwif->bus_state = state;
>  
>  	if (hwif->channel) { 
