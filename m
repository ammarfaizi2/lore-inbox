Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVGYTQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVGYTQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGYTQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:16:04 -0400
Received: from pop-altamira.atl.sa.earthlink.net ([207.69.195.62]:52109 "EHLO
	pop-altamira.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261453AbVGYTQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:16:02 -0400
Message-ID: <42E53A71.8070207@earthlink.net>
Date: Mon, 25 Jul 2005 15:16:01 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12 sound problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently upgraded my laptop, HP Pavilion N5430, from a 2.4.21 kernel 
to 2.6.12. As a result of
doing this my sound no longer works correctly. It plays the same thing 
repeatedly some number
of times - if it plays at all.

Any ideas on how to debug this would be appreciated.
Thanks,
Steve

aplay -v and aadebug output follow.

root@joker4 ~]# aplay -v /usr/share/apps/kget/sounds/started.wav
Playing WAVE '/usr/share/apps/kget/sounds/started.wav' : Unsigned 8 bit, 
Rate 11128 Hz,Mono
Plug PCM: Hardware PCM card 0 'ESS Allegro PCI' device 0 subdevice 1

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 11128
exact rate   : 11128 (11128/1)
msbits       : 8
buffer_size  : 5564
period_size  : 1391
period_time  : 125000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1391
xfer_align   : 1391
start_threshold  : 5564
stop_threshold   : 5564
silence_threshold: 0
silence_size : 0
boundary     : 1458569216
aplay: pcm_write:1171: write error: Input/output error

aadebug output:
ALSA Audio Debug v0.0.9 - Mon Jul 25 14:49:10 EDT 2005
http://alsa.opensrc.org/?page=aadebug

Kernel ----------------------------------------------------
Linux joker4.seclark.com 2.6.12-prep #1 Sun Jul 24 22:39:46 EDT 2005 
i686 athlon i386 GNU/Linux

Loaded Modules --------------------------------------------
snd_maestro3           25252  2
snd_ac97_codec         76408  1 snd_maestro3
snd_seq_dummy           3972  0
snd_seq_oss            37760  0
snd_seq_midi_event      9600  1 snd_seq_oss
snd_seq                62992  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          9228  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            51760  0
snd_mixer_oss          18304  1 snd_pcm_oss
snd_pcm               100744  4 snd_maestro3,snd_ac97_codec,snd_pcm_oss
snd_timer              33924  2 snd_seq,snd_pcm
snd_page_alloc         10116  1 snd_pcm
snd                    57860  12 
snd_maestro3,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer

Modprobe Conf ---------------------------------------------
alias snd-card-0 snd-maestro3
options snd-card-0 index=0
options snd-maestro3 index=0
remove snd-maestro3 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; 
}; /sbin/modprobe -r --ignore-remove snd-maestro3

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 
10:33:392005 UTC).
0 [PCI            ]: Allegro - ESS Allegro PCI
                     ESS Allegro PCI at 0x1400, irq 5
  1:       : sequencer
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
00-00: Allegro : Allegro : playback 2 : capture 1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0c  pcmC0D0p  seq  timer

CPU -------------------------------------------------------
model name      : mobile AMD Duron(tm) Processor
cpu MHz         : 299.999

RAM -------------------------------------------------------
MemTotal:       255652 kB
SwapTotal:      524280 kB

Hardware --------------------------------------------------
00:00.0 Host bridge: ALi Corporation M1647 Northbridge [MAGiK 1 / 
MobileMAGiK 1] (rev 04)
00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 
(rev 12)


