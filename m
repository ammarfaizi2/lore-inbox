Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUEDVMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUEDVMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbUEDVMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:12:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264424AbUEDVKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:10:45 -0400
Message-ID: <409806C6.3060300@pobox.com>
Date: Tue, 04 May 2004 17:10:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Allen Martin <AMartin@nvidia.com>, linux-kernel@vger.kernel.org,
       Ross Dickson <ross@datscreative.com.au>,
       Len Brown <len.brown@intel.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FC2D@mail-sc-6-bk.nvidia.com> <200405040111.01514.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405040111.01514.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> +/*
> + * Fixup for C1 Halt Disconnect problem on nForce2 systems.
> + *
> + * From information provided by "Allen Martin" <AMartin@nvidia.com>:
> + *
> + * A hang is caused when the CPU generates a very fast CONNECT/HALT cycle
> + * sequence.  Workaround is to set the SYSTEM_IDLE_TIMEOUT to 80 ns.
> + * This allows the state-machine and timer to return to a proper state within
> + * 80 ns of the CONNECT and probe appearing together.  Since the CPU will not
> + * issue another HALT within 80 ns of the initial HALT, the failure condition
> + * is avoided.
> + */
> +static void __devinit pci_fixup_nforce2(struct pci_dev *dev)


Minor nit:  is __devinit really needed?

You're changing a northbridge or a southbridge, not a PCI card, I 
presume...?  That would only need to be done once, when the kernel is 
booted, regardless of CONFIG_HOTPLUG AFAICS.

	Jeff



