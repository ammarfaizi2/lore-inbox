Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRBEQyQ>; Mon, 5 Feb 2001 11:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135379AbRBEQyG>; Mon, 5 Feb 2001 11:54:06 -0500
Received: from vulcan.datanet.hu ([194.149.0.156]:46962 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S135378AbRBEQx6>;
	Mon, 5 Feb 2001 11:53:58 -0500
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: Datakart Geodzia KFT.
To: Louis Garcia <louisg00@bellsouth.net>
Date: Mon, 5 Feb 2001 17:53:15 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: nvidia fb 0.9.0 (0.9.2?)
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A7E3075.10407@bellsouth.net>
X-mailer: Pegasus Mail for Win32 (v3.01d)
Message-Id: <E14PotN-0002qZ-00@aleph0.datakart.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Louis Garcia <louisg00@bellsouth.net> wrote:

> I gave upgraded to 2.4.2pre on my RH7 box and while using riva-128 fb 
> noticed when in X all the white parts of my desktop are to dark, it is 
> almost unreadable. I think it might have to do with video timing, is 
> there a way to fix this?

	Hi!

Color handling on Riva 128 in 8bpp mode is a little bit confused.
The table below summarizes the depth of color registers in 8bpp mode:

                | Riva 128 | Riva TNT and higher
----------------+----------+--------------------
XF86            | 6 bit    | 8 bit
----------------+----------+--------------------
rivafb < 0.7.2  | 6 bit    | 6 bit 'dark console'
----------------+----------+--------------------
rivafb 0.7.3    | 6 bit    | 8 bit
----------------+----------+--------------------
rivafb 0.9.2    | 8 bit    | 8 bit
----------------+----------+--------------------

The Riva hardware can be programmed to expect 8 bit or 6 bit color 
registers. Rivafb < 0.7.2 used 6 bit color registers, but the hw was 
programmed to 8 bit registers on TNT/TNT2. That was causing the so 
called 'dark console' bug.
Rivafb 0.9.2 begins to utilize 8 bits on Riva 128, but your X server 
uses only 6 bits of them so your desktop's brightness is 1/4. Now 
Riva 128 has a 'dark X' bug. :)
The X server should be patched. Which X server/version are you using?

Regards:
	Ferenc Bakonyi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
