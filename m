Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbTHYWwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTHYWwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:52:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262248AbTHYWwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:52:16 -0400
Date: Mon, 25 Aug 2003 23:52:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [CFT] Clean up yenta_socket
Message-ID: <20030825235210.J16790@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20030825003529.K16635@flint.arm.linux.org.uk> <3F4A9096.2000700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F4A9096.2000700@pobox.com>; from jgarzik@pobox.com on Mon, Aug 25, 2003 at 06:41:26PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 06:41:26PM -0400, Jeff Garzik wrote:
> WIBNI?

"wouldn't it be nice if"

> Anyway, MSI needs more than the standard size as well.
> 
> But I would actually prefer the interface to go the other way:
> 
> 	pci_save_state(pdev);
> 		and
> 	pci_restore_state(pdev);
> 
> Allocate and store the state in a pointer in struct pci_dev, or 
> somesuch.  And somebody other than the low-level driver figures out the 
> amount to save and restore.

Hmm.  The reason I wanted to stear clear of that was that sometimes we
don't know what's there.  Taking the yenta as an example, we know that
the "standard" space is 0x48 bytes long.  However, some devices have
extra control registers at 0x80, and then there's the PCI PM registers
up at around 0xa0 or so.

On a different cardbus bridge, the PCI PM registers might be somewhere
else.

Do we care if we overwrite the PCI PM registers with possibly old/stale
data?

In other words, how does the PCI layer itself know how much configuration
space to save and restore over power management calls?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

