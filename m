Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVHFNF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVHFNF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 09:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVHFNF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 09:05:59 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:19091 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261845AbVHFNF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 09:05:57 -0400
Date: Sat, 6 Aug 2005 15:05:56 +0200
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_infineon: Support for new TPM 1.2 and PNPACPI
Message-ID: <20050806130556.GA9707@mut38-1-82-67-62-65.fbx.proxad.net>
Reply-To: 42F1EE69.4000108@crypto.rub.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +From/* read IO-ports from ACPI */
> +Frompnp_register_driver(&tpm_inf_pnp);
> +Frompnp_unregister_driver(&tpm_inf_pnp);

This seem very broken : in pnp unregister, pnp
will try to free the resource of the device, so you _can't_ safely use the
resource you probe after pnp_unregister_driver.
Please call pnp_unregister_driver in your remove routine.

Also mixing pnp and pci device is a very bad idea. You should try to
split it if you can.

Matthieu
