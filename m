Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUI1W0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUI1W0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUI1W0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:26:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:33430 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268090AbUI1WYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:24:50 -0400
Subject: Re: [PATCH] add sysfs attribute 'carrier' for net devices - try 2.
From: Stephen Hemminger <shemminger@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>,
       Martin Waitz <tali@admingilde.org>
In-Reply-To: <20040928205444.GB1496@schottelius.org>
References: <Pine.LNX.4.61.0409270041460.2886@dragon.hygekrogen.localhost>
	 <1096306153.1729.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409281316191.22088@jjulnx.backbone.dif.dk>
	 <Pine.LNX.4.61.0409282118340.2729@dragon.hygekrogen.localhost>
	 <20040928205444.GB1496@schottelius.org>
Content-Type: text/plain
Organization: Open Source Development Lab
Date: Tue, 28 Sep 2004 15:24:43 -0700
Message-Id: <1096410283.21799.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 22:54 +0200, Nico Schottelius wrote:
> Hello!
> 
> I am just a bit tired and a bit confused, but
> 
> Jesper Juhl [Tue, Sep 28, 2004 at 09:23:25PM +0200]:
> > > > Using snprintf in this way is kind of silly. since buffer is PAGESIZE.
> > > > The most concise format of this would be:
> > > > 	return sprintf(buf, dec_fmt, !!netif_carrier_ok(dev));
> 
> wouldn't this potentially open a security hole / buffer overflow?

buf comes from fs/sysfs/file.c:fill_read_buf and is PAGESIZE.
Since netif_carrier_ok() returns 0 or 1, don't see how that could ever
turn into a security hole.
	

> I am currently not really seeing where buf is passed from and what
> dec_fmt is, but am I totally wrong?

dec_fmt is in net-sysfs.c and is defined as "%d\n" to avoid
repetition of same string literal.

