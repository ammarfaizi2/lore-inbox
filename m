Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVBRPIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVBRPIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBRPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:08:21 -0500
Received: from [195.23.16.24] ([195.23.16.24]:41860 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261379AbVBRPIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:08:16 -0500
Message-ID: <421604DD.4080809@grupopie.com>
Date: Fri, 18 Feb 2005 15:08:13 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
Cc: franck.bui-huu@innova-card.com, linux-kernel@vger.kernel.org
Subject: Re: [TTY] 2 points seems strange to me.
References: <20050217175150.D8E015B874@frankbuss.de> <20050217181241.A22752@flint.arm.linux.org.uk> <4215B5AC.4050600@innova-card.com> <42160290.3070000@microgate.com>
In-Reply-To: <42160290.3070000@microgate.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> Franck Bui-Huu wrote:
> 
>> Looking at TTY code, I noticed a weird test done in "opost_bock"
>> located in n_tty.c file. I don't understand why the following test is
>> done at the start of the function:
>> if (nr > sizeof(buf))
>>        nr = sizeof(buf);
>> Actually it limits the size of processing blocks to 4 bytes and I can't
>> find a reason why.
> 
> 
> No, it limits the size to 80 bytes,
> which is the size of buf.
> 
> sizeof returns the size of the char array buf[80]
> (standard C)

Looking at the code, I think Franck is right. buf is a "const unsigned 
char *" for which sizeof(buf) is the size of a pointer.

This certainly looks like a bug.

Since the function doesn't guarantee that nr bytes are written, and the 
caller must handle the case of fewer bytes, this probably went unnoticed.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
