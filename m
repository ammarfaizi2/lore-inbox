Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757050AbWK1Xuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050AbWK1Xuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757085AbWK1Xuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:50:52 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:8083 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1757016AbWK1Xuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:50:51 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <456CCB53.70208@s5r6.in-berlin.de>
Date: Wed, 29 Nov 2006 00:50:43 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061113 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc PATCH] ieee1394: ohci1394: delete bogus spinlock, flush
 MMIO writes
References: <tkrat.9660c0c3e547e1fd@s5r6.in-berlin.de> <20061128215621.2e0ac9a6@localhost.localdomain>
In-Reply-To: <20061128215621.2e0ac9a6@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Tue, 28 Nov 2006 22:24:11 +0100 (CET)
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> All MMIO writes which were surrounded by the spinlock as well as the
>> very last MMIO write of the IRQ handler are now explicitly flushed by
>> MMIO reads of the respective register.
> 
> MMIO is ordered anyway on the bus, you just need mmiowb() to force
> ordering to the bus controller in case you are on a big numa box.

The mmiowb is a checkpoint to ensure ordering between different threads
of MMIO writes; i.e. it doesn't halt the thread until the write actually
reached the device like a read would do, right?
-- 
Stefan Richter
-=====-=-==- =-== ===-=
http://arcgraph.de/sr/
