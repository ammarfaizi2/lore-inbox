Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUBWIaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 03:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUBWIae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 03:30:34 -0500
Received: from [212.28.208.94] ([212.28.208.94]:24075 "HELO dewire.com")
	by vger.kernel.org with SMTP id S261880AbUBWIad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 03:30:33 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: marogge@onlinehome.de
Subject: Re: Badness in pci_find_subsys
Date: Mon, 23 Feb 2004 09:30:31 +0100
User-Agent: KMail/1.6.1
Cc: vishwas.manral@lycos.com, "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
References: <DMOCIEPNKDKOLIAA@mailcity.com> <200402230639.00737.robin.rosenberg.lists@dewire.com> <200402230830.45003.marogge@onlinehome.de>
In-Reply-To: <200402230830.45003.marogge@onlinehome.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402230930.31706.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 February 2004 08.30, Martin wrote:
> Reading the documentation (ie. source code) it appears the problem is 
> triggered by the line
> 
> WARN_ON(in_interrupt());
> 
> Looks like the driver calls pci_find_subsys() from inside an interrupt on 
> occasions which apparently it shouldn't. The problem seems to be on 
> nvidia's side, not kernel development. I have emailed nvidia about it some 
> time ago, so far no reaction... 

Tracing the stack, I see:

pci_find_subsys is deprecated which is called from
pci_find_device which is deprecated which is called from
pci_find_slot, which is NOT deprecated.

-- robin
