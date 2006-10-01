Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWJATUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWJATUK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWJATUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:20:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:41874 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932223AbWJATUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:20:08 -0400
Message-ID: <452014C2.1050000@garzik.org>
Date: Sun, 01 Oct 2006 15:19:30 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
References: <20060928014623.ccc9b885.akpm@osdl.org>	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>	 <1159550143.13029.36.camel@localhost.localdomain>	 <20060929235054.GB2020@slug>	 <1159573404.13029.96.camel@localhost.localdomain>	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>	 <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org>
In-Reply-To: <1159729523.2891.408.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> well... why not go one step further and eliminate the flags argument
> entirely? And use pci_name() for the name (so eliminate the argument ;)
> and always pass pdev as data, so that that argument can go away too....
> 
> that'll cover 99% of the request_irq() users for pci devices.. and makes
> it really nicely simple and consistent.

Disagree.  That would involve rewriting a lot of drivers.

flags: may or may not need sample-random flag.

name: is always the ethernet interface, for net drivers, or did you 
forget from your irqbalance days?  ;-)

data: in practice, is _rarely_ struct pci_dev.  It's usually a 
driver-private structure which is the structure most frequently 
accessed.  struct pci_dev* is rarely accessed inside the interrupt 
handler, except maybe somewhere deep in an error handling path.

	Jeff

