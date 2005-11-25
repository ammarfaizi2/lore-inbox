Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbVKYG3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbVKYG3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 01:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbVKYG3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 01:29:43 -0500
Received: from mail.3miasto.net ([153.19.176.2]:24793 "EHLO serwer.3miasto.net")
	by vger.kernel.org with ESMTP id S932684AbVKYG3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 01:29:43 -0500
Date: Fri, 25 Nov 2005 07:29:14 +0100 (CET)
From: Leszek Koltunski <leszek@serwer.3miasto.net>
To: linux-kernel@vger.kernel.org
Subject: Conflict between CPU Frequency scaling and snd_intel8x0m ?
Message-ID: <Pine.NEB.4.62.0511250708550.28874@serwer.3miasto.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel: vanilla 2.6.14 , not tainted
OS: Debian Etch, udev 073
Thinkpad R51

*************************************************************************
The problem: after compiling in CPU_FREQ, sound stops working: xmms 
complains about

Failed to open audio device (/dev/dsp) No such device

'dsp' is indeed missing in /dev.

After a 'mknod -m 660 dsp c 14 0' it does not complain any more, 
but even though xmms appears to be playing, no actual sound can be heard.
*************************************************************************

Now, here's .config of a kernel which has sound working:
http://www.3miasto.net/~leszek/config-2.6.14-sound-working

In this one, sound does not work:
http://www.3miasto.net/~leszek/config-2.6.14-sound-not-working

The only difference between the two

utumno:/home/leszek/tmp# diff config-2.6.14-sound-working 
config-2.6.14-sound-not-working
4c4
< # Wed Nov  9 20:45:34 2005
---
> # Fri Nov 25 12:35:25 2005
200c200,232
< # CONFIG_CPU_FREQ is not set
---
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_TABLE=y
> # CONFIG_CPU_FREQ_DEBUG is not set
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_STAT_DETAILS is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>
> #
> # CPUFreq processor drivers
> #
> # CONFIG_X86_ACPI_CPUFREQ is not set
> # CONFIG_X86_POWERNOW_K6 is not set
> # CONFIG_X86_POWERNOW_K7 is not set
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_GX_SUSPMOD is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_SPEEDSTEP_ICH is not set
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
> # CONFIG_X86_CPUFREQ_NFORCE2 is not set
> # CONFIG_X86_LONGRUN is not set
> # CONFIG_X86_LONGHAUL is not set
>
> #
> # shared options
> #
> # CONFIG_X86_SPEEDSTEP_LIB is not set

is the CPU_FREQ option.

*******************************************************************
utumno:/home/leszek/tmp# lsmod
Module                  Size  Used by
kqemu                  39112  0
radeon                103232  1
drm                    62740  2 radeon
lirc_sir               15360  0
lirc_dev               12644  1 lirc_sir
ipt_MASQUERADE          3008  1
iptable_nat             7364  1
ip_nat                 16052  2 ipt_MASQUERADE,iptable_nat
ip_conntrack           44048  3 ipt_MASQUERADE,iptable_nat,ip_nat
ip_tables              21824  2 ipt_MASQUERADE,iptable_nat
nls_iso8859_1           3776  1
nls_cp437               5440  1
ibm_acpi               24768  0
tun                     8320  0
snd_intel8x0m          14404  0
snd_intel8x0           28256  0
snd_ac97_codec         86140  2 snd_intel8x0m,snd_intel8x0
snd_ac97_bus            1792  1 snd_ac97_codec
8139too                23360  0
mii                     4224  1 8139too
snd_pcm                78280  3 snd_intel8x0m,snd_intel8x0,snd_ac97_codec
snd_timer              20228  1 snd_pcm
snd                    44132  5 
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          8136  3 snd_intel8x0m,snd_intel8x0,snd_pcm
ehci_hcd               30152  0
uhci_hcd               30032  0
ipw2200               120808  0
i810_audio             33172  0
ac97_codec             16844  1 i810_audio
usbcore               105984  3 ehci_hcd,uhci_hcd
intel_agp              18780  1
agpgart                28232  2 drm,intel_agp
serial_core            17728  0
yenta_socket           22732  3
rsrc_nonstatic         11200  1 yenta_socket
ieee80211              19912  1 ipw2200
ieee80211_crypt         4228  1 ieee80211
soundcore               7392  2 snd,i810_audio

****************************************************************************

I fail to see what CPU_FREQ would have to do with a working sound, so I 
presume it might be a bug...

Leszek
