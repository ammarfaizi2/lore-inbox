Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbUJYTKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbUJYTKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUJYTIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:08:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17792 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261264AbUJYTHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:07:04 -0400
Date: Mon, 25 Oct 2004 15:07:03 -0400 (EDT)
From: linux-os <root@analogic.com>
Reply-To: linux-os@analogic.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: printk() with a spin-lock held.
In-Reply-To: <1098729672.8284.0.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0410251501370.22061@chaos.analogic.com>
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com> 
 <1098503815.13176.2.camel@krustophenia.net>  <Pine.LNX.4.61.0410250828460.18507@chaos.analogic.com>
 <1098729672.8284.0.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Lee Revell wrote:

> On Mon, 2004-10-25 at 08:32 -0400, Richard B. Johnson wrote:
>> I recall that printk() useds to just write stuff into a buffer,
>> that the buffer (the same buffer used for dmesg), was written
>> out only when it was safe to do so.
>>
>>
>> Now, if printk() can't do that anymore, how does one de-bug
>> ISR code? Or do you just heave it off the cliff and hope that
>> it flies?
>
> No, it can, I was wrong.  I was thinking of some other function.
>
> Lee

Yes. I think that the problem I observed was when the ISR
wouldn't reset the interrupt because the hardware was broken.
This makes the level-interrupt stay active forever. I put
a printk() in the ISR and I got a bug-check because printk
didn't like me.

Apparently, if the printk() buffer gets full, it bug-checks.
The behavior used to be that it would just dump overflow
on the floor.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
