Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268350AbTAMVa1>; Mon, 13 Jan 2003 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268353AbTAMVa1>; Mon, 13 Jan 2003 16:30:27 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:30682 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S268350AbTAMVaV>; Mon, 13 Jan 2003 16:30:21 -0500
Message-ID: <3E233160.3040901@google.com>
Date: Mon, 13 Jan 2003 13:36:32 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>	 <1042399796.525.215.camel@zion.wanadoo.fr>	 <1042403235.16288.14.camel@irongate.swansea.linux.org.uk>	 <1042401074.525.219.camel@zion.wanadoo.fr>  <3E230A4D.6020706@google.com>	 <1042484609.30837.31.camel@zion.wanadoo.fr>  <3E23114E.8070400@google.com> <1042491409.586.4.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>On Mon, 2003-01-13 at 20:19, Ross Biro wrote:
>
>  
>
>>and read the alt status register to get a delay.
>>
>>This is technically a spec violation, but it's probably safe.  I'm going 
>>to send an email to a couple of the drive manufacturers and see what 
>>they think.
>>    
>>
>
>Or get back to my original idea of an IOSYNC() callback in hwif. For
>standard PCI controllers with DMA, it's enough to read the dma_status
>register which is on the same bus path. Others will have to provide
>some implementation or be unsafe on some non-x86. What do you think ?
>

I think that's a very good idea provided that we know that the 
dma_status register exists and is on the same bus path.  That should be 
true for all modern IDE controllers on the x86.  But is not a completely 
general solution.

One thing that we should keep in mind, is that the IDE controller could 
buffer the write as well.  I've seen some evidence that Promise chips 
might attempt to buffer things like  resets until a UDMA burst is 
complete.  I guess we have to assume that any controller that does such 
a thing will also provide a way of knowing when the command has actually 
been sent to the drive.

If anyone is curious, I believe I've got the hardware to see how long 
after the PCI bus sees an i/o command that it makes it to the drive, but 
this would only be trivia that applies to the motherboard we test it on 
with the settings currently in place and should not be relied on.

    Ross


