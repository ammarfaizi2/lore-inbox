Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268291AbTAMTlA>; Mon, 13 Jan 2003 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268307AbTAMTlA>; Mon, 13 Jan 2003 14:41:00 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:13736 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268291AbTAMTk6>; Mon, 13 Jan 2003 14:40:58 -0500
Message-ID: <3E23180A.5000003@google.com>
Date: Mon, 13 Jan 2003 11:48:26 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Alvord <jalvo@mbay.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com> <1042399796.525.215.camel@zion.wanadoo.fr> <1042403235.16288.14.camel@irongate.swansea.linux.org.uk> <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com> <1042484609.30837.31.camel@zion.wanadoo.fr> <m3562vkrgu0u6qhijvimibkcqjfpujgi59@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:

>On 13 Jan 2003 20:03:29 +0100, Benjamin Herrenschmidt
><benh@kernel.crashing.org> wrote:
>
>  
>
>>Exactly. My problem right now is with enforcing that 400ns delay on
>>non-DMA path as with PCI write posting on one side, and other fancy bus
>>store queues etc... you are really not sure when your outb for the
>>command byte will really reach the disk.
>>
>>So the problem turns down to: is it safe for commands with no data
>>transfer and commands with a PIO data transfer to read back from
>>some other task file register right after issuing the command byte
>>(the select register looks like a good choice, better than status
>>for sure) and before doing the delay of 400ns ? On any sane bus
>>architecture, that read will make sure the previous write will
>>have reached the device or your IO accessors are broken...
>>
>>    
>>
>You could simplify the problem somewhat by forcing all interaction and
>interrupt processing to a single CPU.
>
>john
>  
>
I don't think that helps.  The problem can still occur if the PCI write 
post is long enough for an interrupt to get through.  We could read the 
alt status twice in drive_is_ready and only take the second one.

    Ross


