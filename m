Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSBJA2l>; Sat, 9 Feb 2002 19:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289054AbSBJA2b>; Sat, 9 Feb 2002 19:28:31 -0500
Received: from 753-MADR-XL1.libre.retevision.es ([62.175.98.241]:45696 "HELO
	sheelab.dynodns.net") by vger.kernel.org with SMTP
	id <S289047AbSBJA2P>; Sat, 9 Feb 2002 19:28:15 -0500
Date: Sun, 10 Feb 2002 01:27:17 +0100
From: Vadim <vadim_t@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: module : QM_INFO: Invalid argument
Message-ID: <20020210002717.GA4117@thunderbird.sheelab.dynodns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this after recompiling lmsensors for 2.4.17 with the rmap 11b
patch.

Here's the part from sensors-detect:

We can start with probing for (PCI) I2C or SMBus adapters.
You do not need any special privileges for this.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.4: VIA Technologies VT82C686 Apollo ACPI
Use driver `i2c-riva' for device 01:00.0: GeForce2 MX
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.17/misc/i2c-viapro.o: module : QM_INFO: Invalid argument
Loading failed ()... skipping.
Load `i2c-riva' (say NO if built into your kernel)? (YES/no):
modprobe: module : QM_INFO: Invalid argument
Loading failed ()... skipping.
** Note: i2c-riva module is available at
** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
Do you now want to be prompted for non-detectable adapters? (yes/NO):

For some reason, lsmod doesn't work either:

[0101][root@thunderbird:detect]$ lsmod
Module                  Size  Used by
lsmod: module : QM_INFO: Invalid argument

[0107][root@thunderbird:detect]$ cat /proc/modules
                        3888   0
snd-pcm-oss            35984   2 (autoclean)
snd-mixer-oss           8560   0 (autoclean) [snd-pcm-oss]
snd-card-emu10k1        1936   2 (autoclean)
snd-emu10k1            47568   0 (autoclean) [snd-card-emu10k1]
snd-pcm                47776   0 (autoclean) [snd-pcm-oss snd-emu10k1]
snd-timer               9568   0 (autoclean) [snd-pcm]
snd-rawmidi            12032   0 (autoclean) [snd-emu10k1]
snd-hwdep               3408   0 (autoclean) [snd-emu10k1]
snd-util-mem            1248   0 (autoclean) [snd-emu10k1]
snd-ac97-codec         22688   0 (autoclean) [snd-emu10k1]
snd-seq-device          3776   0 (autoclean) [snd-card-emu10k1 snd-rawmidi]
snd                    23648   0 (autoclean) [snd-pcm-oss snd-mixer-oss snd-card-emu10k1 snd-emu10k1 snd-pcm snd-timer snd-rawmidi snd-hwdep snd-util-mem snd-ac97-codec snd-seq-device]
soundcore               3536   6 (autoclean) [snd]

I suppose the unnamed module is the problem. I tried searching Google,
but I've only found this mentioned in 2.4.0-pre6. If it's the same bug,
why it's still there? Or it's my fault?

