Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVDASNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVDASNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVDASNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:13:32 -0500
Received: from alog0397.analogic.com ([208.224.222.173]:32925 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262705AbVDASNX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:13:23 -0500
Date: Fri, 1 Apr 2005 13:13:04 -0500 (EST)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Low file-system performance for 2.6.11 compared to 2.4.26
In-Reply-To: <424C9217.9000205@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0504011252300.14297@chaos.analogic.com>
References: <Pine.LNX.4.61.0503311129360.4710@chaos.analogic.com>
 <424C9217.9000205@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Nick Piggin wrote:

> linux-os wrote:
>>
>> For those interested, some file-system tests and a test-tools
>> are attached.
>>
>
> I'll give it a run when I get a chance. Thanks.
> In the meantime, can you try with different io schedulers?
>

I was trying to emulate some old servers that had new
kernels installed. These servers are used to send medical
images around. One used to get a 512x512x16-bit image to
a work-station in a few hundred milliseconds. It takes
seconds with the newer kernels. I found out that the
SCSI disk(s) were running continuously and sampled
their I/O patterns. The 'C' code comes very close
to emulating that.

The installation involved an "ugrade" to linux-2.6.5-1.358
that came with a RedHat Fedora distibution. The provided
code will even HALT that distibution. Everything goes
into the 'D' state and waits forever (at least overnight).

Later versions like linux-2.6.8 will run to completion
but with verrry slow through-put.

Never versions, like linux-2.6.11 will run, but with a strange
slowness, everything in 'D' and the file-system can end up with
missing files.

The SCSI controller is AIC7XXX, and the fs is ext3 with jbd, just
as it comes from Red Hat.

>> Also, my .signature disappeared during the file-system tests.
>> There were no errors and e2fsck thinks everything is fine!
>>
>
> You seem to be constantly plagued by gremlins. I don't
> know whether to laugh or cry.
>

I test many, many (too many) systems as part of my job. When
somebody writes a hardware device-driver and I get to check it,
sometimes it blows up or doesn't otherwise work. I then test the
bare kernel(s) and I often find some really strange things going
on.

For instance, there was a recent change that make the BKL be
held during an ioctl(). This has devistating performance
consequences with a lot of drivers. For instance, the stuff
that writes CD/ROMs. It does a lot of the work using ioctl(),
the firewire drivers also use ioctl() for I/O.

>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
