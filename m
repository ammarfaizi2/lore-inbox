Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbULGJD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbULGJD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULGJD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:03:26 -0500
Received: from main.gmane.org ([80.91.229.2]:14550 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261674AbULGJCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:02:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: 2.6.10-rc[2|3] protection fault on /proc/devices
Date: Tue, 07 Dec 2004 10:02:50 +0100
Message-ID: <41B571BA.4060002@gmx.net>
References: <41B4E70F.8040306@gmx.net> <20041206234044.51667e94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81.223.124.22
User-Agent: Mozilla Thunderbird 0.9 (X11/20041128)
X-Accept-Language: en-us, en
In-Reply-To: <20041206234044.51667e94.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Georg Schild <dangertools@gmx.net> wrote:
> 
>>Since 2.6.10-rc2 I am having problems accessing /proc/devices. On 
>>startup some init-skripts access this node and print out a protection 
>>fault. i am having this on pcmcia and swap startup. My system is an 
>>amd64 @3000+ in an Acer Aspire 1501Lmi at 64bit mode running gentoo. 
>>.config is the same as on 2.6.10-rc1 which works good. cat on 
>>/proc/devices gives the same problems. The kernel has just a patch for 
>>wbsd (builtin mmc-cardreader) from Pierre Ossman in use, everything else 
>>is vanilla. Does anyone know of this issue and perhaps on how to solve this?
>>
> Beyond that, perhaps something scribbled on the data structures in there. 
> Setting CONFIG_SLAB_DEBUG and/or CONFIG_DEBUG_PAGEALLOC might turn
> something up.

I don't know what caused the kernel to give up baging me but it did. I 
enabled CONFIG_DEBUG_SLAB and CONFIG_KERNEL_DEBUG and now everything 
works okay. I have inserted the patch you gave me and the wbsd-patch is 
inserted too, everything works now, don't know why, i can cat 
/proc/devices too. Loading modules is not a problem too.

> cat /proc/devices
> Character devices:
>   1 mem
>   2 pty
>   3 ttyp
>   4 /dev/vc/0
>   4 tty
>   4 ttyS
>   5 /dev/tty
>   5 /dev/console
>   5 /dev/ptmx
>   6 lp
>   7 vcs
>  10 misc
>  13 input
>  14 sound
>  21 sg
>  29 fb
>  81 video4linux
>  89 i2c
> 116 alsa
> 128 ptm
> 136 pts
> 161 ircomm
> 162 raw
> 171 ieee1394
> 180 usb
> 202 cpu/msr
> 203 cpu/cpuid
> 216 rfcomm
> 253 devfs
> 254 pcmcia
> 
> Block devices:
>   2 fd
>   3 ide0
>   7 loop
>   8 sd
>  11 sr
>  22 ide1
>  43 nbd
>  65 sd
>  66 sd
>  67 sd
>  68 sd
>  69 sd
>  70 sd
>  71 sd
>  80 i2o_block
> 128 sd
> 129 sd
> 130 sd
> 131 sd
> 132 sd
> 133 sd
> 134 sd
> 135 sd
> 180 ub
> 254 mmc

