Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTHSVin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbTHSVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:34:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5380 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261473AbTHSVcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:32:07 -0400
Date: Tue, 19 Aug 2003 22:32:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: jonsmirl@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Standard driver call to enable/disable PCI ROM
Message-ID: <20030819223203.I23670@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, jonsmirl@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20030819210618.D23670@flint.arm.linux.org.uk> <20030819204643.75442.qmail@web14913.mail.yahoo.com> <20030819215246.H23670@flint.arm.linux.org.uk> <20030819141735.52ffedc7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030819141735.52ffedc7.davem@redhat.com>; from davem@redhat.com on Tue, Aug 19, 2003 at 02:17:35PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 02:17:35PM -0700, David S. Miller wrote:
> On Tue, 19 Aug 2003 21:52:46 +0100
> Russell King <rmk@arm.linux.org.uk> wrote:
> >                 new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
> >                 reg = dev->rom_base_reg;
> 
> A word of caution, please do not enable PCI ROMs lightly.
> 
> There are many devices which stop responding to MEM and IO
> space once their ROM is enabled, Qlogic-ISP chips are one
> such device and there are several others.

Indeed - we leave the ROM enable bit in whatever state it was when
we scanned the device.

However, there are device drivers which want to access the ROM for
whatever reason, and we should provide a standard way to allow
drivers to enable / disable ROM access for architecture portability
reasons (so that VGA drivers can find tables in their ROMs for
instance.)

Since this is critical to some devices, maybe their drivers should
consider ensuring that the ROM resources are disabled upon driver
initialisation of the device?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

