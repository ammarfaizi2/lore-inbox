Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVDDTDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVDDTDN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDDTDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:03:13 -0400
Received: from alog0155.analogic.com ([208.224.220.170]:53474 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261332AbVDDTDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:03:02 -0400
Date: Mon, 4 Apr 2005 15:02:26 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: mmap() and ioctl()
In-Reply-To: <20050404182749.GA6464@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.61.0504041453440.5597@chaos.analogic.com>
References: <20050404182749.GA6464@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Matthew Dharm wrote:

> This probably is a silly question, but....
>
> Is is possible to open a file, mmap() it into memory, then pass the address
> of that map via an ioctl() call to the kernel, which will copy_from_user()
> that data?
>

Yes. A user-mode pointer, passed via ioctl() is valid in the kernel
in the context of the user, i.e., during read() write() ioctl().

However, it is not valid if it is accessed by some other process or
an interrupt. In other words, you can't store it somewhere and
access it later in some other context.

> Yeah, that's an odd concept, I know... I could always malloc() some
> memory, read the file in, and then ioctl() it.  But, if I could get away
> with a direct mmap(), that would be much better for me.
>
> Matt
>

Since you need to copy anyway, you could mmap() your kernel
data (impliment mmap in your driver). Then you mmap both
"files" the same way and copy to/from in user-mode.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
