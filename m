Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTAVG0k>; Wed, 22 Jan 2003 01:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbTAVG0k>; Wed, 22 Jan 2003 01:26:40 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:52242 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267353AbTAVG0j>; Wed, 22 Jan 2003 01:26:39 -0500
Message-ID: <3E2E3BA2.30401@snapgear.com>
Date: Wed, 22 Jan 2003 16:35:14 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301212339540.8909-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0301212339540.8909-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

Kai Germaschewski wrote:
> Yes, I saw it, but on the other hand I'd like to avoid introducing 
> complexity which isn't really needed. So the important question is: Is 
> there a reason that v850 does things differently, or could it just as well 
> live with separate .text and .rodata sections (Note that sections 
> like .rodata1 will be discarded when empty).

The reason we tend to group all these things together is that logically
that is the way they are layed out between flash and ram (and running
the kernel code in flash is really the case that is interresting here).
Where you have the text and rodata parts resident in flash (and this is
where they stay), and the data and bss in ram (but they start in flash
and are copied on start up to ram). So 2 very different memory regions
involved, not just one contiguous blob like on most VM architectures.

So to build a flash image most people just objcopy out the
text and the data (and init really too) sections and cat them
together and that is the binary image that you program into
your flash. If you have lots of sections this makes this
extraction and concatentation process just plain ugly. And when
you add new sections your flash building needs to know about
them and handle them.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

