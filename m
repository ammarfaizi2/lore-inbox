Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVEKFdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVEKFdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 01:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKFdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 01:33:33 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39405 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261891AbVEKFdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 01:33:31 -0400
Date: Wed, 11 May 2005 11:03:27 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Nyberg <alexn@dsv.su.se>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, jgarzik@pobox.com,
       cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050511053327.GA28791@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1114462323.983.45.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251700560.4896-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0504251700560.4896-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I looked into the possibility of having the PCI core disable interrupt
> generation and DMA on each new device as it is discovered.  Unfortunately
> there is no dependable, universal way to do this for IRQs.  (A notable gap
> in the original PCI specification, IMHO.)  

PCI specification 2.3 onwards, command register bit 10 can be used for
disabling the interrupts from respective device. And the very reason for
introducing this bit seems to be to not allow the device issue interrupts
until a suitable driver for the device has been loaded. Have a look at
following message.

http://www.pcisig.com/reflector/msg05302.html

Probably this feature can be used to disable the interrupts from the devices
and enable these back when respective driver is loaded. This will resolve
the problem of drivers not getting initialized in second kernel due to shared
interrupts in kdump and reliability of capturing dump can be increased. 

Thanks
Vivek
