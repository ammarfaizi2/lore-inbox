Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUGBXWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUGBXWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUGBXWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:22:24 -0400
Received: from hell.org.pl ([212.244.218.42]:34578 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S265096AbUGBXWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:22:23 -0400
Date: Sat, 3 Jul 2004 01:22:28 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Stefan Seyfried <seife@gmane0305.slipkontur.de>,
       swsusp-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [Swsusp-devel] Re: nvidia's driver and swsusp (need help w/ n forc e2 mobo)
Message-ID: <20040702232228.GA19080@hell.org.pl>
Mail-Followup-To: Terence Ripperda <tripperda@nvidia.com>,
	Stefan Seyfried <seife@gmane0305.slipkontur.de>,
	swsusp-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@suse.cz>
References: <20040702192044.GO1815@hygelac> <20040702200012.GU1815@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20040702200012.GU1815@hygelac>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Terence Ripperda:
> I tried hibernating/resuming while in X. but I don't see any acpi
> calls coming through to our driver via the pci driver model. is this
> expected?

I'm no PM expert, but I'm getting the idea that you're wrong at your
principles. 

To begin with, there's no such thing as acpi calls. There's driver model in
2.6 (i.e. pci_module_init() / pci_register_driver()), and there's 2.4's
lack of thereof (i.e. pm_register()). As far as I know, those two
interfaces have nothing specifically to do with ACPI nor APM. 

I think the proper way to conditionalize this in the code is to check for
CONFIG_PM as the prerequisite and KERNEL_2_6/!KERNEL_2_6 to choose between
those interfaces (and only that: bear in mind swsusp2 and pmdisk require
neither APM nor ACPI). Perhaps you're building with only CONFIG_PM defined?

Hopefully others will be able to clarify this.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
