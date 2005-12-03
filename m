Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVLCLpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVLCLpU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 06:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVLCLpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 06:45:20 -0500
Received: from www4.pochta.ru ([81.211.64.24]:52490 "EHLO www4.pochta.ru")
	by vger.kernel.org with ESMTP id S1750965AbVLCLpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 06:45:19 -0500
Date: Sat, 3 Dec 2005 14:44:58 +0300 (MSK)
From: vitalhome@rbcmail.ru
Message-Id: <200512031144.jB3BiwRG048640@www4.pochta.ru>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Free mail service Pochta.ru; WebMail Client; Account: vitalhome@rbcmail.ru
X-Proxy-IP: [195.242.0.161]
X-Originating-IP: [195.201.72.10]
Subject: Re: [PATCH 2.6-git] SPI core refresh
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >>- it's more adapted for use in real-time environments
> > >>
> > >I still do not see why you are stating this.  Why do you say this?
> > >
> > Due to possible priority inversion problems in David's core.
> 
> I am still not convinced of your statements here, sorry.  Specifics
> please.

So, again, David's write_then_read function which is the basic one for all the synchronous 
transfers uses single static pointer to kmalloc'ed buffer and protects its usage by 
semaphores. If there are multiple controllers onboard, this serialization is suboptimal 
and may cause priority inversion if, for instance, two threads with different priorities 
will use this function at the same time.

Vitaly
