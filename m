Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUJWKhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUJWKhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUJWKeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:34:31 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:57709 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266891AbUJWK3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:29:33 -0400
Message-ID: <417A3288.1000303@yahoo.com.au>
Date: Sat, 23 Oct 2004 20:29:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failures Return With 2.6.9+TSO patch.
References: <Pine.LNX.4.61.0410230435150.4620@p500> <417A2106.7010804@yahoo.com.au> <Pine.LNX.4.61.0410230522040.639@p500> <417A251A.2040209@yahoo.com.au> <Pine.LNX.4.61.0410230558060.639@p500>
In-Reply-To: <Pine.LNX.4.61.0410230558060.639@p500>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> It does not seem like they do, but they cannot be good...
> 

It seems almost inevitable that they'll happen, especially if a module
is loaded after boot (this is actually somewhere that incremental min
will help "echo some number > /proc/sys/vm/lower_zone_protection").

But from the code, the failures really won't hurt at all. It might
double the number of interrupts coming from your soundcard, but I
dare say you would never be able to notice a difference.

> I have applied the following patches
> 
> 1] TSO patch
> 2] rollup.patch
> 
> Rebooting now and will alert the list if/when I receive more page 
> allocation failures.
> 
> FYI - I started getting these with 2.6.9.
> 
> (However, it was always possible on the Dell Optiplex GX1 to create page 
> allocation failure with: ifconfig eth0 mtu 9000), however, on a 
> higher-end machine (2.6GHZ, 2GB ram, etc) ifconfig eth0 mtu 9000 worked 
> fine.
> 
> Is it something with the architecture of the box bus/box?
> 

No, probably just different configurations or memory usage patterns
of the kernel, maybe different drivers, etc.

> Why does it tend to affect one machine and not the other?
> 

Again, luck of the draw mainly. My patch should definitely help the
TSO allocation failures (it probably won't fix the sound buffer alloc
failure though, now that I've looked at it).
