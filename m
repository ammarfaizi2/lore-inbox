Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUJKLzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUJKLzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUJKLzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:55:24 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:6089 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268824AbUJKLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:55:23 -0400
Message-ID: <416A7484.1030703@portrix.net>
Date: Mon, 11 Oct 2004 13:54:44 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cal Peake <cp@absolutedigital.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org,
       hermes@gibson.dropbear.id.au
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
In-Reply-To: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal Peake wrote:
> Hi,
> 
> This patch fixes several dozen warnings spit out when compiling the hermes 
> wireless driver.
> 
> In file included from drivers/net/wireless/orinoco.c:448:
> drivers/net/wireless/hermes.h: In function `hermes_present':
> drivers/net/wireless/hermes.h:398: warning: passing arg 1 of `readw' makes pointer from integer without a cast
> drivers/net/wireless/hermes.h: In function `hermes_set_irqmask':
> drivers/net/wireless/hermes.h:404: warning: passing arg 2 of `writew' makes pointer from integer without a cast
> ...

>  	inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
> -	readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
> +	readw((void __iomem *)(hw)->iobase + ( (off) << (hw)->reg_spacing )))
>  #define hermes_write_reg(hw, off, val) do { \

Isn't the correct fix to declare iobase as (void __iomem *) ?

Thanks,

Jank
