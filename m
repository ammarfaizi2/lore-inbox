Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262343AbSJHNJm>; Tue, 8 Oct 2002 09:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbSJHNJm>; Tue, 8 Oct 2002 09:09:42 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:10619 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262343AbSJHNJk>; Tue, 8 Oct 2002 09:09:40 -0400
Date: Tue, 8 Oct 2002 14:59:22 +0200
From: Andreas Bergen <andreas.bergen@online.de>
To: Dave Spadea <dave@spadea.net>
Subject: Re: Kernel-oops
Message-ID: <20021008125922.GA3695@erde.erde.bergen>
References: <20021007145416.GA4695@erde.erde.bergen> <200210071636.48957.dave@spadea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210071636.48957.dave@spadea.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dave,

> 	Is this a machine that had previously been running without a
> problem? I ask because that would mostly eliminate the issue of
> incompatibilities. Right off, I'll say that it's my experience that
> kernel oopses are usually memory or hardware fault related. In order
> to test this hypothesis, you can try:

the problem is, that the machine ran without any problem until I
upgraded to kernel version 2.4.18. Originally I used the kernel which
was provided by the SuSE 8.0-CDs (2.4.18-4GB). Later I compiled my own
kernel, I upgraded to 2.4.19 but nothing helped.

 
> 1. removing all but one memory module and see if you keep getting oopses. If 
> they continue, take that one out and try another. Cycle them all through in 
> this manner to see if this might cause a problem. Also, try running memtest86 
> for 24 hours of so. I think you can find it on Freshmeat.

I think it's not very likely that the problem is due to a hardware
problem as the first oops I ever got (after several years of happy
Linuxing) happened at the day I upgraded to 2.4.18-4GB and it never
stopped since then. I had memtest86 running once for several hours
which reported no problem.


> 3. After all that, the possibility does exist that there's a bug in a driver 
> for one of your devices. Make sure that you're using the latest version of 
> the kernel. 

I do (2.4.19). BTW, I don't have any special devices running (serial
mouse, ATA CD-ROM, SB16 Soundcard, Matrox Mystique Graphics-Card, the
streamer I have and which works smoothlessly is normally not activated
as the corresponding modules are not loaded).

> If you are, paste the text of the oops into an email to 
> linux-kernel, along with a description of when it seems to happen, or any 
> other information that might help: the contents of /proc/pci, output of 
> lsmod... I think there's a FAQ somewhere that describes what you should 
> include, but I don't remember where it is. 

I can't find any regularity in when it happens. 

/proc/pci:
cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 3).
      Master Capable.  Latency=32.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (rev 0).
      Master Capable.  Latency=32.
      I/O at 0xf000 [0xf00f].
  Bus  0, device  10, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG [Mystique] (rev 2).
      IRQ 11.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1003fff].
      Prefetchable 32 bit memory at 0xe0000000 [0xe07fffff].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0ffffff].


/sbin/lsmod:
Module                  Size  Used by    Not tainted
ipt_TCPMSS              2368   0 (autoclean)
ipt_TOS                 1024   0 (autoclean)
ipt_state                608   0 (autoclean)
ipt_LOG                 3168   0 (autoclean)
ip_nat_ftp              2944   0 (unused)
ip_conntrack_ftp        3200   0 (unused)
ppp_deflate            39456   0 (autoclean)
bsd_comp                4032   0 (autoclean)
ppp_async               6336   0 (autoclean)
snd-mixer-oss           8736   1 (autoclean)
snd-pcm-oss            34628   0 (autoclean)
autofs                  8868   1 (autoclean)
parport_pc             11972   1 (autoclean)
lp                      5856   0 (autoclean)
parport                13888   1 (autoclean) [parport_pc lp]
snd-opl3-synth          8476   0 (unused)
snd-seq-instr           4224   0 [snd-opl3-synth]
snd-seq-midi-emul       4464   0 [snd-opl3-synth]
snd-seq                33292   0 [snd-opl3-synth snd-seq-instr snd-seq-midi-emul]
snd-ainstr-fm           1332   0 [snd-opl3-synth]
snd-sb16                3236   1
snd-sb16-csp           15072   0 [snd-sb16]
snd-opl3-lib            5152   0 [snd-opl3-synth snd-sb16]
snd-hwdep               3456   0 [snd-sb16-csp snd-opl3-lib]
snd-sb16-dsp            5248   0 [snd-sb16]
snd-pcm                46912   0 [snd-pcm-oss snd-sb16-dsp]
snd-timer               9088   0 [snd-seq snd-opl3-lib snd-pcm]
snd-sb-common           6056   0 [snd-sb16 snd-sb16-csp snd-sb16-dsp]
snd-mpu401-uart         2592   0 [snd-sb16 snd-sb16-dsp]
snd-rawmidi            11776   0 [snd-mpu401-uart]
snd-seq-device          3696   0 [snd-opl3-synth snd-seq snd-opl3-lib snd-rawmidi]
snd                    23592   0 [snd-mixer-oss snd-pcm-oss snd-opl3-synth snd-seq-instr snd-seq snd-sb16 snd-sb16-csp snd-opl3-lib snd-hwdep snd-sb16-dsp snd-pcm snd-timer snd-sb-common snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3492   6 [snd]
ipv6                  124864  -1 (autoclean)
ppp_generic            16236   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4480   0 (autoclean) [ppp_generic]
ipt_REJECT              2784   0 (autoclean)
iptable_mangle          2112   0 (autoclean)
iptable_nat            13076   1 (autoclean) [ip_nat_ftp]
ip_conntrack           13228   3 (autoclean) [ipt_state ip_nat_ftp ip_conntrack_ftp iptable_nat]
iptable_filter          1728   0 (autoclean)
ip_tables              10528  10 [ipt_TCPMSS ipt_TOS ipt_state ipt_LOG ipt_REJECT iptable_mangle iptable_nat iptable_filter]
md                     56896   0 (autoclean)


What makes me wonder is the message from Sep 16 saying:
Sep 16 14:31:18 erde kernel: kernel BUG at page_alloc.c:206!


> I hope this helps! Sorry I can't be more specific. I'm not really a kernel guy 
> - I just try to keep up with all of the goings-on! :-)

Thanks for your suggestions. I hope we can find the problem.

  Andreas

-- 
Andreas Bergen
E-Mail: andreas.bergen@online.de
PGP-Key on keyservers.
"Freuet euch in dem Herrn allewege, und abermals sage ich: Freuet euch!" Phi 4,4
