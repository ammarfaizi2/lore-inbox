Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTDWL2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTDWL2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:28:05 -0400
Received: from bamb-d9b9753e.pool.mediaWays.net ([217.185.117.62]:10244 "EHLO
	rz.zidlicky.org") by vger.kernel.org with ESMTP id S263997AbTDWL2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:28:04 -0400
Date: Wed, 23 Apr 2003 13:27:00 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alan@lxorguk.ukuu.org.uk, geert@linux-m68k.org, torvalds@transmeta.com,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] M68k IDE updates
Message-ID: <20030423112700.GA973@linux-m68k.org>
References: <Pine.GSO.4.21.0304221802570.16017-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.21.0304221802570.16017-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: 22 Apr 2003 15:49:15 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
>      Linux Kernel Development <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] M68k IDE updates
> 
> On Llu, 2003-04-21 at 17:55, Geert Uytterhoeven wrote:
> > However, there's also a routine that involves more magic:
> > taskfile_lib_get_identify(). While trying to understand that one, I found more
> > commands that should call the (possible byteswapping) hwif->ata_input_id()
> > operations, like SMART commands. So first we need a clearer differentiation
> > between commands that transfer on-platter data, or other drive data.
> > 
> > Any comments from the IDE experts?
> 
> Only one, stop abusing the IDE layer and do your byte swapping via a loopback/md 
> or similar piece of code.

It seems that Geert´ idea would fit neatly into the current IDE 
system. Endianness of on disk data and drive control data are
clearly different things. A while ago Andre suggested to switch
the transport based on opcode to make it work, it might be even
more straightforward to set some flag when the handler is selected
or take a distinct handler altogether (ide_cmd_type_parser or
ide_handler_parser).

Otoh trying to solve that with loopback would mean new kernels 
wouldn´t even see the partition table of old installed harddisks
on some machines. Fixing that would require an initial ramdisk
that does setup the loopback device according to kernel version,
reading the partition table from a loop device and magically make
it appear compatible to the old devices.

Richard

