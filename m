Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbUKWT1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUKWT1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKWTZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:25:31 -0500
Received: from alog0426.analogic.com ([208.224.222.202]:30336 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261490AbUKWTVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:21:01 -0500
Date: Tue, 23 Nov 2004 14:20:17 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>, Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <Pine.LNX.4.58.0411231035500.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0411231410480.7154@chaos.analogic.com>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
 <Pine.LNX.4.61.0411231916410.3389@dragon.hygekrogen.localhost>
 <Pine.LNX.4.58.0411231035500.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Linus Torvalds wrote:

>
>
> On Tue, 23 Nov 2004, Jesper Juhl wrote:
>>
>> Shutting up gcc is not the primary goal here, the goal is/was to
>> a) review the code and make sure that it is safe and correct, and fix it
>> when it is not.
>> b) remove comparisons that are just a waste of CPU cycles when the result
>> is always true or false (in *all* cases on *all* archs).
>
> Well, I'm convinced that (b) is unnecessary, as any compiler that notices
> the range thing enough to warn will also be smart enough to just remove
> the test internally.
>
> But yes, as long as the thing is a "review and fix bugs" and not a quest
> to remove warnings which may well be compiler figments, that's obviously
> ok.
>
> 			Linus
> -

There are some pretty scary macros like:
MIN(a, b) (a < b) ? a:b  You can throw any parentheses you want
around and it doesn't make it correct for selecting the lowest value
of the amount to read/write from a buffer. The a and b need to be cast
to unsigned before the comparison is made --and then some compilers
will (correctly, I'm told) compain about range.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
