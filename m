Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314425AbSDRTGB>; Thu, 18 Apr 2002 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314428AbSDRTGA>; Thu, 18 Apr 2002 15:06:00 -0400
Received: from oblivion.chaosreigns.com ([207.245.78.170]:13316 "EHLO
	oblivion.chaosreigns.com") by vger.kernel.org with ESMTP
	id <S314425AbSDRTGA>; Thu, 18 Apr 2002 15:06:00 -0400
Date: Thu, 18 Apr 2002 15:05:54 -0400
From: Darxus@chaosreigns.com
To: linux-kernel@vger.kernel.org
Subject: kernel 2.2.20 scsi error w/ adaptect 2940uw + plextor PX-R820T cdr
Message-ID: <20020418150554.A1195@oblivion.chaosreigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I don't reboot between every time I try to write a cd with cdrdao
v1.1.3 on my machine running linux 2.2.20, with an Adaptect 2940uw scsi
controller and a plextor PX-R820T cdr, maybe a quarter of the time it dies
at the beginning of the burn, right after it's ruined my blank CD.  I've
tested cdrecord a few times and haven't noticed any problems.

Here's the error:

# nice --18 cdrdao write --buffers 128 --device 4,0 -v 1 *.toc
Cdrdao version 1.1.3 - (C) Andreas Mueller <mueller@daneb.ping.de>
  SCSI interface library - (C) Joerg Schilling
  L-EC encoding library - (C) Heiko Eissfeldt
  Paranoia DAE library - (C) Monty

4,0: PLEXTOR CD-R   PX-R820T    Rev: 1.03
Using driver: Generic SCSI-3/MMC - Version 1.0 (data) (options 0x0000)

Starting write at speed 8...
Pausing 10 seconds - hit CTRL-C to abort.
Process can be aborted with QUIT signal (usually CTRL-\).
Using POSIX real time scheduling.
Executing power calibration...
cdrdao: Input/output error. : scsi sendcmd: retryable error
CDB:  2A 00 FF FF FF 6A 00 00 0D 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 06 00 00 00 00 0A 00 00 00 00 29 00 00 00
Sense Key: 0x6 Unit Attention, Segment 0
Sense Code: 0x29 Qual 0x00 (power on, reset, or bus device reset occurred) Fru 0x0
Sense flags: Blk 0 (not valid)
ERROR: Write data failed.
ERROR: Writing failed.


More info...

# uname -mrsp
Linux 2.2.20 i686 unknown
# lspci
00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:0b.0 SCSI storage controller: Adaptec AIC-7881U
00:0c.0 VGA compatible controller: Trident Microsystems TGUI 9440 (rev e3)
# lsmod
Module                  Size  Used by
sr_mod                 15904   0  (autoclean)
sg                     12148   0  (autoclean)
ip_masq_ftp             3804   0  (unused)
3c59x                  21636   1  (autoclean)
nls_iso8859-1           2400   1  (autoclean)
nls_cp437               3904   1  (autoclean)
vfat                    9636   1  (autoclean)
fat                    30592   1  (autoclean) [vfat]

I reseated all related connections, no change.

Any idea why this is happening and how I can fix it ?

-- 
"The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself.  Therefore all progress
depends on the unreasonable man." - George Bernard Shaw
http://www.ChaosReigns.com
