Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUAGMZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 07:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbUAGMZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 07:25:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:31141 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S265511AbUAGMZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 07:25:28 -0500
Message-ID: <3FFBF379.6080301@oracle.com>
Date: Wed, 07 Jan 2004 12:54:33 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: no ALSA sound in 2.6 on Intel 82801CA-ICH3 - OSS works
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a bit ashamed about posting this, but I couldn't find anyone with
  a similar problem googling. I admit up front that I'm ALSA-ignorant
  so this could well be a silly configuration issue...

This is a Dell Latitude C640 with

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)

I tried using ALSA in kernel or modular, but the three apps I use
  (xmms, xine and gmplayer) all report -ENODEV on /dev/dsp. This is
  /var/log/messages with in-kernel ALSA:

Dec 28 10:53:41 incident kernel: Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
Dec 28 10:53:41 incident kernel: intel8x0: clocking to 48000
Dec 28 10:53:41 incident kernel: ALSA device list:
Dec 28 10:53:41 incident kernel:   #0: Intel 82801CA-ICH3 at 0xd800, irq 11

  and the card appears to be properly detected under /proc/asound;
  this is the output when loaded as modular:

[asuardi@incident asound]$ ls
card0  cards  devices  I82801CAICH3  oss  pcm  timers  version
[asuardi@incident asound]$ cat devices
   0: [0- 0]: ctl
  25: [0- 1]: digital audio capture
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
  33:       : timer
[asuardi@incident asound]$ cat pcm
00-00: Intel ICH : Intel 82801CA-ICH3 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel 82801CA-ICH3 - MIC ADC : capture 1
[asuardi@incident asound]$ cat timers
G0: system timer : 1000.000us (10000000 ticks)
G1: RTC timer : 976.562us (100000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
[asuardi@incident asound]$ cat version
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
Compiled on Jan  3 2004 for kernel 2.6.1-rc1.


Using i810_audio from OSS just works; in 2.4 I've always been
  using OSS successfully, ALSA never worked in any 2.5.x I've
  tried.


Thanks in advance,

--alessandro

  "Immagina intensamente e vedrai
    dove gli altri pensano che non ci sia niente"
       (Cristina Dona', "Salti nell'aria")


