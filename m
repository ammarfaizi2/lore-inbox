Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSLBKIG>; Mon, 2 Dec 2002 05:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSLBKIG>; Mon, 2 Dec 2002 05:08:06 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:40863 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S262067AbSLBKID>; Mon, 2 Dec 2002 05:08:03 -0500
Date: Mon, 2 Dec 2002 11:15:30 +0100 (CET)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: bttv: Strange frame drop-outs during TV grabbing
Message-ID: <Pine.LNX.4.21.0212021113560.8265-100000@nightmare.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When capturing video using MEncoder I experienced very strange frame
drop-outs causing the video to look jerky.

Today, I am confident this is _NOT_ MEncoder issue. See below for
reasoning. I suspect either the kernel or the hardware.

Problem description follows. Thanks for any hints.


When using mencoder to capture video from my TV card, I noticed the
picture is a little jerky from time to time. This happens even if encoding
with small resolution and the computer has plenty of CPU time idle.

After long investigation, I found a very STRANGE things --- at least it
appears very strange to me:

1) During the jerky periods, MEncoder reports "frame delta ~ 12.5s" for
each frame, which means exactly every other frame is missing.

2) The drop-outs last always almost exactly 40 frames (+/- two or three),
this means about 3.5 seconds.

3) The event occurs in REGULAR periodic intervals, every 55 seconds.
Counted in frames, every 1375 frames (+/- five or so).

But that's not all:

4) The regular period is independent of anything I have tried to alter:
resolution (both grabbed and cropped), encoding quality, target bitrate,
etc. It is even indepent of the number of buffers in the kernel and their
size (gbuffers and gbufsize parameters of bttv module).

5) The regular period is retained when I quit the MEncoder and run it
again. I.e., it happens every 55 seconds of REAL time, even if the new
MEncoder instance is run. This is why I think it is NOT the MEncoder
issue!

6) The period is also retained when I adjust the system clock. I.e., it
seems independent of the gettimeofday value.

After some more thorough investigation I also found that MEncoder is
definitely "in time" in doing the VIDIOCSYNC ioctl --- even during the
critical periods. Anyway, the kernel returns not after 40ms (25fps) as
expected but after 80ms (12.5fps).

Any idea?

Bad kernel driver?

Hardware fault?

Thanks for any advice...
   - M -

----------------------------------------------------------------

More details:

AverMedia 98 TV card

Tried with both 2.4.19 and 2.4.20-rc4-ac1 kernel.
Not yet with 2.4.20 but that wouldn't help probably.

$ uname -a
Linux *** 2.4.19 #3 Sun Oct 6 13:07:51 CEST 2002 i686 unknown unknown GNU/Linux

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 996.327
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1985.74

$ /usr/src/video/MPlayer-0.90pre10/mencoder -v -tv
on:driver=v4l:noaudio:width=512:height=384:norm=pal:chanlist=europe-east:channel=37
-ovc lavc -oac mp3lame -vop pp=lb/tn,crop=320:240:8:8 -lameopts cbr:br=64
-lavcopts vcodec=mpeg4:vbitrate=1000 -o output.avi -endpos 10:0
Using GNU internationalization
Original domain: messages
Original dirname: /usr/share/locale
Current domain: mplayer
Current dirname: /usr/local/share/locale


MEncoder 0.90pre10-2.95.4 (C) 2000-2002 Arpad Gereoffy (see DOCS!)

CPU: Intel Celeron 2/Pentium III Coppermine,Geyserville (Family: 6, Stepping: 10)

CPUflags: Type: 6 MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 0
Reading /home/martin/.mplayer/codecs.conf: can't open
'/home/martin/.mplayer/codecs.conf': není souborem ani adresáøem
Reading /usr/local/etc/mplayer/codecs.conf: 44 audio & 110 video codecs
File not found: 'frameno.avi'
get_path('font/font.desc') -> '/home/martin/.mplayer/font/font.desc'
Font /home/martin/.mplayer/font/font.desc loaded successfully! (206 chars)
Using MMX (with tiny bit MMX2) Optimized OnScreenDisplay
success: format: 0  data: 0x0 - 0x0
Detected TV! ;-)
Selected driver: v4l
 name: Video 4 Linux input
 author: Alex Beregszaszi <alex@naxine.org>
 comment: under development
Selected device: BT878(AVerMedia TVCapture 98)
 Capabilites: capture tuner overlay clipping frameram scales 
 Device type: 235
 Supported sizes: 48x32 => 924x576
 Inputs: 3
  0: Television: tuner audio tv camera  (tuner:1, norm:pal)
  1: Composite1: audio camera  (tuner:0, norm:pal)
  2: S-Video: audio camera  (tuner:0, norm:pal)
mbuf: size=17039360, frames=8
 Audio devices: 4
Video capture card reports the audio setup as follows:
  0: TV: muted=no vol=0 bass=0 treble=0 balance=0 mode=mono chan=1
  0: TV: muted=no vol=0 bass=0 treble=0 balance=0 mode=mono chan=1
  0: TV: muted=no vol=0 bass=0 treble=0 balance=0 mode=mono chan=1
  0: TV: muted=no vol=0 bass=0 treble=0 balance=0 mode=mono chan=1
Using input 'Television'
Tuner (Television) range: 0 -> 4294967295
Selected norm: pal
Tuner (Television) range: 0 -> 4294967295
Requested width: 512
Requested height: 384
Selected channel list: europe-east (including 133 channels)
Requested channel: 37
Selected channel: 37 (freq: 599,250)
requested frequency: 599,250
Current frequency: 9588 (599,250)
Current frequency: 9588 (599,250)
==> Found video stream: 0
Output format: Planar YV12
Picture values:
 Depth: 12, Palette: yuv420p (Format: Planar YV12)
 Brightness: 32768, Hue: 32768, Colour: 32512, Contrast: 27648
Allocating a ring buffer for 896 frames, 252 MB total size.
Enabling tv audio. Requested setup is:
id=0 vol=60000 bass=0 treble=0 balance=0 mode=mono chan=1
[V] filefmt:9  fourcc:0x32315659  size:512x384  fps:25,00  ftime:=0,0400
Opening video filter: [expand=-1:-1:-1:-1:1]
Expand: -1 x -1, -1 ; -1  (-1=autodetect) osd: 1
Opening video filter: [pp=lb/tn]
[expand] query(Planar YV12) -> 1
[expand] query(Planar I420) -> 1
[expand] query(Planar IYUV) -> 1
Opening video filter: [crop=320:240:8:8]
Crop: 320 x 240, 8 ; 8
==========================================================================
Opening video decoder: [raw] RAW Uncompressed Video
VDec: vo config request - 512 x 384 (preferred csp: Planar YV12)
[PP] Using external postprocessing filter, max q = 6
VDec: using Planar YV12 as output csp (no 0)
Movie-Aspect is undefined - no prescaling applied.
VO Config (512x384->512x384,flags=0,'MPlayer',0x32315659)
REQ: flags=0xC01  req=0x400  
REQ: flags=0x401  req=0x0  
REQ: flags=0x401  req=0x0  
videocodec: libavcodec (320x240 fourcc=58564944 [DIVX])
Selected video codec: [rawyv12] vfm:raw (RAW YV12)
==========================================================================
Writing AVI header...
Forcing audio preload to 0, max pts correction to 0
*** [crop] Exporting mp_image_t, 512x384x12bpp YUV planar, 294912 bytes
*** [pp] Exporting mp_image_t, 320x240x12bpp YUV planar, 115200 bytes
*** [lavc] Allocating mp_image_t, 320x240x12bpp YUV planar, 115200 bytes
*** [expand] Direct Rendering mp_image_t, 320x240x12bpp YUV planar, 115200
bytes
Pos:   9,9s    248f ( 0%)  25fps Trem:   0min   0mb  A-V:0,000 [482:0]
A/Vms 0/9 D/B/S 0/0/0  
video capture thread: frame delta ~ 12,5 fps
Pos:  10,0s    249f ( 0%)  24fps Trem:   0min   0mb  A-V:0,000 [481:0]
A/Vms 0/9 D/B/S 0/0/0 
video capture thread: frame delta ~ 12,5 fps
Pos:  10,0s    250f ( 0%)  24fps Trem:   0min   0mb  A-V:0,000 [480:0]
A/Vms 0/9 D/B/S 0/0/0 
video capture thread: frame delta ~ 12,5 fps
Pos:  10,1s    251f ( 0%)  24fps Trem:   0min   0mb  A-V:0,000 [478:0]
A/Vms 0/9
.............. etc.

