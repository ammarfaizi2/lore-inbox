Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVFMOVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVFMOVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVFMOVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:21:14 -0400
Received: from alog0209.analogic.com ([208.224.220.224]:23472 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261580AbVFMOVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:21:12 -0400
Date: Mon, 13 Jun 2005 10:21:00 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: quade <quade@hsnr.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: latency error (~2ms) with nanosleep
In-Reply-To: <20050613133047.GA11979@hsnr.de>
Message-ID: <Pine.LNX.4.61.0506131011370.16830@chaos.analogic.com>
References: <20050613133047.GA11979@hsnr.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nanosleep, according to the documation is supposed to sleep
"at least" the 'struct timespec' time. It can return in
a shorter time as a result of a signal and, if so, the
input time-values will be updated accordingly. The resolution
is limited to the HZ value. This means that it will, unless
interrupted, always sleep at least 1 / HZ seconds (about 1 ms
on current x86 distributions).

FYI, there is no 'fine resolution' timer available on any
Linux-ported platform that could take advantage of the nanosecond
input resolution of the function.

On Mon, 13 Jun 2005, quade wrote:
>
> Playing around with the (simple) measurement of latency-times
> I noticed, that the systemcall "nanosleep" has always a minimal
> latency from about ~2ms (haven't run it all night, so...). It
> seems to be a systematical error.
>
> A short investigation shows, that "sys_nanosleep()" uses
> schedule_timeout(), but schedule_timeout() is working exactly
> as expected. Therefore I think it has something to do with
> the scheduling?
>
> Has someone an explanation for the ~2ms error?
> If it is indeed a systematical error, does it make sense to
> "adjust" (correct) this error in the systemcall "sys_nanosleep()"?
>
> Find attached my small test program.
>
> Juergen.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
