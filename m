Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270196AbRHGMMI>; Tue, 7 Aug 2001 08:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270197AbRHGML6>; Tue, 7 Aug 2001 08:11:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270196AbRHGMLk>; Tue, 7 Aug 2001 08:11:40 -0400
Date: Tue, 7 Aug 2001 08:11:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: Colin Walters <walters@cis.ohio-state.edu>, linux-kernel@vger.kernel.org
Subject: Re: eepro100 (PCI ID 82820) lockups/failure
In-Reply-To: <20010807032443.A10193@saw.sw.com.sg>
Message-ID: <Pine.LNX.3.95.1010807080036.4756A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Andrey Savochkin wrote:
[SNIPPED...]


> 
> However, for this particular case I'm interested about a loop like
> 	while((a = readb(reg)) && --count >= 0);
> I wonder if there are circumstances in which the repeated read's can return
> "cached" values or whatever, so that the loop will result in significantly less
> number of bus cycles than it's supposed?
> My understanding is that there shouldn't be such.
> 
> Best regards
> 		Andrey

You should have obtained access to the PCI address space by using
ioremap_nocache(). If so, every read will go to the bus. However,
what is actually read will be long-words so, if the device assumes
something else, its broken. FYI, some ISA word-addressed boards
have been "converted" to PCI by glueing on a PCI interface chip.
They require some strange hacks to work, like reading a byte register
by using the lowest long-word-aligned address that will contain that
byte and shifting the result.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


