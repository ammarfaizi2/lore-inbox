Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWJXLmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWJXLmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 07:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWJXLmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 07:42:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:65241 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030369AbWJXLmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 07:42:31 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <453DFBFF.8040001@s5r6.in-berlin.de>
Date: Tue, 24 Oct 2006 13:41:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux1394-devel@lists.sourceforge.net,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain>	 <1161675611.10524.598.camel@localhost.localdomain>	 <453DCB17.6050304@s5r6.in-berlin.de> <1161678557.10524.602.camel@localhost.localdomain>
In-Reply-To: <1161678557.10524.602.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> Well, the question is wether we want to make the whole machine suspend
> fail because there is a 1394 chip that doesn't do PCI PM in or not...
> 
> I can send patches "fixing" it both ways (just ignoring the result from
> pci_set_power_state in general, or just ignoring that result on Apple
> cells).

Yes, what would be the correct way to do this? And if it the latter
option, should that be implemented in ohci1394 or in pci_set_power_state?

grep says that almost nobody checks the return code of
pci_set_power_state. But e.g. usb/core/hcd-pci.c does...

(Side note: The sole function that ohci1394's suspend and resume hooks
fulfill right now in mainline is to change power consumption of the
chip. The IEEE 1394 stack as a whole does not survive suspend + resume
yet. A still incomplete solution is in linux1394-2.6.git.)
-- 
Stefan Richter
-=====-=-==- =-=- ==---
http://arcgraph.de/sr/
