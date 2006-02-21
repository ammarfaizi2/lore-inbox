Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWBUWGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWBUWGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWBUWGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:06:45 -0500
Received: from cantor.suse.de ([195.135.220.2]:22710 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964792AbWBUWGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:06:44 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
Date: Tue, 21 Feb 2006 23:06:23 +0100
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
References: <43FAB283.8090206@jp.fujitsu.com> <200602212231.55879.ak@suse.de> <43FB8C4F.6070802@pobox.com>
In-Reply-To: <43FB8C4F.6070802@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212306.24342.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 22:55, Jeff Garzik wrote:

> It doesn't matter how easily its added, it is the wrong place to add 
> such things.
> 
> This is what the various functions called during pci_driver::probe() do...

The problem is that at least on the e1000 it only applies to some of the 
many PCI-IDs it supports. So the original patch had an long ugly switch
with PCI IDs to check it. I suggested to use driver_data for it then,
but Kenji-San ended up with this new field.  I actually like the idea
of the new field because it would allow to add such things very easily
without adding lots of code.

it's not an uncommon situation. e.g. consider driver A which supports
a lot of PCI-IDs but MSI only works on a few of them. How do you
handle this? Add an ugly switch that will bitrot? Or put all the 
information into a single place which is the pci_device_id array.

I prefer the later solution. 

Of course there are some boundaries that shouldn't be exceeded here.
It probably only makes sense for parameters that are simple boolean,
nothing more complicated. But for that it's quite nice.

-Andi
