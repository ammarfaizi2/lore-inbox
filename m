Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbTAHBQC>; Tue, 7 Jan 2003 20:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267653AbTAHBQC>; Tue, 7 Jan 2003 20:16:02 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:3296
	"EHLO localhost") by vger.kernel.org with ESMTP id <S267652AbTAHBP7>;
	Tue, 7 Jan 2003 20:15:59 -0500
Date: Tue, 7 Jan 2003 17:21:46 -0800
From: Joshua Kwan <joshk@ludicrus.ath.cx>
To: linux-kernel@vger.kernel.org
Cc: jsimmons@infradead.org, dahinds@users.sourceforge.net
Subject: [2.5.54-dj1-bk] Some interesting experiences...
Message-Id: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
X-Mailer: Sylpheed version 0.8.8claws65 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.o)VI0zwbXTgp'I"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.o)VI0zwbXTgp'I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

So I pulled 2.5 bk, James' fbdev updates and linux-dj, and built.
Here are some things here and there that I have noticed so far:

(note [linux-dj] means i think it's the result of pulling from that;
[linux-2.5] means i think it's a problem with the main tree;
[fbdev] means i think it's James' problem :))

1. [linux-dj] (i think?) after pulling linux-dj i noticed that the
references to 'font.h' in drivers/video/console were broken. They were
like#include "font.h" - I have fixed this to refer to the right font.h
(#include <linux/font.h>)...

...But for some reason bk edit fails in 2.5. Says it can't plock the
files i want to edit. Any idea what's up here? I can't make a patch now
:(

2. [linux-2.5] pcmcia-cs 3.2.3 will no longer build: here is the build
log, pertinent details only.

cc  -MD -O3 -Wall -Wstrict-prototypes -pipe -Wa,--no-warn
-I../include/static -I/usr/src/linux-2.5/include -I../include
-I../modules -c cardmgr.c
In file included from cardmgr.c:200:
/usr/src/linux-2.5/include/scsi/scsi.h:185: parse error before "u8"
/usr/src/linux-2.5/include/scsi/scsi.h:185: warning: no semicolon at end
of struct or union
/usr/src/linux-2.5/include/scsi/scsi.h:186: warning: type defaults to
`int' in declaration of`ScsiLun'
/usr/src/linux-2.5/include/scsi/scsi.h:186: warning: data definition has
no type or storage class
make[1]: *** [cardmgr.o] Error 

This occurs also in whatever NEW stuff there is on the pcmcia-cs web
area. This occurs with or without having pulled -dj.

SCSI is not part of my kernel. Might this have anything to do with it?

3. [linux-2.5] PS/2 mouse goes haywire every 30 seconds or so of use.
dmesg sayeth:
mice: PS/2 mouse device common for all mice
input: PS/2 Synaptics TouchPad on isa0060/serio4

but more importantly this is the cause:

psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.

This happens on my desktop machine running 2.5.54mm3 (release) as well.

varies between 1/2 bytes.

4. [fbdev] random junk on screen at boot using radeonfb, and no blinking
cursor. 'nuff said. James, I already told you this but never cc'd it to
the mailing list so I'm saying it here just for the record.
dmesg sayeth:

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=17500 from BIOS
radeonfb: probed DDR SGRAM 32768k videoram
radeon_get_moninfo: bios 4 scratch = 10000c4
radeonfb: panel ID string: 1024x768                
radeonfb: detected DFP panel size from BIOS: 1024x768
radeonfb: ATI Radeon M6 LY DDR SGRAM 32 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END
[drm] Initialized radeon 1.7.0 20020828 on minor 0

but i doubt any of this is any use because it shows a bit AFTER the
resolution has actually changed.

5. [unsure] When poking around in /proc/acpi this stuff shows up in
kernel log/dmesg:

    ACPI-0250: *** Error: Looking up [BUF0] in namespace,
AE_ALREADY_EXISTS
    ACPI-1102: *** Error: Method execution failed
[\_SB_.BAT0._BST] (Node cff4b940), AE_ALREADY_EXISTS

This is an i845 Intel chipset. Doesn't affect usability, though.

Hope this helps development - I have my .config up at
http://ludicrus.ath.cx/~joshk/kernconf for whoever needs to refer to it.

2.5.54 is still great, btw :D

Regards
Josh

--
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest.	

--=.o)VI0zwbXTgp'I
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+G30u6TRUxq22Mx4RApRDAKCBfVcj5wk7rcqdrDezf3+KtzODpACgnIeu
1GhJL7OySsK1qEDwME1bczA=
=eE/T
-----END PGP SIGNATURE-----

--=.o)VI0zwbXTgp'I--
