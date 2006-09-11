Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWIKR6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWIKR6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWIKR6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:58:25 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:43934 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751311AbWIKR6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:58:24 -0400
From: "Misha Tomushev" <misha@fabric7.com>
To: "'Arnd Bergmann'" <arnd@arndb.de>
Cc: <jgarzik@pobox.com>, <netdev@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] VIOC: New Network Device Driver
Date: Mon, 11 Sep 2006 10:58:23 -0700
Message-ID: <003c01c6d5cb$e00fd850$7501a8c0@ZINLAPTOP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <200609102339.25621.arnd@arndb.de>
Importance: Normal
X-OriginalArrivalTime: 11 Sep 2006 17:58:23.0917 (UTC) FILETIME=[DFF635D0:01C6D5CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Arnd Bergmann [mailto:arnd@arndb.de] 
Sent: Sunday, September 10, 2006 2:39 PM
To: Misha Tomushev
Cc: jgarzik@pobox.com; netdev@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIOC: New Network Device Driver

Am Friday 15 September 2006 02:15 schrieb Misha Tomushev:
> VIOC Device Driver provides a standard device interface to the
internal
> fabric interconnected network used on servers designed and built by
> Fabric 7 Systems.
>
> The patch can be found at ftp.fabric7.com/VIOC.

We recently had a discussion about tx descriptor cleanup in general.
It would probably be more efficient to call vnic_clean_txq from the
vioc_rx_poll() function. To do that, your tx interrupt handler
should disable the tx interrupt line and call netif_rx_schedule,
like you do for the receive interrupts.

The descriptor clean-up does not contribute anything to the performance
of the driver, it just replenishes the memory pools. It almost does not
need interrupts. Why would we want to add more cycles to the receive
logic, when driver is doing useful work for something that can run
almost at any time? 

