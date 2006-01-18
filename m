Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWARC2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWARC2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWARC2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:28:33 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38559 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751369AbWARC2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:28:32 -0500
Message-ID: <43CDA761.5040707@jp.fujitsu.com>
Date: Wed, 18 Jan 2006 11:26:41 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kristen Accardi <kristen.c.accardi@intel.com>
CC: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
Subject: Re: [Pcihpd-discuss] [patch 2/4]  acpiphp: handle dock bridges
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy>
In-Reply-To: <1137545819.19858.47.camel@whizzy>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
> +					struct pci_dev *dev)
> +{
> +	struct list_head *l;
> +	struct acpiphp_func *func;
> +	struct pci_bus *bus = slot->bridge->pci_bus;
> +
> +	list_for_each (l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);
> +		if (pci_get_slot(bus, PCI_DEVFN(slot->device,
> +					func->function)) == dev)
> +			return func;
> +	}

This seems to leak reference counter of pci_dev. I think you
must call pci_dev_put() also.

Thanks,
Kenji Kaneshige
