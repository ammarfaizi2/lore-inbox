Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVIIKKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVIIKKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVIIKKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:10:19 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:5006 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1030214AbVIIKKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:10:17 -0400
Date: Fri, 9 Sep 2005 12:10:04 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Andy Fleming <afleming@freescale.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: read current link status from phy
In-Reply-To: <62AA8EFA-7D65-4E87-B71F-55A07321011E@freescale.com>
Message-ID: <Pine.LNX.4.63.0509091152450.23760@dingo.iwr.uni-heidelberg.de>
References: <200509080125.j881PcL9015847@hera.kernel.org>  <431F9899.4060602@pobox.com>
 <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de> 
 <1126184700.4805.32.camel@tsc-6.cph.tpack.net> 
 <Pine.LNX.4.63.0509081521140.21354@dingo.iwr.uni-heidelberg.de>
 <1126190554.4805.68.camel@tsc-6.cph.tpack.net>
 <Pine.LNX.4.63.0509081713500.22954@dingo.iwr.uni-heidelberg.de>
 <62AA8EFA-7D65-4E87-B71F-55A07321011E@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Andy Fleming wrote:

> The new PHY Layer (drivers/net/phy/*) can provide all these features 
> for you without much difficulty, I suspect.

As pointed to be Andrew a few days ago, this driver supports a lot of 
chips - for most of them the test hardware would be hard to come by 
and the documentation even more. Unless you'd like to do it based on 
"whoever is interested should cry loud"...

> The layer supports handling the interrupts for you, or (if it's 
> shared with your controller's interrupt)

Yes, there is only one interrupt that for data transmission (both Tx 
and Rx), statistics, errors and (for those chips that support it) link 
state change.

> Is the cost of an extra read every minute really too high?

You probably didn't look at the code. The MII registers are not 
exposed in the PCI space, they need to be accessed through a serial 
protocol, such that each MII register read is in fact about 200 (in 
total) of outw and inw/inl operations.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
