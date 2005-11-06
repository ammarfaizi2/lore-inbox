Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVKFPEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVKFPEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVKFPEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:04:08 -0500
Received: from soundwarez.org ([217.160.171.123]:41708 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751064AbVKFPEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:04:07 -0500
Date: Sun, 6 Nov 2005 16:03:59 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051106150359.GA9509@vrfy.org>
References: <E1EYdMs-0001hI-3F@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EYdMs-0001hI-3F@think.thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 12:47:02AM -0500, Theodore Ts'o wrote:
> 
> When I upgraded to 2.6.14 from 2.6.14-rc5, my X server failed to stop.  
> Investigation revealed it was because my CorePointer was the Synaptics
> driver, and the device corresponding to the Synaptics touchpad
> (/dev/input/event2 on my laptop) was not being created.  Once I manually
> created the device with the proper major/minor device numbers, X started
> correctly.
> 
> A comparison of "udevinfo -e" on 2.6.14-rc5 and 2.5.14 reveals the
> following differences.  Was this change deliberate?  And can it be
> reverted?
> 
> --- udevinfo-2.6.14-rc5	2005-11-06 00:17:06.000000000 -0500
> +++ udevinfo-2.6.14	2005-11-06 00:22:42.000000000 -0500
> @@ -86,27 +86,15 @@
>  P: /class/cpuid/cpu0
>  N: cpu/0/cpuid
>  
> -P: /class/input/event0
> -N: input/event0
> -
> -P: /class/input/event1
> -N: input/event1
> -
> -P: /class/input/event2
> -N: input/event2
> -
> -P: /class/input/event3
> +P: /class/input/input3/event3
>  N: input/event3
>  
> +P: /class/input/input3/mouse1
> +N: input/mouse1
> +
>  P: /class/input/mice
>  N: input/mice
>  
> -P: /class/input/mouse0
> -N: input/mouse0
> -
> -P: /class/input/mouse1
> -N: input/mouse1
> -
>  P: /class/misc/device-mapper
>  N: mapper/control

The change in the path in udevinfo is correct with that kernel, but it
seems, that you miss some devices.

What does:
  find /sys/class/input
print?

What does:
  ls -l /dev/input
print?

Are the same modules loaded after bootup?

If the devices show up in /sys/class/input, but not in /dev/input,
does running:
  /sbin/udevstart
create them?

Thanks,
Kay
