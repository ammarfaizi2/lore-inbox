Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTBCJSl>; Mon, 3 Feb 2003 04:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBCJSl>; Mon, 3 Feb 2003 04:18:41 -0500
Received: from gate.perex.cz ([194.212.165.105]:27663 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261996AbTBCJSk>;
	Mon, 3 Feb 2003 04:18:40 -0500
Date: Mon, 3 Feb 2003 10:27:45 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Various Fixes and Improved Error Checking (3/4)
In-Reply-To: <20030202203651.GA22836@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302031026040.4023-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Adam Belay wrote:

> -	for (tmp = 0; tmp < 8 && pnp_port_valid(dev, tmp); tmp++)
> -		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), pnp_port_start(dev, tmp));
> -	for (tmp = 0; tmp < 2 && pnp_irq_valid(dev, tmp); tmp++) {
> -		int irq = pnp_irq(dev, tmp);
> +	for (tmp = 0; tmp < 8 && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
> +		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
> +	for (tmp = 0; tmp < 2 && res->irq_resource[tmp].flags & IORESOURCE_IRQ; tmp++) {
> +		int irq = res->irq_resource[tmp].start;

Why you remove pnp_*_valid() checks? They are more robust. There is also 
check for UNSET flag.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

