Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270707AbRHKD3h>; Fri, 10 Aug 2001 23:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270709AbRHKD30>; Fri, 10 Aug 2001 23:29:26 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:31751 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S270707AbRHKD3X>; Fri, 10 Aug 2001 23:29:23 -0400
Message-ID: <3B74A69D.214B4232@damncats.org>
Date: Fri, 10 Aug 2001 23:29:33 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.7-ac11: Updated emu10k1 driver
In-Reply-To: <997485043.692.23.camel@phantasy> <997496304.898.82.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> A revision of the patch is available at
> http://www.tech9.net/rml/linux/patch-rml-2.4.7-ac11-emu10k1-2

It doesn't build. The module stuff in joystick.c conflicts with main.c
during linking, you sort of have to decide whether or not the joystick
port driver is seperate or is a part of the entire emu10k1 module. By
the way, is the joystick port driver intended to replace the one
selected under the character devices -> joystick selection?

Exact text of error:

ld -m elf_i386  -r -o emu10k1.o audio.o cardmi.o cardmo.o cardwi.o
cardwo.o ecard.o efxmgr.o emuadxmg.o hwaccess.o irqmgr.o joystick.o
main.o midi.o mixer.o passthrough.o recmgr.o timer.o voicemgr.o
main.o(.modinfo+0x40): multiple definition of `__module_author'
joystick.o(.modinfo+0x80): first defined here
ld: Warning: size of symbol `__module_author' changed from 67 to 81 in
main.o
main.o(.modinfo+0xa0): multiple definition of `__module_description'
joystick.o(.modinfo+0xe0): first defined here
ld: Warning: size of symbol `__module_description' changed from 83 to 96
in main.o
main.o: In function `init_module':
main.o(.text+0x1970): multiple definition of `init_module'
joystick.o(.text+0x220): first defined here
main.o: In function `cleanup_module':
main.o(.text+0x19b0): multiple definition of `cleanup_module'
joystick.o(.text+0x260): first defined here

John
