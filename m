Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUDCTHz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUDCTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:07:55 -0500
Received: from witte.sonytel.be ([80.88.33.193]:5022 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261879AbUDCTHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:07:53 -0500
Date: Sat, 3 Apr 2004 21:07:45 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: LM Sensors <sensors@stimpy.netroedge.com>
cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6] Rework memory allocation in i2c chip drivers
In-Reply-To: <20040403191023.08f60ff1.khali@linux-fr.org>
Message-ID: <Pine.GSO.4.58.0404032106220.23280@waterleaf.sonytel.be>
References: <20040403191023.08f60ff1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Jean Delvare wrote:
> Some times ago, Ralf Roesch reported that the memory allocation scheme
> used in the i2c eeprom driver was causing trouble on MIPS architecture:
>
> http://archives.andrew.net.au/lm-sensors/msg07233.html
>
> The cause of the problems is that we do allocate two structures with a
> single kmalloc, which breaks alignment. This doesn't seem to be a
> problem on x86, but is on mips and probably on other architectures as
> well. It happens that all other chip drivers work the same way too, so
> they all would need to be fixed.
>
> Here comes my proposal to fix the problem. A few notes:

Alternatively, define a new struct containing the two structs

    struct combined {
	struct part1 part1;
	struct part2 part2;
    };

and allocate a struct combined, and the C compiler will take care of alignment.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
