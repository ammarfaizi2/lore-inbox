Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWELJSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWELJSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWELJSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:18:51 -0400
Received: from webapps.arcom.com ([194.200.159.168]:64525 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751097AbWELJSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:18:50 -0400
Message-ID: <446452F5.10909@cantab.net>
Date: Fri, 12 May 2006 10:18:45 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Thomas Kleffel (maintech GmbH)" <tk@maintech.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, Iain Barker <ibarker@aastra.com>
Subject: Re: [PATCH] ide_cs: Make ide_cs work with the memory space of CF-Cards
 if IO space is not available (2nd revision)
References: <44629D10.80803@maintech.de> <1147362779.26130.45.camel@localhost.localdomain> <44643B80.5080109@maintech.de>
In-Reply-To: <44643B80.5080109@maintech.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2006 09:18:45.0377 (UTC) FILETIME=[11B50F10:01C675A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Kleffel (maintech GmbH) wrote:
> 
> +void outb_io(unsigned char value, unsigned long port) {
> +	outb(value, port);
> +}
> +
> +void outb_mem(unsigned char value, unsigned long port) {
> +	writeb(value, (void __iomem *) port);
>  }

[...]

> +    if(is_mmio) 
> +    	my_outb = outb_mem;
> +    else
> +    	my_outb = outb_io;


Shouldn't you convert ide_cs to use iowrite8 (and friends) instead of
doing this?

David Vrabel
