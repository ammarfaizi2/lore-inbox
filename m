Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVA0UjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVA0UjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVA0UjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:39:18 -0500
Received: from alog0032.analogic.com ([208.224.220.47]:50816 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261178AbVA0Uh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:37:59 -0500
Date: Thu, 27 Jan 2005 15:37:13 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: John Richard Moser <nigelenki@comcast.net>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <1106856178.5624.128.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0501271505190.23334@chaos.analogic.com>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
 <41F92721.1030903@comcast.net>  <1106848051.5624.110.camel@laptopd505.fenrus.org>
  <41F92D2B.4090302@comcast.net>  <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
  <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com>
 <1106856178.5624.128.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Arjan van de Ven wrote:

> On Thu, 2005-01-27 at 14:19 -0500, linux-os wrote:
>> Gentlemen,
>>
>> Isn't the return address on the stack an offset in the
>> code (.text) segment?
>>
>> How would a random stack-pointer value help? I think you would
>> need to start a program at a random offset, not the stack!
>> No stack-smasher that worked would care about the value of
>> the stack-pointer.
>
> the simple stack exploit works by overflowing a buffer ON THE STACK with
> a "dirty payload and then also overwriting the return address to point
> back into that buffer.
>

Yes.

> (all the security guys on this list will now cringe about this over
> simplification; yes reality is more complex but lets keep the
> explenation simple for Richard)
>

Sure, be cute.

> pointing back into that buffer needs the address of that buffer. That
> buffer is on the stack, which is now randomized.
>

Wrong concept. Your exploit program simply needs fill with a guad-
byte offset such as 0x02020202 and put your payload at that
offset. You don't care where the stack-pointer is. You find
out how many bytes of 0x02 are necessary to get to that offset
on an experimental system, it is independent of the stack-pointer
value. It depends only upon the size of the buffer you are
exploiting, which needs to not change, of course.

When the return instruction occurs, one of those 0x02020202
will be encountered and your payload gets executed next.

Note that you should chose a different repeating-byte
than I have used here. Get the address of _end on a 'C'
program for hints.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
