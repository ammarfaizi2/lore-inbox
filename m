Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUGMEQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUGMEQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGMEQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:16:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:17371 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263881AbUGMEQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:16:44 -0400
Subject: Re: [PATCH] pmac_zilog: initialize port spinlock on all init paths
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Eger <eger@havoc.gtf.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713003935.GA1050@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org>
	 <20040712082104.GA22366@havoc.gtf.org>
	 <20040712220935.GA20049@havoc.gtf.org>
	 <20040713003935.GA1050@havoc.gtf.org>
Content-Type: text/plain
Message-Id: <1089692194.1845.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 23:16:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 19:39, David Eger wrote:
> Dear Ben,
> 
> This patch fixes the Zilog driver so it doesn't freak on my TiBook.

The spinlock should be initialized by the serial core when registering
the ports ... can you find out for me how do you end up with the
port not registered but still trying to use the lock ? The port
do exist on tipb's even if it has no visible connectors (actually
some tipbs have an irda output on port B and port A is available
on the motherboard, I think on the modem connector, though there
is no "adapter" that I know of to get it out).

> ( of course, it still spews diahrea of 'IN from bad port XXXXXXXX'
>   but then, I don't have the hardware.... still, seems weird that OF
>   would report that I do have said hardware :-/ )

The IN from bad port is a different issue, it's probably issued by
another driver trying to tap legacy hardware, either serial.o or
ps/2 kbd, I suppose, check what else of that sort you have in your
 .config

Ben.


