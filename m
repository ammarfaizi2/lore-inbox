Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270331AbUJTM4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270331AbUJTM4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270130AbUJTMv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:51:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9344 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270331AbUJTMpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:45:25 -0400
Date: Wed, 20 Oct 2004 08:44:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Register corruption --patch
In-Reply-To: <20041020003408.GA6101@finwe.eu.org>
Message-ID: <Pine.LNX.4.61.0410200836020.10672@chaos.analogic.com>
References: <Pine.LNX.4.61.0410191112100.4820@chaos.analogic.com>
 <20041020003408.GA6101@finwe.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Jacek Kawa wrote:

> Richard B. Johnson wrote:
>
>> This 'C' compiler destroys parameters passed to functions
>> even though the code does not alter that parameter.
> [example]
>> This was from /usr/src/linux-2.6.9/arch/i386/kernel/semaphore.c
>> It this case, the value of 'sem' is destroyed which means that
>> certain assembly-language helper functions no longer work.
>>
>> This was discovered by Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
>>
>> I have been having trouble with mysterious things like:
> [...]
>> (4) Data errors in email.
>> (5) Network connections failing to go away `netstat -c` shows
>> hundreds of lines of very old history.
>> ... etc.
>>
>
> Having troubles with some strange (and -as it seems- temporary)
> data corruptions here[*], I was wondering, whether would it be
> posiible to easily diagnose this somehow?
>
> [*] like diff running serval times over same two files can
>    only once in a while show one character altered
>
> bye

Register corruption makes strange unrelated errors. The problem
shown is related to semaphores. Most every time any I/O is
performed to a shared device, a semaphore is used to obtain
temporary exclusive use of the device. If the semaphore code
is spilling registers, which it can with recent 'C' compilers,
the result can be random corruption.

You should just patch the kernel with the patch I provided.
It will even patch 2.4.x code because semaphore.c hasn't been
changed very often.

If the corruption goes away, you've either fixed the problem
or have changed the size of something so that something that
was getting trashed before by some completely-unrelated code,
is now able to survive.

Without some specific OOPS, some code to trace, it's just
a crap game. But, the semaphore patch can't hurt anything.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
