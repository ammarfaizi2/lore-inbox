Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268235AbTAMSmY>; Mon, 13 Jan 2003 13:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268237AbTAMSmY>; Mon, 13 Jan 2003 13:42:24 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:37638 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268235AbTAMSmW>; Mon, 13 Jan 2003 13:42:22 -0500
Message-ID: <3E230A4D.6020706@google.com>
Date: Mon, 13 Jan 2003 10:49:49 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>	 <1042399796.525.215.camel@zion.wanadoo.fr>	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk> <1042401074.525.219.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>On Sun, 2003-01-12 at 21:27, Alan Cox wrote:
>
>  
>
>>which currently has two problems Ross found
>>
>>1.  The processors or so fast we have to enforce the 400nS delay nowdays\
>>

The reason we need to enforce the 400nS delay is because of what is 
going on on the other processor.  If the other processor is in ide_intr 
trying to grab the spinlock and we do not give the drive time to assert 
the busy bit and the other processor makes it to the call to 
drive_is_ready, then the drive could still return not busy and we could 
think the command is done.  This code path is probably less than 50 
instructions, so I don't think it's taken anywhere near 400ns for a long 
time.

DMA is slightly different.  We don't actually have to delay the 400ns if 
we call ide_dma_begin from inside the spinlock.

    Ross


