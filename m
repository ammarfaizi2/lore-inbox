Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290771AbSARRxx>; Fri, 18 Jan 2002 12:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290772AbSARRxn>; Fri, 18 Jan 2002 12:53:43 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:18695 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S290771AbSARRxi>;
	Fri, 18 Jan 2002 12:53:38 -0500
Subject: Re: 2.5.3-pre1 emu10k1
From: Quinn Harris <quinn@nmt.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020117103204.GA8938@profive.com>
In-Reply-To: <20020117103204.GA8938@profive.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 18 Jan 2002 10:53:36 -0700
Message-Id: <1011376417.644.0.camel@quinn.rcn.nmt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the MINOR(...) to minor(&...) on that line.  There might be a few
more like that.

This worked for the cvs emu10k1 audigy branch for me.

The 2.5.x kernels are working toward a better way of managing device
identifiers.  kdev_t is now a structure not a short.  MINOR(x) is a
macro that wants a short, just like its always been.  But minor(x) is an
inlined function that wants a pointer to the new kdev_t struct and
returns a char representing the device minor number.  I expect MINOR
will be depreciated.

Quinn Harris

On Thu, 2002-01-17 at 03:32, Mathias Wiklander wrote:
> When I try to compile emu10k1 as a module i get this error.
> 
> gcc -D__KERNEL__ -I/usr/src/v2.5.2/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-
> strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> -DMODULE -DEMU10K1_SEQUENCER  -c -o audio.o a
> udio.c
> audio.c: In function mu10k1_audio_open':
> audio.c:1101: invalid operands to binary &
> make[3]: *** [audio.o] Error 1
> make[3]: Leaving directory /usr/src/v2.5.2/linux/drivers/sound/emu10k1'
> 
> /Eastbay
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


