Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbTIJDWh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 23:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTIJDWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 23:22:37 -0400
Received: from smtp4.us.dell.com ([143.166.148.135]:48038 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP id S264359AbTIJDWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 23:22:34 -0400
Date: Tue, 9 Sep 2003 17:22:00 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Dave Jones <davej@redhat.com>, Anatoly Pugachev <mator@gsib.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: agpgart support for intel SHG2 motherboard, serverworks chipset
In-Reply-To: <20030905000452.GF12613@kroah.com>
Message-ID: <Pine.LNX.4.44.0309091658400.17200-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anatoly, I've cc'd Greg on this one, as you managed to break the
> > sysfs new_id stuff that he wrote, so I think he may be interested
> > in fixing that up 8-)

agp_serverworks_probe() is marked __init.  Thus the static lookup 
called by the new_id code fails as this function is no longer in the 
kernel.  The fix is to remove __init from the probe routines.  I'm looking 
to see how often this occurs elsewhere.

sworks-agp.c also can't make effective use of the new_id code because it 
registers a single all-covering serverworks pci_device_id, then its probe 
routine checks for three specific device IDs and bails if it's not them.  
The new_id code can't help here.  The "right" way would be to register 
three separate entries in the pci_table and not test for them in the probe 
routine.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

