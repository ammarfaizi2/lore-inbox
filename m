Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUJXSna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUJXSna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUJXSna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:43:30 -0400
Received: from gold.pobox.com ([208.210.124.73]:30605 "EHLO gold.pobox.com")
	by vger.kernel.org with ESMTP id S261234AbUJXSn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:43:27 -0400
Subject: Re: [KJ] [PATCH 2.6] cyclades.c: replace pci_find_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <267570000.1098383749@w-hlinder.beaverton.ibm.com>
References: <267570000.1098383749@w-hlinder.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1098643610.4188.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 24 Oct 2004 11:46:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 11:35, Hanna Linder wrote:
> diff -Nrup linux-2.6.9cln/drivers/char/cyclades.c linux-2.6.9patch/drivers/char/cyclades.c
> --- linux-2.6.9cln/drivers/char/cyclades.c	2004-10-18 16:35:53.000000000 -0700
> +++ linux-2.6.9patch/drivers/char/cyclades.c	2004-10-20 15:31:49.803025392 -0700
> @@ -4765,7 +4765,7 @@ cy_detect_pci(void)
>          for (i = 0; i < NR_CARDS; i++) {
>                  /* look for a Cyclades card by vendor and device id */
>                  while((device_id = cy_pci_dev_id[dev_index]) != 0) {
> -                        if((pdev = pci_find_device(PCI_VENDOR_ID_CYCLADES,
> +                        if((pdev = pci_get_device(PCI_VENDOR_ID_CYCLADES,
>                                          device_id, pdev)) == NULL) {
>                                  dev_index++;    /* try next device id */
>                          } else {

If there are NR_CARDS (or more) in the system, this will leave a pdev on
the table.  A pci_dev_put after the for-loop should catch it.

-scott

