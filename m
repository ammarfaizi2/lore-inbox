Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130436AbQK1NeY>; Tue, 28 Nov 2000 08:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130473AbQK1NeP>; Tue, 28 Nov 2000 08:34:15 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:32352 "EHLO
        medusa.sparta.lu.se") by vger.kernel.org with ESMTP
        id <S130436AbQK1NeD>; Tue, 28 Nov 2000 08:34:03 -0500
Date: Tue, 28 Nov 2000 12:44:24 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-driver not generalized enough ?
In-Reply-To: <Pine.LNX.4.10.10011271735210.16898-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1001128122844.26900A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Andre Hedrick wrote:
> Yes, I have been working on that for some time.
> This requires that the macros be exported the arch-xxx/ide.h
> Additionally it takes more work to modify the request_io and release_io,
> but it is all doable.

Right on! Do you think it would be too big a performance hit if OUT_BYTE
actually was an hwif function call instead of a macro ? OUT_BYTE has more
to do with the specific hw interface than the system architecture, really. 

Actually the entire hwif_unregister function should be handled by the hwif
itself I guess (haven't noticed that yet since I never unregister my
drivers :) 

My "hack" right now involves putting "magic" values in the io_ports array
so that OUT_BYTE separate them correctly (my controller has ONE address
where a 32-bit write does the commands, with a bitfield controlling the
IDE bus address instead of splitting into 7 + 1 separate addresses).

BTW can ide_register_hw be called from the automatic "module_init" chains
during bootup, or is that too early or too late ? It would be nice if that
was the case because otherwise we need to add to the long list in
probe_for_hwifs with initialization calls.

-BW

> On Tue, 28 Nov 2000, Bjorn Wesen wrote:
> > Hi! Quick question: is it possible to write an IDE driver for a controller
> > that is not mappable using outp and those memory-mapped thingys ? 
> > 
> > I see all the nice overrideables in struct hwif_s but the main code still
> > uses OUT_BYTE which is hardcoded to an outb_p.. non-overrideable. Same
> > thing with ide_input/output_bytes, they do direct in/out accesses also
> > without consulting any hwif specific routine.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
