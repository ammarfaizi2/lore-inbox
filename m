Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132393AbQKKUcl>; Sat, 11 Nov 2000 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbQKKUcc>; Sat, 11 Nov 2000 15:32:32 -0500
Received: from gatekeeper.isltd.insignia.com ([195.217.222.20]:61709 "EHLO
	gatekeeper.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S132351AbQKKUcU>; Sat, 11 Nov 2000 15:32:20 -0500
Message-ID: <3A0DAD50.8C55A494@insignia.com>
Date: Sat, 11 Nov 2000 20:34:24 +0000
From: Stephen Thomas <stephen.thomas@insignia.com>
Organization: Insignia Solutions
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hindley <mh15@st-andrews.ac.uk>
CC: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: opl3 under 2.4.0-test10
In-Reply-To: <200011110826.IAA01091@hindleyhome.st-andrews.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hindley wrote:
> I am trying to setup my ALS 110 soundcard under my build of kernel
> 2.4.0-test10.
> 
> I have built in isapnp support and also the sb and opl3 drivers.
> 
> However, even though I pass opl3=0x388 on the Kernel command line all
> I get is an isapnp panic.

I'm experiencing what superficially appears to be a related problem
with an AWE64 card.  I'm building the drivers non-modular (because
I've yet to find any description of how to configure modular sound
drivers for 2.4.0).  I believe I'm making the appropriate configuration
settings - from my .config:

CONFIG_SOUND=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_ADLIB=y
CONFIG_SOUND_VMIDI=y
CONFIG_SOUND_SB=y
CONFIG_SOUND_AWE32_SYNTH=y
CONFIG_SOUND_YM3812=y

and I'm passing "opl3=0x388" to the driver.  However, if I query
what synth devices the driver supports, it only reports an
AWE32-0.4.4 (RAM512k) sample device.  I expect it report an FM synth
device, too.  I get the same (lack of) effect if I go via the
adlib_card code, by saying "adlib=0x388".  My investigations so
far have shown that when opl3_detect() first tries to get the
signature of the OPL3 device, it gets 0xff from the inb() (line
195 of drivers/sound/opl3.c in test11pre1), while the corresponding
code in 2.2.18pre19 gets 0x00.

Stephen Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
