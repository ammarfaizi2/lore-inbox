Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUCDGUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUCDGUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:20:32 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:15035 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261466AbUCDGUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:20:30 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
Date: Thu, 4 Mar 2004 07:17:37 +0100
User-Agent: KMail/1.6
References: <1078287705197@kroah.com>
In-Reply-To: <1078287705197@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403040716.51298.ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Greg,

On Wednesday 03 March 2004 05:21, Greg KH wrote:
> -decl_subsys(pci_hotplug_slots, &hotplug_slot_ktype, NULL);
> -
> +/*
> + * We create a struct subsystem on our own and not use decl_subsys so
> + * we can have a sane name "slots" in sysfs, yet still keep a good
> + * global variable name "pci_hotplug_slots_subsys.
> + * If the decl_subsys() #define ever changes, this declaration will
> + * need to be update to make sure everything is initialized properly.
> + */
> +struct subsystem pci_hotplug_slots_subsys = {
> +	.kset = {
> +		.kobj = { .name = "slots" },
> +		.ktype = &hotplug_slot_ktype,
> +	}
> +};

How about creating a decl_subsys_name() for creating sane names,
like we have for the module parameters?

That whould solve all those problems, since this is used not only once.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARsoBU56oYWuOrkARAk0NAKDWSddUZQSD25ywMKs5zrpcrAJefACgjdV8
1d6axZhMy8k5qCozsrExrBc=
=sQZY
-----END PGP SIGNATURE-----
