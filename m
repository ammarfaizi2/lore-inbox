Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVFUPj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVFUPj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVFUPjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:39:47 -0400
Received: from alog0634.analogic.com ([208.224.223.171]:22173 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262130AbVFUPig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:38:36 -0400
Date: Tue, 21 Jun 2005 11:38:31 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: KV Pavuram <kvpavuram@yahoo.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: 0xffffe002 in ??
In-Reply-To: <20050621152133.77162.qmail@web8409.mail.in.yahoo.com>
Message-ID: <Pine.LNX.4.61.0506211132140.17269@chaos.analogic.com>
References: <20050621152133.77162.qmail@web8409.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, KV Pavuram wrote:

> I am running a multithreaded application on Linux 2.4
> kernel (RedHat Linux 9).
>
> At some point the program receives a seg. fault and if
> i check info threads, using gdb for debug, almost all
> the threads are at "0xffffe002 in ??"
>

If a number of threads arrive at the same bad address you
should look for some common code that calls through
a function pointer. If you don't have any calls through
pointers, then you may have something corrupting the stack
so that the return address of a called function gets
corrupted. For instance, if the value 0x02e0 was written
beyond array limits in local (stack) data, then when that
function returned it could actually end up 'returning'
to the bad address you discovered.

Although the kernel provided the seg-fault mechanism, this
is not a kernel problem. This is a user-code problem.

> When I switch to each of these tasks, and try x/i for
> 0xffffe002, cannot access address.
>
> What could be the problem?
>
> Please help.
>
> Regards,
> Pav.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
