Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSFEGEM>; Wed, 5 Jun 2002 02:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSFEGEL>; Wed, 5 Jun 2002 02:04:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:16064 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S293680AbSFEGEK>; Wed, 5 Jun 2002 02:04:10 -0400
Date: Wed, 5 Jun 2002 08:04:08 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org, <arjanv@redhat.com>
Subject: Re: 2.4.19-pre10-ac1: Hardcoded cpu_khz in powernow-k6.c
In-Reply-To: <20020605030223.A5277@suse.de>
Message-ID: <Pine.NEB.4.44.0206050754510.9994-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Dave Jones wrote:

>  > while reading through powernow-k6.c in 2.4.19-pre10-ac1 I found the
>  > following that seems to be a bug:
>  >
>  >   static unsigned long cpu_khz=350000;
>  >
>  > Not every K6-2/3 runs at 350 MHz...
>
> iirc, there aren't any MSRs[*] on the K6-2 where we can read
> the current FSB.  I think 350MHz was used as it was probably
> the slowest K6-2 to be found at the time.  You can override
> it with boot time arguments.

Really? From reading the code I have the impression that cpu_khz holds
more or less the information a "cat /proc/cpuinfo | grep MHz" gives for a
CPU at it's "normal" speed. The only place where cpu_khz is used is in

  busfreq = cpu_khz / get_cpu_multiplier() / 1000;

and this gives IMHO a wrong result if the "normal" speed of your CPU is
different from 350 MHz.

>     Dave.

cu
Adrian

BTW: 350MHz was never the slowest K6-2, there are K6-2 @ 300 MHz.

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

