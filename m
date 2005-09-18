Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVIRB0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVIRB0j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 21:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVIRB0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 21:26:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:9387 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751277AbVIRB0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 21:26:38 -0400
X-Authenticated: #271361
Date: Sun, 18 Sep 2005 03:26:33 +0200
From: Edgar Toernig <froese@gmx.de>
To: Manu Abraham <manu@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: free free irq and Oops on cat /proc/interrupts
Message-Id: <20050918032633.15a9b1b6.froese@gmx.de>
In-Reply-To: <432BE7F7.90508@linuxtv.org>
References: <432BE7F7.90508@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham wrote:
>
> Can somebody give me a pointer as to what i am possibly doing wrong.
>
> i get a "free free IRQ" on free_irq().. 
>
>[and a kernel oops]

|	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT, 
|						DRIVER_NAME, mantis) < 0) {
|[...]
|	free_irq(pdev->irq, pdev);

The last arg of request_irq and free_irq has to match - it is the id
that distinguishes different users of the same irq.  As there never
was a request_irq with pdev you get that error on free_irq.

The module unload still takes place.  So trying to cat /proc/interrupts
later on will stumble over the still installed handler with the mantis
id - unfortunately, the driver (and especially DRIVER_NAME) is no longer
in memory ...

Ciao, ET.
