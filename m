Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSLMUKz>; Fri, 13 Dec 2002 15:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbSLMUKz>; Fri, 13 Dec 2002 15:10:55 -0500
Received: from attila.bofh.it ([213.92.8.2]:11470 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S265373AbSLMUKx>;
	Fri, 13 Dec 2002 15:10:53 -0500
Date: Fri, 13 Dec 2002 21:18:32 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Cc: Gerd Knorr <kraxel@bytesex.org>
Subject: 2.5.51 oops saa7134
Message-ID: <20021213201832.GA6098@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like that the ALSA modules have not been loaded so the TV card
mixer become /dev/mixer instead of the usual /dev/mixer1 (yes, I have
the mixer_nr=1 option in modprobe.conf but it's ignored like other
saa7134 options). Then mplayer tried to use it and something unexpected
happened:


ksymoops 2.4.6 on i686 2.5.51.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.51/ (default)
     -m /boot/System.map-2.5.51 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Dec 13 21:04:20 wonderland kernel: kernel BUG at drivers/media/video/saa7134/saa7134-core.c:287!
Dec 13 21:04:20 wonderland kernel: invalid operand: 0000
Dec 13 21:04:20 wonderland kernel: CPU:    0
Dec 13 21:04:20 wonderland kernel: EIP:    0060:[<e08452d0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 13 21:04:20 wonderland kernel: EFLAGS: 00010246
Dec 13 21:04:20 wonderland kernel: eax: dff8c1d0   ebx: dff8c1d0   ecx: d5c06800   edx: 00000000
Dec 13 21:04:20 wonderland kernel: esi: 00000000   edi: dff8c000   ebp: cb7fdee4   esp: cb7fded4
Dec 13 21:04:20 wonderland kernel: ds: 0068   es: 0068   ss: 0068
Dec 13 21:04:20 wonderland kernel: Stack: dff8c1d0 00000000 dff8c000 dff8c000 cb7fdf0c e084672c c15ccc00 dff8c1d0 
Dec 13 21:04:20 wonderland kernel:        d5c06800 00000040 00000000 dff8c000 dff8c184 00000000 cb7fdf24 e08472e5 
Dec 13 21:04:20 wonderland kernel:        dff8c000 00000000 dc747740 00000000 cb7fdf64 c0148196 dc747740 00000000 
Dec 13 21:04:20 wonderland kernel: Call Trace:
Dec 13 21:04:20 wonderland kernel:  [<e084672c>] dsp_rec_start+0x4c/0x260 [saa7134]
Dec 13 21:04:20 wonderland kernel:  [<e08472e5>] dsp_poll+0x55/0x80 [saa7134]
Dec 13 21:04:20 wonderland kernel:  [<c0148196>] do_select+0xe6/0x1e0
Dec 13 21:04:20 wonderland kernel:  [<c0147f50>] __pollwait+0x0/0xa0
Dec 13 21:04:20 wonderland kernel:  [<c01485cc>] sys_select+0x30c/0x430
Dec 13 21:04:20 wonderland kernel:  [<c0108aa3>] syscall_call+0x7/0xb
Dec 13 21:04:20 wonderland kernel: Code: 0f 0b 1f 01 40 d3 84 e0 8b 50 04 8b 45 18 8d 14 82 31 c0 3b 


>>EIP; e08452d0 <END_OF_CODE+204bf088/????>   <=====

Trace; e084672c <END_OF_CODE+204c04e4/????>
Trace; e08472e5 <END_OF_CODE+204c109d/????>
Trace; c0148196 <do_select+e6/1e0>
Trace; c0147f50 <__pollwait+0/a0>
Trace; c01485cc <sys_select+30c/430>
Trace; c0108aa3 <syscall_call+7/b>

Code;  e08452d0 <END_OF_CODE+204bf088/????>
00000000 <_EIP>:
Code;  e08452d0 <END_OF_CODE+204bf088/????>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e08452d2 <END_OF_CODE+204bf08a/????>
   2:   1f                        pop    %ds
Code;  e08452d3 <END_OF_CODE+204bf08b/????>
   3:   01 40 d3                  add    %eax,0xffffffd3(%eax)
Code;  e08452d6 <END_OF_CODE+204bf08e/????>
   6:   84 e0                     test   %ah,%al
Code;  e08452d8 <END_OF_CODE+204bf090/????>
   8:   8b 50 04                  mov    0x4(%eax),%edx
Code;  e08452db <END_OF_CODE+204bf093/????>
   b:   8b 45 18                  mov    0x18(%ebp),%eax
Code;  e08452de <END_OF_CODE+204bf096/????>
   e:   8d 14 82                  lea    (%edx,%eax,4),%edx
Code;  e08452e1 <END_OF_CODE+204bf099/????>
  11:   31 c0                     xor    %eax,%eax
Code;  e08452e3 <END_OF_CODE+204bf09b/????>
  13:   3b 00                     cmp    (%eax),%eax


1 warning and 1 error issued.  Results may not be reliable.


mplayer output:

Cache fill:  0,00% (0 bytes)    Detected AVI file format!
VIDEO:  [DX50]  608x320  24bpp  25,00 fps  843,9 kbps (103,0 kbyte/s)
==========================================================================
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
AUDIO: 44100 Hz, 2 ch, 16 bit (0x10), ratio: 12000->176400 (96,0 kbit)
Selected audio codec: [mp3] afm:mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
vo: X11 running at 1024x768 with depth 24 and 32 bpp (":0.0" => local display)
Disabling DPMS
Opening video filter: [eq]
==========================================================================
Trying to force video codec driver family ffmpeg ...
Opening video decoder: [ffmpeg] FFmpeg's libavcodec codec family
Selected video codec: [ffodivx] vfm:ffmpeg (FFmpeg MPEG-4)
==========================================================================
audio_setup: driver doesn't support SNDCTL_DSP_GETOSPACE :-(
Segmentation fault
[Exit 139 (SIGSEGV)]



Module                  Size  Used by
ppp_deflate             4418  0 [unsafe]
zlib_deflate           20403  1 ppp_deflate [permanent]
zlib_inflate           20547  1 ppp_deflate [permanent]
bsd_comp                4892  0 [unsafe]
af_packet              14583  2 [unsafe]
ppp_async               8524  1 [unsafe]
ppp_generic            19950  6 ppp_deflate bsd_comp ppp_async [unsafe]
slhc                    6087  1 ppp_generic
ne2k_pci                6594  1
8390                    7419  1 ne2k_pci
crc32                   1851  2 8390 [unsafe]
psmouse                 5702  0
mousedev                6627  1
saa7134                58725  1
video_buf              13505  1 saa7134 [permanent]
v4l1_compat            10519  1 saa7134 [permanent]
soundcore               5787  1 saa7134
i2c_core               19408  1 saa7134
v4l2_common             3242  1 saa7134 [permanent]
videodev                7090  1 saa7134

-- 
ciao,
Marco
