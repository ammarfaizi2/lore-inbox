Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSLQOXE>; Tue, 17 Dec 2002 09:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLQOXE>; Tue, 17 Dec 2002 09:23:04 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:3590 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265074AbSLQOXE>; Tue, 17 Dec 2002 09:23:04 -0500
Date: Tue, 17 Dec 2002 17:29:25 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, mj@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: disable decoding while sizing BARs
Message-ID: <20021217172925.A15754@jurassic.park.msu.ru>
References: <200212161741.53287.bjorn_helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212161741.53287.bjorn_helgaas@hp.com>; from bjorn_helgaas@hp.com on Mon, Dec 16, 2002 at 05:41:53PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 05:41:53PM -0700, Bjorn Helgaas wrote:
> +	/* Disable I/O & memory decoding while we size the BARs. */
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND,
> +		cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));

It's fatal for certain x86 northbridges, that's why the code was
removed 2 years ago.

Maybe it would be ok with this modification:

	pci_read_config_word(dev, PCI_COMMAND, &cmd);
	/* Don't touch northbridges or devices with devfn 0:0 */
	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_HOST && dev->devfn)
		pci_write_config_word(dev, PCI_COMMAND,
			cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));

Ivan.
