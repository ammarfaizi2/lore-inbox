Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVCKQrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVCKQrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVCKQrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:47:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32980 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261203AbVCKQrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:47:02 -0500
Subject: Re: [ patch 3/5] drivers/serial/jsm: new serial device driver
From: Arjan van de Ven <arjan@infradead.org>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4231C9B2.5020202@us.ltcfwd.linux.ibm.com>
References: <20050228063954.GB23595@kroah.com>
	 <4228CE41.2000102@us.ltcfwd.linux.ibm.com>
	 <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com>
	 <20050308064424.GF17022@kroah.com>
	 <422DF525.8030606@us.ltcfwd.linux.ibm.com>
	 <20050308235807.GA11807@kroah.com>
	 <422F1A8A.4000106@us.ltcfwd.linux.ibm.com>
	 <20050309163518.GC25079@kroah.com>
	 <422F2FDD.4050908@us.ltcfwd.linux.ibm.com>
	 <20050309185800.GA27268@kroah.com>
	 <4231BB5D.8020400@us.ltcfwd.linux.ibm.com>
	 <1110556428.9917.31.camel@laptopd505.fenrus.org>
	 <4231C9B2.5020202@us.ltcfwd.linux.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:46:54 +0100
Message-Id: <1110559614.9917.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Jeff pointed out several PCI posting errors last time.  Before we used 
> udelay and now we changed to readb/readl instead of udelay this time.
> But we only used PCI posting when we think maybe delay there.
> So we have to do PCI posting on every writeb? 
not every

> Do you have some rules for 
> doing PCI posting while writeb? depends on what kind of registers?

basically you need to do posting flushes after every write for which you
assume later on the hardware received the write. If you do 5 writes in a
row you don't need 5 flushes. If you do a read later always anyway you
don't need any flushes.  
On the other side of the spectrum: if you do something to the hardware
and then wait for some event, you do need to flush that stuff.
So at minimum you want to make sure that at any point where you leave
the driver (to userspace or tty layer or ...) all writes have been
flushed. And at all points where you are going to wait for hardware
events.


