Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268300AbTAMU3Z>; Mon, 13 Jan 2003 15:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268301AbTAMU3Z>; Mon, 13 Jan 2003 15:29:25 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:38586 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268300AbTAMU3Y>; Mon, 13 Jan 2003 15:29:24 -0500
Message-ID: <3E232369.2030401@google.com>
Date: Mon, 13 Jan 2003 12:36:57 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>	 <1042399796.525.215.camel@zion.wanadoo.fr>	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>	 <1042484609.30837.31.camel@zion.wanadoo.fr> <3E23114E.8070400@google.com>	 <3E231444.6060209@google.com> <1042491950.20038.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mon, 2003-01-13 at 19:32, Ross Biro wrote:
>  
>
>>One thing we could do to solve this entire problem is wait for the 
>>interrupt to finish before sending the command to the drive in the first 
>>place.  Basically in ide_do_request we just have to change
>>    
>>
>
>
>  
>
>>    if (!masked_irq) {
>>         disable_irq_sync(hwif->irq);
>>    }
>>    
>>
>
>You cannot disable an IRQ synchronously holding a spin lock taken by an
>IRQ handler
>  
>

You are correct, you have to drop the spinlock first.  And it doesn't 
really help anyway.

    Ross

