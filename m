Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbTAaJye>; Fri, 31 Jan 2003 04:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbTAaJye>; Fri, 31 Jan 2003 04:54:34 -0500
Received: from soul.helsinki.fi ([128.214.3.1]:21520 "EHLO soul.helsinki.fi")
	by vger.kernel.org with ESMTP id <S267744AbTAaJyd>;
	Fri, 31 Jan 2003 04:54:33 -0500
Date: Fri, 31 Jan 2003 12:03:57 +0200 (EET)
From: Mikael Johansson <mpjohans@pcu.helsinki.fi>
X-X-Sender: mpjohans@soul.helsinki.fi
To: linux-kernel@vger.kernel.org
Subject: DAC960, Alpha, 2.4.21-pre4 (Was: DAC960, 2.4.19 alpha problems)
In-Reply-To: <200301310921.h0V9LJxZ002780@eeyore.valparaiso.cl>
Message-ID: <Pine.OSF.4.51.0301311140060.80325@soul.helsinki.fi>
References: <200301310921.h0V9LJxZ002780@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello All!

After finally upgrading the 2.2 kernel on one of our alphas to the
2.4.21-pre4 kernel, the console got cluttered with EXT2 error messages
from the RAID-array on the Mylex DAC960PX. First I tought it was a file
system proble,m, but then found the following post:

On Wed, 20 Nov 2002, Ivan Kokshaysky  wrote:

> That was it, I guess.
> virt_to_bus() is deprecated - driver *must* be converted
> to the DMA mapping interface (see Documentation/DMA-mapping.txt).
>
> virt_to_bus() on alpha works only for limited range of kernel addresses.
> On dp264 valid range is 0x00000000-0x7fefffff (i.e. 2Gb - 1Mb).
> Given the fact that __get_free_pages() returns highest possible
> pages I'm not surprised that this driver doesn't work on a 2Gb machine.
>
> Probably "mem=2047M" boot argument would help...

Actually, I first compiled the kernel as "Generic", which let the system
boot. When I recompiled the kernel more specifically for the machine type,
DP264/Tsunami/2*EV67, the boot process would halt when the DAC960 driver
tried to init. (A good thing; otherwise I would still be looking at the
problem as an ext2-problem).

Anyway, the machine has 2GB mem, and the "mem=2047M" seems to help (it
boots).

A question: Is this trick safe? Or should i downgrade to an earlier
kernel?

A comment: I guess a warning/conflict message about this should also be
printed for the "Generic" (and maybe other configs that manage to boot)
kernel compilation, as it seems to lead to massive file system corruption
on the RAID-array (e2fsck -y /dev/rd/c0d0 printed "a million" screens of
errors :-)

Have a nice day,
    Mikael J.
    http://www.helsinki.fi/~mpjohans/
