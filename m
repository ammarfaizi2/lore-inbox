Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUBVNnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 08:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUBVNnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 08:43:24 -0500
Received: from mail.convergence.de ([212.84.236.4]:53670 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261248AbUBVNnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 08:43:21 -0500
Message-ID: <4038B1E9.60601@convergence.de>
Date: Sun, 22 Feb 2004 14:43:05 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: i2c-yosemite
References: <20040222104106.714de992.khali@linux-fr.org> <20040222103036.A29210@infradead.org>
In-Reply-To: <20040222103036.A29210@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 22.02.2004 11:30, Christoph Hellwig wrote:
> On Sun, Feb 22, 2004 at 10:41:06AM +0100, Jean Delvare wrote:
> 
>>If everyone reimplements what already exists, the kernel is likely to go
>>bigger with no benefit. Also, you won't be able to use all user-space
>>tools that already exist,

Agreed.

>>Please explain to us why you cannot/don't want to use the existing i2c
>>subsystem.

> Yupp.  While we're at it what should we do with the i2c reimplementations
> in alsa and dvb?

The current dvb "i2c" implementation is only about 10k straight-forward 
code. Besides the name, there isn't much code duplication, because 
essential stuff (for example struct i2c_msg) is already hijacked from i2c.h.

The problem with dvb i2c is, that the very first engineers didn't think 
of the bus as a general purpose bus, but more like "hey, we know what 
we're doing".

In former times when DVB wasn't in the kernel, we tried to use the 
in-kernel i2c subsystem. One problem was, that all kind of drivers tried 
to probe the DVB i2c busses, which really confused some i2c adapters. I 
admit that this has been solved lately with the newly introduced "usage 
ids".

There isn't much code duplication for the i2c helper chipsets drivers 
either, because it's very unlikely that you'll find them outside 
so-called DVB frontends.

The biggest problem is, however, that some of the used chipsets (mainly 
the demodulators) encapsulate all i2c traffic that has to go "beyond" 
them (mainly to the tuners). They have a thing called "i2c repeater" 
which has to be enabled and disabled by special i2c commands, sometimes 
in a magic fashion.

This is possible if you know exactly what i2c mesages you are sending, 
but the guy who wrote the code told me that he wasn't able to get it 
fully running with the kernel i2c system.

This might have changed in the past, but it hasn't been checked lately.

For the long term (ie. 2.7 and 2.8), we're planning to use kernel i2c 
again, but currently nobody dares to touch the code because it's running 
very stable.

CU
Michael.
