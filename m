Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314601AbSEFRWZ>; Mon, 6 May 2002 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314607AbSEFRWY>; Mon, 6 May 2002 13:22:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42626 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314601AbSEFRWX>; Mon, 6 May 2002 13:22:23 -0400
Date: Mon, 6 May 2002 13:24:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Vijay Kumar <jkumar@qualcomm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Limiting disk data transfer rate, Any help greatly appreciated
In-Reply-To: <5.1.0.14.0.20020506095714.01ad3ab8@mage.qualcomm.com>
Message-ID: <Pine.LNX.3.95.1020506131838.25470A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Vijay Kumar wrote:

> Hi All,
> 
> In my project we have a RAID connected to more than one machine via fibre 
> channel switch. The RAID bandwidth is shared among  machines, some of them 
> reading data at a high rate (for video streaming) and at lease one machine 
> writing data into it. Since the raid bandwidth is limited, we would like to 
> specify how the bandwidth is distributed among machines. This can not be 
> done either in the FC switch or in the RAID, so my only option right now is 
> have to specify the available bandwidth and limit the rate at which linux 
> reads data from the RAID.
> 
> I am wondering if there is a way in the linux to specify the maximum 
> bandwidth that could used with a disk. In other words I am looking for a 
> driver level implementation that does the throttling when the maximum 
> bandwidth limit is hit while reading/writing data to/from a disk.
> 
> Any help or pointers to possible solutions is greatly appreciated. I am not 
> on the list, so please CC me with your responses and suggestions.
> 
> 
> Thank you all
> 
> - Vijay

I think you can modify an existing driver, perhaps add an ioctl(), that
specifies the jiffy-count that the driver must sleep before doing each
I/O. Unfortunately, the granularity is rather large. One HZ might be
way to slow, and 0 HZ may be too fast. You can certainly experiment.

With some easy-to-write code, you can relate the sleep-interval to
the I/O length so you actually limit bandwidth.

If the system "almost" works, then you can modify HZ to get finer
granularity, perhaps 1024 would be a good value.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

