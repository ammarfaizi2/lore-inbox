Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270779AbTGNUDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270777AbTGNUDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:03:32 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:63906 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S270779AbTGNUBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:01:48 -0400
Message-ID: <3F130F94.2030903@colorfullife.com>
Date: Mon, 14 Jul 2003 22:16:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Wronski <wrona@mat.uni.torun.pl>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC][PATCH] Posix Message Queues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

You've implemented mq_open() in user space by combining open()+ioctl() 
syscalls. I think it's racy:

What if two processes call
{
    fd = mq_open("dummy",O_CREAT,0777,{.mq_maxmsg=10000});
    mq_send = mq_send(fd,buf,10000,0);
}

I think setting the queue options and creating a new queue must be 
atomic, i.e. we need a new syscall.

Could you replace the printk's with Dprintk or something like that? User 
space misbehaviour such as bad pointers should not generate printk messages.

--
    Manfred


