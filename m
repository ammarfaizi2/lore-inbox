Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268044AbTGOMn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbTGOMmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:42:07 -0400
Received: from endeavor.poss.com ([198.70.184.137]:58804 "EHLO smtp.poss.com")
	by vger.kernel.org with ESMTP id S267783AbTGOMkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:40:19 -0400
Date: Tue, 15 Jul 2003 08:52:20 -0400
From: Doug Bell <dbell@perfectorder.com>
Subject: PROBLEM: Module maestro3 fails to load on Dell Latitude C510
To: linux-kernel@vger.kernel.org
Reply-to: dbell@perfectorder.com
Message-id: <200307150852.20854.dbell@perfectorder.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module 'maestro3' fails to load either at boot or with manual insmod.

The sound codecs and core appear to be loaded, but I cannot get any sound 
output, which appears to be due to the maestro3 sound driver not loading.  
Perhaps I am mistaken, it appears to me that the sound module may be loaded, 
but it looks like something is missing.  (And no sound works)  Various Audio 
players and mixers will load, but no sound comes out.  The sound on this 
laptop has worked before with an older Linux installation.

I had tried recompiling the kernel modules from source using the 
Mandrake-supplied kernel configuration, the error appeared to be the same.

-------------------------

Error:

# insmod maestro3
Using /lib/modules/2.4.21-0.13mdk/kernel/drivers/sound/maestro3.o.gz
/lib/modules/2.4.21-0.13mdk/kernel/drivers/sound/maestro3.o.gz: unresolved 
symbol ac97_probe_codec_R84601c2b

--------------------------

Troubleshooting:

Running insmod with -m or -O produces no additional output.

-------------------------

Further information:

Linux version 2.4.21-0.13mdk (flepied@bi.mandrakesoft.com) (gcc version 3.2.2 
(Mandrake Linux 9.1 3.2.2-3mdk)) #1 Fri Mar 14 15:08:06 EST 2003

# more modules.conf
alias autofs autofs4
probeall usb-interface usb-uhci
alias sound-slot-0 maestro3

# cat /proc/pci
PCI devices found:
<snip>
  Bus  0, device   8, function  0:
    Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio 
Accelerator (rev 16).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xf3ffe000 [0xf3ffffff].

#cat ver_linux.out
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dhcp-169.poss.com 2.4.21-0.13mdk #1 Fri Mar 14 15:08:06 EST 2003 i686 
unknown unknown GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.22
e2fsprogs              1.32
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         udf sg st sr_mod sd_mod scsi_mod ide-cd cdrom 
binfmt_misc autofs4 parport_pc lp parport nfsd snd-maestro3 snd-pcm snd-timer 
snd-page-alloc snd-ac97-codec snd soundcore xircom_cb xircom_tulip_cb ds 
yenta_socket pcmcia_core af_packet ip_vs floppy nls_iso8859-1 nls_cp850 vfat 
fat supermount usb-uhci usbcore rtc ext3 jbd

#lspci -vvv
<snip>
00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI 
Audio Accelerator (rev 10)
        Subsystem: Dell Computer Corporation: Unknown device 00b1
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at f3ffe000 (32-bit, non-prefetchable) [size=8K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

# cat /proc/modules
udf                    90464   0 (autoclean)
sg                     34636   0 (autoclean) (unused)
st                     29488   0 (autoclean) (unused)
sr_mod                 16920   0 (autoclean) (unused)
sd_mod                 13100   0 (autoclean) (unused)
scsi_mod              103284   4 (autoclean) [sg st sr_mod sd_mod]
ide-cd                 33856   0 (autoclean)
cdrom                  31648   0 (autoclean) [sr_mod ide-cd]
binfmt_misc             7020   1
autofs4                11540   2 (autoclean)
parport_pc             25096   1 (autoclean)
lp                      8096   0 (autoclean)
parport                34176   1 (autoclean) [parport_pc lp]
nfsd                   74256   8 (autoclean)
snd-maestro3           15532   0 (unused)
snd-pcm                77536   0 [snd-maestro3]
snd-timer              18376   0 [snd-pcm]
snd-page-alloc          7732   0 [snd-pcm]
snd-ac97-codec         40160   0 [snd-maestro3]
snd                    40868   0 [snd-maestro3 snd-pcm snd-timer 
snd-ac97-codec]
soundcore               6276   0 [snd]
xircom_cb               8456   0 (unused)
xircom_tulip_cb        14552   1
ds                      8456   2
yenta_socket           13056   2
pcmcia_core            57184   0 [ds yenta_socket]
af_packet              14952   2 (autoclean)
ip_vs                  83192   0 (autoclean)
floppy                 55132   0
nls_iso8859-1           3516   1 (autoclean)
nls_cp850               4316   1 (autoclean)
vfat                   11820   1 (autoclean)
fat                    37944   0 (autoclean) [vfat]
supermount             15296   2 (autoclean)
usb-uhci               24652   0 (unused)
usbcore                72992   1 [usb-uhci]
rtc                     8060   0 (autoclean)
ext3                   59916   2
jbd                    38972   2 [ext3]


Please let me know if you need any other information or whether I am just 
completely missing something.

-- 
Doug Bell
Consultant / SysAdmin
Perfect Order
dbell@perfectorder.com
Cell: 717-805-1785
