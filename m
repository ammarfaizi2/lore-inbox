Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTFIXVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 19:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTFIXVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 19:21:11 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:29970 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262270AbTFIXVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 19:21:10 -0400
Date: Tue, 10 Jun 2003 01:34:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: wa@almesberger.net, <chas@cmf.nrl.navy.mil>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
In-Reply-To: <20030609.161435.104053652.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0306100129460.12110-100000@serv>
References: <Pine.LNX.4.44.0306100011230.5042-100000@serv>
 <20030609.160013.74730356.davem@redhat.com> <Pine.LNX.4.44.0306100113420.12110-100000@serv>
 <20030609.161435.104053652.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 9 Jun 2003, David S. Miller wrote:

>    > netdev->dead = 1;
>    > netdev->op_this = NULL;
>    > netdev->op_that = NULL;
>    > netdev->op_whatever = NULL;
>    > synchronize_kernel();
>    
>    That assumes of course that the functions don't sleep.
>    (RCU isn't really the answer to everything.)
>    
> They hold references to the object, it doesn't matter if
> they sleep.

That's not the point. You also have to wait for the already running 
operations to finish, before you can allow the module to unload.

bye, Roman

