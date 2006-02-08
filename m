Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWBHAYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWBHAYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWBHAYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:24:39 -0500
Received: from mail.gmx.de ([213.165.64.21]:32957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030308AbWBHAYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:24:39 -0500
X-Authenticated: #271361
Date: Wed, 8 Feb 2006 01:24:34 +0100
From: Edgar Toernig <froese@gmx.de>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Manu Abraham <manu@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH 04/16] Fix [Bug 5895] to correct snd_87x autodetect
Message-Id: <20060208012434.10d927c4.froese@gmx.de>
In-Reply-To: <20060207153330.PS44220900004@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
	<20060207153330.PS44220900004@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:
>
> --- a/drivers/media/dvb/bt8xx/bt878.c
> +++ b/drivers/media/dvb/bt8xx/bt878.c
> @@ -381,6 +381,23 @@ bt878_device_control(struct bt878 *bt, u
>  
>  EXPORT_SYMBOL(bt878_device_control);
>  
> +
> +struct cards card_list[] __devinitdata = {
> +
> +	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,	"Nebula Electronics DigiTV" },
> +	{ 0x07611461, BTTV_BOARD_AVDVBT_761,	"AverMedia AverTV DVB-T 761" },
>[...]

I'm not very familiar with the pci configuration logic but
what's the point of this list and the BTTV_BOARD_xxx defines?
The defines are never used and the list is only used to let
the probe routine fail when the device is not in the list.

Wouldn't it be cleaner to add them to the pci_device_id
list further down instead of requesting all subsystem ids?

| static struct pci_device_id bt878_pci_tbl[] __devinitdata = {
|         {PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BROOKTREE_878,
|          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
|         {0,}
| };


Anyway, the bttv driver already has this information in his card
list (field has_dvb).  As long as the bt878 isn't stand alone
and requires the bttv driver wouldn't it be better to query its
table?


Even if this table is kept, it should be static and the variable
card_id in the probe routine should be renamed to pci_id as it
does not hold the card_id as defined in struct card but the pci_id.

Ciao, ET.
