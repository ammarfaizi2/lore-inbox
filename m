Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSJPCpY>; Tue, 15 Oct 2002 22:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbSJPCpY>; Tue, 15 Oct 2002 22:45:24 -0400
Received: from [203.117.131.12] ([203.117.131.12]:2721 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S264815AbSJPCpW>; Tue, 15 Oct 2002 22:45:22 -0400
Message-ID: <3DACD41F.2050405@metaparadigm.com>
Date: Wed, 16 Oct 2002 10:51:11 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Simon Roscic <simon.roscic@chello.at>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at> <1034710299.1654.4.camel@localhost.localdomain> <200210152153.08603.simon.roscic@chello.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 6.1b5 does appear to be a big improvement from looking
at the code (certainly much more readable than version 4.x end earlier).

Although the method for creating the different modules for
different hardware is pretty ugly.

in qla2300.c

#define ISP2300
[snip]
#include "qla2x00.c"

in qla2200.c

#define ISP2200
[snip]
#include "qla2x00.c"

I'm sure this would have to go before it got it.

~mc

On 10/16/02 03:53, Simon Roscic wrote:
> On Tuesday 15 October 2002 21:31, Arjan van de Ven <arjanv@redhat.com> wrote:
> 
>>Oh so you haven't notices how it buffer-overflows the kernel stack, how
>>it has major stack hog issues, how it keeps the io request lock (and
>>interrupts disabled) for a WEEK ?

This may have been the cause of problems I had running qla driver with
lvm and ext3 - I was getting ooops with what looked like corrupted bufferheads.

This was happening in pretty much all kernels I tried (a variety of
redhat kernels and aa kernels). Removing LVM has solved the problem.
Although i was blaming LVM - maybe it was a buffer overflow in qla driver.

The rh kernel I tried had quite an old version (4.31) of the driver
suffered from problems recovering from LIP resets. The latest 6.x drivers
seem to handle this much better.

~mc

