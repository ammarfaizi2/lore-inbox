Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTDSStZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 14:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTDSStZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 14:49:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263429AbTDSStY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 14:49:24 -0400
Message-ID: <3EA19CF8.8030109@pobox.com>
Date: Sat, 19 Apr 2003 15:01:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: romieu@fr.zoreil.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/rcpci45 DMA mapping API conversion
References: <20030105144559.A2835@se1.cogenit.fr>
In-Reply-To: <20030105144559.A2835@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Greetings,
> 
>   I've been asked to convert the driver while compiling, so:
> - the exit paths look ok;
> - it compiles;
> - in rcpci45_remove_one(), I have been unable to find under which condition
>   it would be possible to have pDpa->msgbuf set to NULL. Test removed.
> 
> Comment, test and forward to Linus if correct.


Ok, I finally got around to attacking this one.  Your patch looked ok to 
me until I noticed one detail:

         pDpa->msgbuf = kmalloc (MSG_BUF_SIZE, GFP_DMA | GFP_KERNEL);

The GFP_DMA tag indicates that we can't just use pci_alloc_consistent in 
the normal way, as we lose the GFP_DMA designator.

	Jeff



