Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316709AbSE3PZV>; Thu, 30 May 2002 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSE3PZU>; Thu, 30 May 2002 11:25:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316709AbSE3PZS>; Thu, 30 May 2002 11:25:18 -0400
Date: Thu, 30 May 2002 08:25:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <1022775219.9255.385.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0205300822380.877-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30 May 2002, Alan Cox wrote:
>
> > And last but not least: some devices which should be viewd as "same type"
> > are hooked up to different major numbers instead of sharing them.
> > Most prominent here are the differences between SCSI disks and ATA disks
> > for example. From a technical point of view they don't make *any* sense.
>
> Linus has explicitly stated he wants to do this and make all disks
> appear the same and the same place. It actually makes lots of sense.

It should be a lot easier these days, and we should be fairly close.

A device driver should really _never_ see a "device number". It should see
a request queue and a disk/controller index, so that we can arbitrarily
map different device numbers to different devices (or sometimes to the
_same_ device).

But yes, there are lots of device drivers that right now use the device
number to get the disk/controller index by themselves, so right now the
minor/major numbers mean a bit too much.

		Linus

