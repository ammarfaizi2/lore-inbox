Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965317AbWJ2Ru3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbWJ2Ru3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWJ2Ru3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:50:29 -0500
Received: from smtp20.orange.fr ([80.12.242.26]:59697 "EHLO
	smtp-msa-out20.orange.fr") by vger.kernel.org with ESMTP
	id S965317AbWJ2Ru2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:50:28 -0500
X-ME-UUID: 20061029175027765.BAD4A1C00106@mwinf2003.orange.fr
Date: Sun, 29 Oct 2006 19:50:25 +0200
From: Samuel Ortiz <samuel@sortiz.org>
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: Oops in __wake_up_common with irda, linux-2.6.18
Message-ID: <20061029175024.GA5356@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <45426EC0.3070004@rrz.uni-koeln.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45426EC0.3070004@rrz.uni-koeln.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Berthold,

On Fri, Oct 27, 2006 at 10:40:32PM +0200, Berthold Cogel wrote:
> Hello!
> 
> I got a kernel Oops in __wake_up_common while receiving a file on my
> notebook via irda  from a Pocket PC with 'ircp -r' (sending files to the
> PocketPC works).
Could you try applying this patch:
http://marc.theaimsgroup.com/?l=linux-netdev&m=115792756816966&w=2

It's supposed to fix this OOPS. Please let me know.

Cheers,
Samuel.


> My System:
> Acer Extensa 3002 WLMi notebook
> Debian unstable/testing and irda-utils 0.9.18-3
> linux-2.6.18 (from kernel.org)
> 
> Irda (FIR) device is identified as NSC Vishay TFDS-6500. Resources have
> been identified from windows hardware manager: base 0x2F8, irq 3, dma 1.
> 
> After first catching the Oops with a 'homemade' kernel (suspend2, ...),
> I compiled the same version without any patches.
> 
> Oops:
> 
> acer01:~# ircp -r
> Waiting for incoming connection
> srv_obex_event(): Link error
> Speicherzugriffsfehler
> 
> Message from syslogd@localhost at Wed Oct 25 23:09:48 2006 ...
> 
> localhost kernel: Oops: 0000 [#2]
> localhost kernel: PREEMPT
> localhost kernel: CPU:    0
> localhost kernel: EIP is at 0x200202
> localhost kernel: eax: f0a1de1c   ebx: c02001ea   ecx: 00000000   edx:
> f0a1de28
> localhost kernel: esi: 00000000   edi: f1bf681c   ebp: f0a1df00   esp:
> f0a1ded8
> localhost kernel: ds: 007b   es: 007b   ss: 0068
> localhost kernel: Process ircp (pid: 12450, ti=f0a1c000 task=f55ee560
> task.ti=f0a1c000)
> localhost kernel: Stack: c01121b4 f0a1de1c 00000001 00000000 00000000
> 00000001 f1213e18 f0a1c000
> localhost kernel:        00000000 00200246 f0a1df1c c01134ef 00000000
> 00000000 f68e3c00 f1213e00
> localhost kernel:        f1213e24 ee21f9cc c0231c44 00000000 f98921cc
> f68e3c00 f98a8e00 f1213e00
> localhost kernel: Call Trace:
> localhost kernel: Code:  Bad EIP value.
> localhost kernel: EIP: [<00200202>] 0x200202 SS:ESP 0068:f0a1ded8
> 
> 
> /var/log/messages:
> 
> Oct 25 23:09:48 localhost kernel: 00200202
> Oct 25 23:09:48 localhost kernel: Modules linked in: af_packet
> binfmt_misc rfcomm l2cap bluetooth nfs lockd nfs_acl sunrpc thermal fan
> button sbs i2c_ec autofs4 snd_intel8x0m dm_mirror ipw2200 b44 mii
> ieee80211_crypt_tkip ieee80211_crypt_ccmp ieee80211_crypt_wep ieee80211
> ieee80211_crypt cpufreq_conservative cpufreq_ondemand
> cpufreq_performance cpufreq_powersave acpi_cpufreq freq_table processor
> sg scsi_mod snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss usbhid
> snd_mixer_oss pcmcia snd_pcm snd_seq_dummy snd_seq_oss firmware_class
> snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer
> snd_seq_device joydev snd nsc_ircc uhci_hcd ehci_hcd pcspkr intel_agp
> soundcore yenta_socket rtc i2c_i801 evdev agpgart snd_page_alloc
> ohci1394 ieee1394 rsrc_nonstatic pcmcia_core ide_cd usbcore irda cdrom
> psmouse crc_ccitt unix
> Oct 25 23:09:48 localhost kernel: EIP:    0060:[<00200202>]    Not
> tainted VLI
> Oct 25 23:09:48 localhost kernel: EFLAGS: 00210083   (2.6.18-vanilla #3)
> Oct 25 23:09:48 localhost kernel:  [<c01121b4>] __wake_up_common+0x2a/0x4a
> Oct 25 23:09:48 localhost kernel:  [<c01134ef>] __wake_up+0x1f/0x48
> Oct 25 23:09:48 localhost kernel:  [<c0231c44>] sock_def_wakeup+0x27/0x3f
> Oct 25 23:09:48 localhost kernel:  [<f98921cc>] irda_release+0x4a/0x153
> [irda]
> Oct 25 23:09:48 localhost kernel:  [<c022f577>] sock_release+0x14/0xa4
> Oct 25 23:09:48 localhost kernel:  [<c022f890>] sock_close+0x2c/0x33
> Oct 25 23:09:48 localhost kernel:  [<c014aea9>] __fput+0x84/0x152
> Oct 25 23:09:48 localhost kernel:  [<c0148a11>] filp_close+0x50/0x59
> Oct 25 23:09:48 localhost kernel:  [<c0149c4c>] sys_close+0x6f/0x9b
> Oct 25 23:09:48 localhost kernel:  [<c0102be9>] sysenter_past_esp+0x56/0x79
> Oct 25 23:09:48 localhost kernel:  <6>note: ircp[12450] exited with
> preempt_count 2
> 
> 
> I tried to debug the Oops with 'echo 4 > /proc/sys/net/irda/debug'
> previous to 'ircp -r'. After the Oops I've stopped the debug output with
> 'echo 0 > /proc/sys/net/irda/debug'. Then I've extraced the sequence
> from /var/log/kern.log
> 
> See: http://www.uni-koeln.de/~a0537/irda_debug.log
> 
> 
> Additional informations:
> 
> /etc/modprobe.d/irda-utils.local
> 
> alias irda0 nsc-ircc
> options nsc-ircc dongle_id=0x09 io=0x2f8 irq=3 dma=1
> install nsc-ircc /bin/setserial /dev/ttyS0 uart none port 0 irq 0; \
> /sbin/modprobe --ignore-install nsc-ircc
> 
> 
> /etc/default/irda-utils
> 
> ENABLE=""
> DISCOVERY="true"
> DEVICE="irda0"
> DONGLE="none"
> 
> 
> /var/log/messages during boot
> 
> ...
> Oct 25 20:37:58 localhost kernel: nsc-ircc, chip->init
> Oct 25 20:37:58 localhost kernel: nsc-ircc, Found chip at base=0x164e
> Oct 25 20:37:58 localhost kernel: nsc-ircc, driver loaded (Dag Brattli)
> Oct 25 20:37:58 localhost kernel: IrDA: Registered device irda0
> Oct 25 20:37:58 localhost kernel: nsc-ircc, Using dongle: IBM31T1100 or
> Temic TFDS6000/TFDS6500
> ...
> Oct 25 20:38:14 localhost irattach: executing: '/sbin/modprobe irda0'
> Oct 25 20:38:14 localhost irattach: executing: 'echo acer01 >
> /proc/sys/net/irda/devname'
> Oct 25 20:38:14 localhost irattach: executing: 'echo 1 >
> /proc/sys/net/irda/discovery'
> Oct 25 20:38:14 localhost irattach: Starting device irda0
> 
> 
> /var/log/dmesg during boot
> 
> ...
> nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 3 ; dma 1.
> nsc-ircc, chip->init
> nsc-ircc, Found chip at base=0x164e
> nsc-ircc, driver loaded (Dag Brattli)
> IrDA: Registered device irda0
> nsc-ircc, Using dongle: IBM31T1100 or Temic TFDS6000/TFDS6500
> 
> 
> Regards,
> 
> Berthold Cogel
> 
> 
> 
