Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTBERKj>; Wed, 5 Feb 2003 12:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTBERKi>; Wed, 5 Feb 2003 12:10:38 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:5970 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S262394AbTBERKg>; Wed, 5 Feb 2003 12:10:36 -0500
Message-ID: <3E4147A0.4050709@google.com>
Date: Wed, 05 Feb 2003 09:19:28 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: alan@redhat.com, Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <20030202161837.010bed14.skraw@ithnet.com>	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>	 <3E3D6367.9090907@pobox.com>  <20030205104845.17a0553c.skraw@ithnet.com>	 <1044443761.685.44.camel@zion.wanadoo.fr>  <3E414243.4090303@google.com> <1044465151.685.149.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>While I agree with you here, I don't think it's what's happening.
>	/* clear INTR & ERROR flags */
>	hwif->OUTB(dma_stat|6, hwif->dma_status);
>
>  
>
You have way to much faith in the hardware.  Promise is especially known 
for not keeping to the spec.  I wouldn't trust the interrupt bit to be 
valid unless a dma is actually active, i.e. that

                  hwif->OUTB(hwif->INB(dma_base)|1, dma_base);

has actually been written.  

I've actually had a manufacturer tell me that they don't worry about the 
spec, just making things work with Windows.

    Ross

