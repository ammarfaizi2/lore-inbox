Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTKAGU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 01:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTKAGU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 01:20:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54032 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261168AbTKAGU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 01:20:56 -0500
Date: Sat, 1 Nov 2003 07:20:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Anthony DiSante <orders@nodivisions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
Message-ID: <20031101062050.GA13731@alpha.home.local>
References: <3FA34523.30902@nodivisions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA34523.30902@nodivisions.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On Sat, Nov 01, 2003 at 12:31:15AM -0500, Anthony DiSante wrote:
> The kernel is buffering the contents of each directory (album) that it 
> reads (and also, mpg321 copies each mp3 file into RAM before playing it?).  
> I understand that the idea is to stuff as much into RAM as possible to 
> reduce pagefile usage, and that the kernel will reclaim memory utilized by 
> buffers if/when it needs to.  But apparently that isn't happening fast 
> enough to allow a realtime process like music-playing to work skip-free on 
> this system with this soundcard.  I think that if I could regularly 
> forcibly dump the buffered stuff out of the RAM (dropping the used-RAM 
> percentage down to, say, 10%, like at boot time) then this would make the 
> skipping stop.

1) are you certain that none of your programs (including mpg321) leaks
   memory ? As I understand it, it's really the cache which fills memory.
2) you can try to preload your file into the cache just before playing it :
   cp $file /dev/null ; mpg321 $file

> So... do I have a correct understanding of the problem, and a correct 
> analysis of the kernel/mem issues that are related to it?  Is it possible 
> to clear some of the RAM; if so, would that help?

Unless a leak happens somewhere in the kernel, sound driver, etc..., memory
consumed by programs is restored when your programs exit. The only part which
is not restored immediately is the cache.

BTW, there may be one other reason for your problem. Considering that you
scan your disk to find random albums, I think that the system updates all
directories access time after 5s, thus preventing your player from reading
an uncached file fast enough. You might be interested in mounting it with
the 'noatime,nodiratime' options in /etc/fstab.

You might also want to try 2.4.23pre9 which includes VM changes compared to
2.4.22, and seems quite stable to me.

Regards,
Willy

