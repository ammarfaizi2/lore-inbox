Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTAHVOv>; Wed, 8 Jan 2003 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTAHVOv>; Wed, 8 Jan 2003 16:14:51 -0500
Received: from [81.2.122.30] ([81.2.122.30]:58374 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267869AbTAHVOu>;
	Wed, 8 Jan 2003 16:14:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301082123.h08LNXSY003383@darkstar.example.net>
Subject: Re: Killing off the boot sector (was: [STATUS 2.5]  January 8, 2002)
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 8 Jan 2003 21:23:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <avi06f$89g$1@cesium.transmeta.com> from "H. Peter Anvin" at Jan 08, 2003 12:03:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can we *please* kill off the stupid in-kernel boot sector?
> 
> Here is a patch that guts it to print an error message.  It's even
> tested.

> -# This procedure turns off the floppy drive motor, so
> -# that we enter the kernel in a known state, and
> -# don't have to worry about it later.
> -# NOTE: Doesn't save %ax or %dx; do it yourself if you need to.
> -
> -kill_motor:
> -#if 1
> -	xorw	%ax, %ax		# reset FDC
> -	xorb	%dl, %dl
> -	int	$0x13
> -#else
> -	movw	$0x3f2, %dx
> -	xorb	%al, %al
> -	outb	%al, %dx
> -#endif
> -	ret

Shouldn't that part stay, incase somebody boots a machine from a
floppy, and leaves it running for hours?

> +	.ascii	"Direct booting from floppy is no longer supported.\r\n"
> +	.ascii	"Please use a boot loader program instead.\r\n"
> +	.ascii	"\n"
> +	.ascii	"Remove disk and press any key to reboot . . .\r\n"

Couldn't you put an ASCII penguin in there?  :-)

John.
