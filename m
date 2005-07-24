Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVGXQKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVGXQKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 12:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVGXQKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 12:10:48 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:18123 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261383AbVGXQKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 12:10:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hYKkxO+xH5XrjiMrg/zO39sjzerELJqRcZ1eHvozi6xKOV0WNYmQMEjgwmA7VCDwGWFLmSW0vhgGsxDWgLUKPgmlvaG9sbwyaj7UHvTst/D3muFrNoSsNnmwSpyRZFhumNU3esNi18DG4OPx2M36CpR8RkrBcugxP3FdLgh/ugM=
Message-ID: <9a874849050724091051b62a81@mail.gmail.com>
Date: Sun, 24 Jul 2005 18:10:45 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: IRQ routing problem in 2.6.10-rc2
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.61.0507241711040.11580@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42E395F6.8070301@drzeus.cx>
	 <9a87484905072407164f0e0eb5@mail.gmail.com>
	 <Pine.LNX.4.61.0507241711040.11580@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> PCI: Using ACPI for IRQ routing
> >> ** PCI interrupts are no longer routed automatically.  If this
> >> ** causes a device to stop working, it is probably because the
> >> ** driver failed to call pci_enable_device().  As a temporary
> >> ** workaround, the "pci=routeirq" argument restores the old
> >> ** behavior.  If this argument makes the device work again,
> >> ** please email the output of "lspci" to bjorn.helgaas@hp.com
> >> ** so I can fix the driver.
> >Have you tried the suggestion given "... As a temporary workaround,
> >the "pci=routeirq" argument..." ?
> >You could also try the pci=noacpi boot option to see if that changes anything.
> 
> Hi,
> 
> and what's the proper fix for pci=routeirq? I got a driver that is only
> maintained by myself and would like to fix up the issue.
> 
While I don't /know/ exactely what the proper fix is I'll venture a
guess based on the information in the text above : The driver probably
doesn't call pci_enable_device().
Quoting the message at bootup time "If this causes a device to stop
working, it is probably because the driver failed to call
pci_enable_device().".
Also, the Kernel Janitors TODO list
(http://janitor.kernelnewbies.org/TODO) has this to say about
pci_enable_device() :
  - ALL PCI drivers should call pci_enable_device --before-- reading
    pdev->irq or pdev->resource[].  irq and resource[] may not have correct
    values until after PCI hotplug setup occurs at pci_enable_device()
    time.  Many PCI drivers need to be evaluated and checked for this.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
