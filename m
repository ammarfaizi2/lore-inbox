Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269883AbUJTIYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269883AbUJTIYv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbUJTIXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:23:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50694 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270163AbUJTIK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:10:58 -0400
Date: Wed, 20 Oct 2004 09:10:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.6.9
Message-ID: <20041020091045.D1047@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <10982257353682@kroah.com> <10982257352301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10982257352301@kroah.com>; from greg@kroah.com on Tue, Oct 19, 2004 at 03:42:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 03:42:15PM -0700, Greg KH wrote:
> ChangeSet 1.1997.37.29, 2004/10/06 12:50:32-07:00, kaneshige.kenji@jp.fujitsu.com
> 
> [PATCH] PCI: warn of missing pci_disable_device()
> 
> As mentioned in Documentaion/pci.txt, pci device driver should call
> pci_disable_device() when it decides to stop using the device. But
> there are some drivers that don't use pci_disable_device() so far.

No.  This is wrong.  There are some classes of devices, notably
PCMCIA Cardbus drivers where buggy BIOS means this should _NOT_
be done.

There are BIOSen out there which refuse to suspend/resume if the
Cardbus bridge is disabled.

It's not that the driver is buggy.  It's that the driver has far
more information than the PCI layer could ever have.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
