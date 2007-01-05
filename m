Return-Path: <linux-kernel-owner+w=401wt.eu-S1030347AbXAEGez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbXAEGez (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 01:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbXAEGez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 01:34:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:13095 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030347AbXAEGey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 01:34:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RdgisZUX/03IRA4mzCzgXPZXLlHTXuWdrA5i3JXUOzEhwt1eGqgovSE45m0nKhlBIuYKr+pZ9rKtBLePS0qVNkCqpUxUJ3pVe4BooRTQKphlQ80hYAezu99JJMo5tiUjanMVMVMsK31IchAyOD4oHuQyJx8XrBv/FR9H5s+fHjc=
Message-ID: <43a19780701042234w404f8453h322fa11df463748c@mail.gmail.com>
Date: Fri, 5 Jan 2007 01:34:52 -0500
From: "xt knight" <xtknight.l@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: JMicron JMB363 problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been receiving odd error messages (accompanied by freezing up)
over the days.  They are originating from the JMicron controller.

Setup:
Gigabyte GA-965P-DS3 (Intel 965P Express) rev 2.0, latest BIOS (F9)
-Intel ICH8 on-board [IDE emulation mode]
--250G Maxtor SATA --   /dev/sda
--250G Western Digital SATA  --   /dev/sdb

-JMicron JBM363 on-board [IDE mode]
--Toshiba-Samsung DVD burner IDE (primary) --  /dev/hde
--HP DVD burner IDE (slave) --  /dev/hdf

Intel Core 2 Duo E6300 (1.86 GHz)

Kernel: Linux andy-desktop 2.6.19.1 #1 SMP Thu Dec 28 01:08:25 EST
2006 x86_64 GNU/Linux

--------------

Here are the messages:

Jan  4 13:25:04 andy-desktop kernel: [ 6326.349175] hde:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.

Jan  4 13:39:50 andy-desktop kernel: [ 7211.582430] hdf:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.

Jan  4 13:40:50 andy-desktop kernel: [ 7271.633086] hdf:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.

--------------

One night, my dmesg was filled with this:

Jan  4 15:43:30 andy-desktop kernel: [14624.213835] hdf: status error:
status=0x58 { DriveReady SeekComplete DataRequest }
Jan  4 15:43:30 andy-desktop kernel: [14624.213842] ide: failed opcode
was: unknown
Jan  4 15:43:30 andy-desktop kernel: [14624.213846] hdf: drive not
ready for command
Jan  4 15:43:32 andy-desktop kernel: [14626.213105] hdf: status error:
status=0x58 { DriveReady SeekComplete DataRequest }

--------------

Today I got this:

Jan  4 18:22:35 andy-desktop kernel: [ 7944.113598] hdf:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:22:57 andy-desktop kernel: [ 7966.141664] hdf:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:23:23 andy-desktop kernel: [ 7992.180909] hdf:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:38:26 andy-desktop kernel: [ 8893.593383] hdf:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:43:02 andy-desktop kernel: [ 9169.847963] hde:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:44:57 andy-desktop kernel: [ 9283.998206] hde:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:50:25 andy-desktop kernel: [ 9612.470630] hde:
cdrom_pc_intr: The drive appears confused (ireason = 0x01). Trying to
recover by ending request.
Jan  4 18:55:22 andy-desktop kernel: [ 9909.174069] cdrom_pc_intr,
write: dev hdf: type=d, flags=1088
Jan  4 18:55:22 andy-desktop kernel: [ 9909.174073]
Jan  4 18:55:22 andy-desktop kernel: [ 9909.174074] sector 0, nr/cnr 0/0
Jan  4 18:55:22 andy-desktop kernel: [ 9909.174077] bio
0000000000000000, biotail 0000000000000000, buffer 0000000000000000,
data 0000000000000000, len 0

--------------

Controller:

03:00.1 IDE interface: JMicron Technologies, Inc. JMicron 20360/20363
AHCI Controller (rev 02)

--------------

lsmod:

Module                  Size  Used by
isofs                  38372  1
vmnet                  43168  15
vmmon                 146188  11
binfmt_misc            14476  1
rfcomm                 43944  0
hidp                   21120  2
l2cap                  27264  10 rfcomm,hidp
bluetooth              60420  5 rfcomm,hidp,l2cap
cpufreq_userspace       6432  0
cpufreq_stats           8416  0
cpufreq_powersave       3456  0
cpufreq_ondemand       10640  0
freq_table              6592  2 cpufreq_stats,cpufreq_ondemand
cpufreq_conservative     9992  0
video                  19336  0
sbs                    18240  0
i2c_ec                  7168  1 sbs
button                  9120  0
battery                12296  0
container               6400  0
ac                      7304  0
asus_acpi              19620  0
nls_utf8                3712  1
ntfs                   99784  1
ipv6                  278944  16
af_packet              26252  2
dm_mod                 63568  0
md_mod                 81308  1
ppdev                  11400  0
sbp2                   28164  0
psmouse                41744  0
lp                     14920  0
snd_emu10k1_synth       9216  0
snd_emux_synth         39040  1 snd_emu10k1_synth
snd_seq_virmidi         9344  1 snd_emux_synth
snd_seq_midi_emul       9088  1 snd_emux_synth
snd_seq_dummy           5636  0
snd_seq_oss            35584  0
snd_seq_midi           10816  0
snd_seq_midi_event      9856  3 snd_seq_virmidi,snd_seq_oss,snd_seq_midi
snd_seq                58368  9
snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
sky2                   45064  0
snd_hda_intel          23200  0
snd_hda_codec         203008  1 snd_hda_intel
nvidia               7748376  32
tsdev                  10240  0
sg                     39592  0
snd_pcm_oss            47136  0
snd_mixer_oss          19072  1 snd_pcm_oss
snd_emu10k1           128224  3 snd_emu10k1_synth
i2c_core               26112  2 i2c_ec,nvidia
snd_rawmidi            28832  3 snd_seq_virmidi,snd_seq_midi,snd_emu10k1
snd_ac97_codec        110168  1 snd_emu10k1
snd_ac97_bus            4224  1 snd_ac97_codec
snd_seq_device         10260  8
snd_emu10k1_synth,snd_emux_synth,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_emu10k1,snd_rawmidi
snd_util_mem            6784  2 snd_emux_synth,snd_emu10k1
snd_hwdep              12040  2 snd_emux_synth,snd_emu10k1
snd_pcm                89480  5
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_emu10k1,snd_ac97_codec
snd_timer              26248  3 snd_seq,snd_emu10k1,snd_pcm
emu10k1_gp              5760  0
gameport               18576  2 emu10k1_gp
snd                    65768  19
snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq,snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_seq_device,snd_hwdep,snd_pcm,snd_timer
soundcore              10528  1 snd
snd_page_alloc         11792  3 snd_hda_intel,snd_emu10k1,snd_pcm
ata_generic             9860  0
floppy                 66792  0
pcspkr                  4864  0
intel_agp              28096  1
shpchp                 40748  0
pci_hotplug            35844  1 shpchp
evdev                  12928  1
parport_pc             39720  1
parport                42636  3 ppdev,lp,parport_pc
ext3                  141456  3
jbd                    64240  1 ext3
mbcache                11528  1 ext3
usbhid                 44576  0
ohci1394               37064  0
ieee1394              363128  2 sbp2,ohci1394
ehci_hcd               34312  0
uhci_hcd               27024  0
ide_generic             2816  0 [permanent]
usbcore               151208  4 usbhid,ehci_hcd,uhci_hcd
ahci                   23684  0
sd_mod                 23552  7
ide_cd                 43424  1
cdrom                  40232  1 ide_cd
ata_piix               19464  5
libata                112160  3 ata_generic,ahci,ata_piix
scsi_mod              157368  5 sbp2,sg,ahci,sd_mod,libata
generic                 8452  0 [permanent]
thermal                17168  0
processor              35720  1 thermal
fan                     6920  0
vga16fb                14488  0
cfbcopyarea             5248  1 vga16fb
vgastate                9984  1 vga16fb
cfbimgblt               4352  1 vga16fb
cfbfillrect             5888  1 vga16fb

--------------

If you would like more information, please let me know.
