Return-Path: <linux-kernel-owner+willy=40w.ods.org-S279176AbVBEEwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S279176AbVBEEwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 23:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S279178AbVBEEwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 23:52:21 -0500
Received: from stinkfoot.org ([65.75.25.34]:4486 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S279156AbVBEEwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 23:52:14 -0500
Message-ID: <4204514E.2040905@stinkfoot.org>
Date: Fri, 04 Feb 2005 23:53:34 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000, sshd, and the infamous "Corrupted MAC on input"
References: <42019E0E.1020205@stinkfoot.org> <20050203070415.GC17460@waste.org> <4202F725.8040509@stinkfoot.org> <20050204050822.GT2493@waste.org>
In-Reply-To: <20050204050822.GT2493@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> 
> Ok, reproduceable without ssh makes narrowing this down much easier.
> Are you seeing errors on the interface? No would indicate problems
> post CRC checking on the receive side. Do errors happen in both
> directions? If not, it may be CPU speed-related or specific to a given
> NIC - swap them if they're not onboard. 
> 
> The next test is to send patterns. Try sending yourself a gigabyte of:
> 
> #include <stdio.h>
> 
> int main(void)
> {
>         int i;
> 
>         for (i = 0; i < 0x10000000; i++) {
>                 fwrite(&i, 4, 1, stdout);
>         }
> }
> 
> If there's some sort of partial DMA transfer going on, this should
> make it evident.
> 

No errors reported on either interface.

Interesting results, in one direction though.  It seems highly likely 
the problem is only with the 82545EM as I couldn't get a botched 
transfer FROM it to the 82547EI after 20 or so attempts, (both of these 
are onboard unfortunately so no swapping).  Several transfers TO it did 
yield bad files, though (using my big 1.6G gzipped tarball).

Now, on to the patterns.  I didn't get a _single_ failure in either 
directions using what that code snippet generated in over 20 attempts. 
Perhaps we're failing on larger amounts of more complex data?

-Ethan
