Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314961AbSECSGZ>; Fri, 3 May 2002 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314981AbSECSGZ>; Fri, 3 May 2002 14:06:25 -0400
Received: from pat.uio.no ([129.240.130.16]:45486 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S314961AbSECSGX>;
	Fri, 3 May 2002 14:06:23 -0400
To: linux-kernel@vger.kernel.org
Subject: aty128fb breaks on Dell Inspiron 4000
From: ilmari@ping.uio.no (Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?=)
Organization: PING
Message-ID: <d8j4rhp3z13.fsf@fimm.ifi.uio.no>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2
 (sparc-sun-solaris2.7)
Date: Fri, 03 May 2002 20:06:17 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Dell Inspiron 4000 laptop with an 8MB ATI Rage Mobility M3
video card with the following lspci output:

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
            M3 AGP 2x (rev 02) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 00b0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
                 ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium
                >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=3D64M]
        Region 1: I/O ports at ec00 [size=3D256]
        Region 2: Memory at fdffc000 (32-bit, non-prefetchable) [size=3D16K]
        Expansion ROM at <unassigned> [disabled] [size=3D128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA+ AGP- 64bit- FW- Rate=3D<none>
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

The LCD display is a 1400x1050 panel, identified by XFree86 as
follows:

        (II) R128(0): Panel size: 1400x1050
        (II) R128(0): Panel ID: Samsung LTN141P2=20=20=20=20=20=20=20=20
        (II) R128(0): Panel Type: Color, Single, TFT
        (II) R128(0): Panel Interface: LVDS

When I load the aty128fb module (I've tried with several kernels, most
recently 2.5.13), the screeen goes black and flickery with a thin,
multicolored horizontal line about 1cm from the bottom. dmesg says
this about the card when the module is loaded:

     PCI: Found IRQ 11 for device 01:00.0
     aty128fb: Rage128 BIOS not located. Guessing...
     aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR SGRAM (=
1:1)
     Console: switching to colour frame buffer device 80x30
     fb0: ATY Rage128 frame buffer device on PCI
     aty128fb: Rage128 MTRR set to ON

If I switch resolutions with fbset (logged in remotely), the display
goes completely weird, it looks like if some liquid with bright green
and purple "edges" flows from the top and the bottom of the screen,
about 5cm from the right edge. This goes on until the left half of the
screen is green and purple, then it fades to black and white (the same
thing occasionally happens when switching away from X while running at
1024x768). If I switch back to 640x480@60Hz, it goes back to the
initial black state.

If I log in remotely and start X (or switch back to the X VT, if X
was already running), the screen has 5-15cm wide bands containing
various misplaced and corrupted (except one of the bands) parts of the
image. If I switch resolutions and switch between stretched and
centered mode (Fn-F7), I can get it to look right (but still
flickering) in 800x600 and 640x480.

I hope someone can make some sense of this. I am of course more than
willing to test patches and assist in debugging.

=2D-=20
Dagfinn I. Manns=E5ker
aka. Ilmari
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.0.6 (SunOS)
Comment: Processed by Mailcrypt 3.5.6 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE80tGc1C7NxFHs+sYRAvxiAKDHnzR27ge5WKaE1cnm7UmfA027ugCfQQUo
5LP/Vvr4cHtOmzz8ZE9d8ew=
=sH1R
-----END PGP MESSAGE-----
--=-=-=--
