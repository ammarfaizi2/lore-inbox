Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270827AbTGNU2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270829AbTGNU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:27:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11716
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270827AbTGNU1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:27:15 -0400
Subject: Re: [RFC][PATCH] Posix Message Queues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Michal Wronski <wrona@mat.uni.torun.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
In-Reply-To: <3F130F94.2030903@colorfullife.com>
References: <3F130F94.2030903@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058215159.606.157.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 21:39:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 21:16, Manfred Spraul wrote:
> Hi Michal,
> 
> You've implemented mq_open() in user space by combining open()+ioctl() 
> syscalls. I think it's racy:
> 
> What if two processes call
> {
>     fd = mq_open("dummy",O_CREAT,0777,{.mq_maxmsg=10000});
>     mq_send = mq_send(fd,buf,10000,0);
> }
> 
> I think setting the queue options and creating a new queue must be 
> atomic, i.e. we need a new syscall.

O_EXCL lets you know if you are the real creator. That means you can
create it 000, fix it up, fchmod it and go

