Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUDJLQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 07:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUDJLQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 07:16:28 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:55035 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S261993AbUDJLQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 07:16:22 -0400
Date: Sat, 10 Apr 2004 13:16:19 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.4.25] [nforce2] kernel BUG at memory.c:290!
Message-ID: <20040410111619.GA29685@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: S/MIME encrypted e-mail is welcome.
X-04-Privacy-Policy-My_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is my new nforce2 board (Gigabyte GA-7N400-L) with vanilla 2.4.25.

lspci:

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:08.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
01:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
01:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
02:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

I'm trying to get sound working with quake3. With intel810 OSS or ALSA 1.0.4
the game starts OK, there is sound in intro movie and menu, but the game is
freezeing on the 1st frame when map is loaded.

The same happens with 2.6.5, both OSS and ALSA.

So I have tried NVidia's nforce 1.0-0261 drivers - nvaudio:

modprobe nvaudio

kernel: Nvaudio: in Funcction Nvaudio_init_module
kernel: PCI: Setting latency timer of device 00:06.0 to 64
kernel: Nvaudio: NVIDIA nForce2 Audio found at IO 0xd800 and 0xd400, IRQ 5
kernel: Nvaudio: Audio Controller supports 6 channels.
kernel: NVaudio: Defaulting to base 2 channel mode.
kernel: ac97_codec: AC97  codec, id: ALG96 (Unknown)
kernel: Nvaudio: only 48Khz playback available.
kernel: Nvaudio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2

quake3 immediatelly quits to desktop without showing any graphics.  this is
100% repeatable.

dmesg:

kernel: forget_pte: old mapping existed!
kernel: kernel BUG at memory.c:290!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP: 0010:[remap_page_range+455/480]    Tainted: P
kernel: EFLAGS: 00210286
kernel: eax: 00000021   ebx: 02640027   ecx: cba78000   edx: cf55df7c
kernel: esi: c746979c   edi: 001e7000   ebp: 05820000   esp: cba79ebc
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process quake3-1.32 (pid: 7553, stackpage=cba79000)
kernel: Stack: c0275fa0 001f7000 001f7000 05639000 001e7000 c6af4524 cea94300 525f7000
kernel:        c6af4524 00010000 cc8aad40 c4c0b240 cba79f14 d08c7b9f 525e7000 b3239000
kernel:        00010000 00000027 cc8aad68 cc8aad40 00000000 c4c0b240 cba79f48 d08c7cd3
kernel: Call Trace:    [<d08c7b9f>] [<d08c7cd3>] [do_mmap_pgoff+668/1392] [sys_mmap2+118/176] [tracesys+31/35]
kernel: Apr 10 15:51:15 localhost kernel: Code: 0f 0b 22 01 d9 5c 27 c0 e9 5e ff ff ff 8d b6 00 00 00 00 8d

end of game log:

...loading 'scripts/meat_tags.shader'
...loading 'scripts/black.shader'
----- finished R_Init -----

------- sound initialization -------

end of strace log:

write(2, "\n------- sound initialization --"..., 38) = 38
setresuid32(-1, 500, -1)                = 0
open("/dev/dsp", O_RDWR)                = 48
getuid32()                              = 500
setresuid32(-1, 500, -1)                = 0
ioctl(48, SNDCTL_DSP_GETCAPS, 0xbffff524) = 0
ioctl(48, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0x817780c) = 0
ioctl(48, SNDCTL_DSP_STEREO, 0xbffff51c) = 0
ioctl(48, SNDCTL_DSP_SPEED or SOUND_PCM_READ_RATE, 0x8844874) = 0
ioctl(48, SNDCTL_DSP_SETFMT or SOUND_PCM_READ_BITS, 0xbffff518) = 0
ioctl(48, SNDCTL_DSP_GETOSPACE, 0xbffff530) = 0
mmap2(NULL, 65536, PROT_READ|PROT_WRITE, MAP_SHARED, 48, 0 <unfinished ...>
+++ killed by SIGSEGV +++

OSS:

game log looks normal.
end of strace log:

gettimeofday({1081681302, 720978}, {4294967176, 0}) = 0
--- SIGHUP (Hangup) @ 0 (0) ---
fstat64(1, {st_mode=S_IFREG|0644, st_size=27115, ...}) = 0
--- SIGCONT (Continued) @ 0 (0) ---
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x5aa5a000
write(41, "\212\2\2\0\0\0\0\0+6\1\0", 12) = -1 EPIPE (Broken pipe)
--- SIGPIPE (Broken pipe) @ 0 (0) ---
+++ killed by SIGPIPE +++

the problem was discused in some detail here:
http://www.nforcershq.com/forum/viewtopic.php?t=45329



more problems with this board:

- with any ALSA version on 2.4.25 and 2.6.5 I can't hear anything from my TV
  card (bt878).

- load of Xwindow or sound modules is freezing my internet connexion with usb
  adsl modem (sagem f@st 800), I have to restart it. 100% repeatable. I think
  this is sound related problem (Xwindow start loads bttv modules like tvaudio
  etc.).

please help, regards, Pawel

PS. please CC me replies.
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy and S/MIME info.
