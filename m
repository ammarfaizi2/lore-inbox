Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268261AbTAMUJj>; Mon, 13 Jan 2003 15:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268267AbTAMUJj>; Mon, 13 Jan 2003 15:09:39 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8091
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268261AbTAMUJi>; Mon, 13 Jan 2003 15:09:38 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ross Biro <rossb@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E231444.6060209@google.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
	 <1042399796.525.215.camel@zion.wanadoo.fr>
	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>
	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>
	 <1042484609.30837.31.camel@zion.wanadoo.fr> <3E23114E.8070400@google.com>
	 <3E231444.6060209@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042491950.20038.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 13 Jan 2003 21:05:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 19:32, Ross Biro wrote:
> One thing we could do to solve this entire problem is wait for the 
> interrupt to finish before sending the command to the drive in the first 
> place.  Basically in ide_do_request we just have to change


>     if (!masked_irq) {
>          disable_irq_sync(hwif->irq);
>     }

You cannot disable an IRQ synchronously holding a spin lock taken by an
IRQ handler

