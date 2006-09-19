Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWISK51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWISK51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWISK50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:57:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56988 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750812AbWISK5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:57:25 -0400
Subject: Re: [PATCH] dmaengine: clean up and abstract function types (was
	Re: [PATCH 08/19] dmaengine: enable multiple clients and operations)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olof Johansson <olof@lixom.net>
Cc: Dan Williams <dan.j.williams@gmail.com>, christopher.leech@intel.com,
       Jeff Garzik <jeff@garzik.org>, neilb@suse.de,
       linux-raid@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060918200555.74aedeae@localhost.localdomain>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	 <4505F4D0.7010901@garzik.org>
	 <20060915113817.6154aa67@localhost.localdomain>
	 <20060915144423.500b529d@localhost.localdomain>
	 <e9c3a7c20609181556n235d650eg16e5296f192bd2d5@mail.gmail.com>
	 <20060918200555.74aedeae@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Sep 2006 12:20:09 +0100
Message-Id: <1158664809.32598.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 20:05 -0500, ysgrifennodd Olof Johansson:
> On Mon, 18 Sep 2006 15:56:37 -0700 "Dan Williams" <dan.j.williams@gmail.com> wrote:

> op.src_type = PG; op.src = pg;
> op.dest_type = BUF; op.dest = buf;
> op.len = len;
> dma_async_commit(chan, op);

At OLS Linus suggested it should distinguish between sync and async
events for locking reasons.

	if(dma_async_commit(foo) == SYNC_COMPLETE) {
		finalise_stuff();
	}

	else		/* will call foo->callback(foo->dev_id) */

because otherwise you have locking complexities - the callback wants to
take locks to guard the object it works on but if it is called
synchronously - eg if hardware is busy and we fall back - it might
deadlock with the caller of dmaa_async_foo() who also needs to hold the
lock.

Alan

