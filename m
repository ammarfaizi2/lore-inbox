Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVF0JNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVF0JNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVF0JNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:13:19 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:5270 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261968AbVF0JNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:13:15 -0400
Message-ID: <42BFC348.5040709@dev.rtsoft.ru>
Date: Mon, 27 Jun 2005 13:13:44 +0400
From: Vitaly Wool <vwool@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>	 <200506270049.10970.adobriyan@gmail.com>	 <1119819580.3215.47.camel@laptopd505.fenrus.org>	 <42BF7496.7080204@dev.rtsoft.ru> <1119860886.3186.30.camel@laptopd505.fenrus.org>
In-Reply-To: <1119860886.3186.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Nothing's gonna work in DMA case if he kills the wrappers.
>>    
>>
>
>how is that??
>  
>
These functions are not exactly *wrappers*, there's some little 
additional logic inside.
spi-pnx0105_atmel.c uses spi_pnx_msg_buff_t structure to embed physical 
and virtual address and length of the memory area allocated by 
consistent_alloc, so if we just get rid of the alloc/free functions, 
we'll copy wrong data from the userspace and nothing'll work.

Let's look at it from another point. When a read request comes from the 
userspace to spi-dev, spi-dev should allocate  memory and copy the user 
data in there. The problem is it is not (and shouldn't be) aware whether 
the transfer is gonna be DMA or not so spi-dev can't choose 
theappropriate method of memory allocation. Therefore it's reasonable to 
let algorithm provide routines to do that.

