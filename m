Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVIMDsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVIMDsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 23:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVIMDsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 23:48:46 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:63214 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750781AbVIMDsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 23:48:45 -0400
Message-ID: <43264C1C.9030207@comcast.net>
Date: Mon, 12 Sep 2005 23:48:44 -0400
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.13 BUG tg3.c:2805 = crash (this one isn't tainted)
References: <43263CDC.1010604@comcast.net>
In-Reply-To: <43263CDC.1010604@comcast.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andy Stewart wrote:
> 
> Hi Everybody,
> 
> My dual Opteron server recently crashed with this signature (thanks for
> that serial console!).  When the crash occurred, I was moving the mouse
> and using a scrollbar in KDE.  I cannot reproduce the problem.
> 
> Please cc: me as I am not subscribed to this mailing list.  Please let
> me know if I need to supply other information, or if there are
> experiments I should conduct to further isolate this problem.  I'd like
> to help in any way possible.
> 
> Thanks!
> 
> Andy


Here, try this one instead.  Its not tainted by vmware.

I think I have an idea of what I can do to cause this to occur:

1) Run setiathome(boinc) so both CPUs are at 100% (nice) utilization
2) Run rsync to sync a few GB between machines on a 100 Mb ethernet network
3) Notice puzzlingly slow interactive response time with high (8-10)
load average.
4) Click the mouse a bunch of times here, there, everywhere in
frustration with 3(above)
5) I caused the crash within about 5 minutes.  I may be able to
reproduce it - not sure.

Thanks for looking,

Andy



- ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "drivers/net/tg3.c":2805
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in: radeon drm usbserial nfsd exportfs parport_pc lp
parport snd_pcm_oss snd_mixer_oss snd_via82xx gameport snd_ac97_codec
snd_pcm
 snd_timer snd_page_al
loc snd_mpu401_uart snd_rawmidi ipv6 w83627hf snd_seq_device snd
soundcore eeprom i2c_sensor i2c_isa edd binfmt_misc joydev usblp sg st
sr_mod i2
c_viapro i2c_core ehci
_hcd ohci_hcd evdev dm_mod usbcore tg3 reiserfs aic7xxx sym53c8xx
scsi_transport_spi sd_mod scsi_mod
Pid: 9312, comm: setiathome_4.02 Not tainted 2.6.13
RIP: 0010:[<ffffffff880be9b6>] <ffffffff880be9b6>{:tg3:tg3_poll+294}
RSP: 0000:ffffffff80465de8  EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000006e RCX: 0000000000000001
RDX: 0000000000000000 RSI: 000000003eef10fe RDI: ffff81003eef1140
RBP: ffff810038b43a38 R08: 0000000000000042 R09: ffffffff804c9320
R10: 000000000000007f R11: 0000000000000000 R12: 0000000000000000
R13: ffff81003b8ad400 R14: ffff81003de36380 R15: 000000000000006e
FS:  00002aaaab7bd0a0(0000) GS:ffffffff804ed800(0063) knlGS:000000005570a300
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00002aaaaaaff000 CR3: 000000003adec000 CR4: 00000000000006e0
Process setiathome_4.02 (pid: 9312, threadinfo ffff810001ffa000, task
ffff8100224a35d0)
Stack: 000001d7804cc540 ffff81003de363ec 000000003c61c812 0000000000000292
       0000000100000000 ffff81003de363cc ffff81003ba51000 ffffffff80465e94
       ffff81003de36000 0000000000000001
Call Trace: <IRQ> <ffffffff80130b13>{__wake_up+67}
<ffffffff802f67b0>{net_rx_action+176}
       <ffffffff8013a471>{__do_softirq+113}
<ffffffff8010ed87>{call_softirq+31}
       <ffffffff801106d5>{do_softirq+53} <ffffffff8011072f>{do_IRQ+79}
       <ffffffff8010e230>{ret_from_intr+0}  <EOI>

Code: 0f 0b a3 d8 05 0c 88 ff ff ff ff c2 f5 0a 89 d8 49 8b 56 58
RIP <ffffffff880be9b6>{:tg3:tg3_poll+294} RSP <ffffffff80465de8>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDJkwcHl0iXDssISsRAs7qAJ9sMsdPN6YQG/6a8e/TU3/dq9arcgCfaeST
OqgdzHIBjCWRVIH+2iZV6lI=
=X0sm
-----END PGP SIGNATURE-----
