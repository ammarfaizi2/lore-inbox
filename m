Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQKSUKx>; Sun, 19 Nov 2000 15:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbQKSUKm>; Sun, 19 Nov 2000 15:10:42 -0500
Received: from p219.as-l001.contactel.cz ([212.65.194.219]:4356 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S129413AbQKSUKb>;
	Sun, 19 Nov 2000 15:10:31 -0500
Date: Sun, 19 Nov 2000 20:39:03 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: John Cavan <johncavan@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Odd behaviour with agpgart
Message-ID: <20001119203903.E670@ppc.vc.cvut.cz>
In-Reply-To: <3A174C58.141E0C91@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A174C58.141E0C91@home.com>; from johncavan@home.com on Sat, Nov 18, 2000 at 10:43:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 10:43:20PM -0500, John Cavan wrote:
> Bus  1, device   0, function  0:
>   VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 5).
>     IRQ 16.
>     Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
>     Prefetchable 32 bit memory at 0xf6000000 [0xf7ffffff].
>     Non-prefetchable 32 bit memory at 0xfeafc000 [0xfeafffff].
>     Non-prefetchable 32 bit memory at 0xfe000000 [0xfe7fffff].
> 
> But agpgart sets up:
> 
> agpgart: Maximum main memory to use for agp memory: 440M
> agpgart: Detected Intel 440BX chipset
> agpgart: AGP aperture is 32M @ 0xfa000000

AGP aperture is feature of host bridge:


00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
	Flags: bus master, medium devsel, latency 32
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	          ^^^^^^^^                        ^^^^^^^^^^
	Capabilities: [a0] AGP version 1.0

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at d8000000 (32-bit, prefetchable) [size=16M]
	Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
	Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
	Capabilities: [f0] AGP version 1.0

So it matters what you have listed in 00:00.0 node, not on Matrox device.

> Needless to say, the two disagree and direct rendering is disabled.
> Attached is my .config for 2.4.0-test11-pre7. I've been wading through
> the code for AGP and DRM support, but nothing jumps out at me.

> (http://www.matrox.com/mga/support/drivers/latest/home.htm)

As matrox driver contains large BLOB which does all important things
(dualhead) usual practices about binary only software applies.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
