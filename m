Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUFAV0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUFAV0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUFAV0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:26:10 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:41316 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265236AbUFAVZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:25:56 -0400
Subject: Re: [PATCH] 2.6.6 synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
In-Reply-To: <20040601215710.F31301@flint.arm.linux.org.uk>
References: <20040527174509.GA1654@quadpro.stupendous.org>
	 <1085769769.2106.23.camel@deimos.microgate.com>
	 <20040528160612.306c22ab.akpm@osdl.org>
	 <1086123061.2171.10.camel@deimos.microgate.com>
	 <20040601215710.F31301@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1086125129.2047.21.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2004 16:25:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 15:57, Russell King wrote:
> If pci_register_driver fails, the driver is not, repeat not left
> registered.  Therefore it must not be unregistered after failure
> to register.

You are right. The specific problem I was trying to
fix is when no hardware is detected. I looked at other
PCI drivers (char/epca.c and net/eepro100.c) and which call
pci_unregister_driver if pci_register_driver returns <= 0
and indicates that pci_register_device returns the number
of pci devices detected. I now see that the two drivers I
looked at are broken. (bad luck that)

After looking at the source for pci_register_device(),
if no devices are detected, then it still returns 1.

I will rework the patches against synclink.c/synclinkmp.c
to only call pci_unregister_device() if init fails
(such as when no devices are detected)
*and* the call to pci_register_device() succeeds.

--
Paul Fulghum
paulkf@microgate.com


