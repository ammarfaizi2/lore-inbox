Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVC3UN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVC3UN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVC3UN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:13:56 -0500
Received: from alog0191.analogic.com ([208.224.220.206]:58062 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261156AbVC3UMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:12:16 -0500
Date: Wed, 30 Mar 2005 15:11:58 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Vicente Feito <vicente.feito@gmail.com>
cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to debug kernel before there is no printk mechanism?
In-Reply-To: <200503301616.10450.vicente.feito@gmail.com>
Message-ID: <Pine.LNX.4.61.0503301506350.28684@chaos.analogic.com>
References: <424AD247.4080409@globaledgesoft.com> <200503301454.41322.vicente.feito@gmail.com>
 <Pine.LNX.4.61.0503301305260.28280@chaos.analogic.com>
 <200503301616.10450.vicente.feito@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, Vicente Feito wrote:

> On Wednesday 30 March 2005 06:09 pm, linux-os wrote:
>> On Wed, 30 Mar 2005, Vicente Feito wrote:
>>> Video memory is at b800:0000, for humans 0x0000b800, not at 0x000b8000
>>
>> Wrong. "real-mode" can use a segment address of b800, that doesn't
>> work in protected mode. A segment address of b800:0000 is never
>> under any conditions 0000b800.
> I was referring to the basic conditions, haven't played under protected mode
> with that, only in real mode, I assumed the question was under that mode.
> What you mean is this:
> B800:0010 -> B8010H right?
>

Sort of, but incomplete....

The real-mode segment is a 16-byte thing:

 	0001:0000	=  0x00000010
 	0002:0000	=  0x00000020
 	0003:0000	=  0x00000030

 	b801:0000	=  0x000B8010
 	b802:0000	=  0x000B8020
 	b803:0000	=  0x000B8030

To get the physical address, you multiply the
segment by 0x10 and add the offset. To access
these in 32-bit "linear" mode, you use the
address on the right. To access these in paged-
mode on Linux, you OR in PAGE_OFFSET. This
is an artifact of how the low-memory page-tables
were written. It is not the "correct" way. There
are macros available to perform the translation
for you if you are making some driver that needs
to work over many kernel versions.

[SNIPPED]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
