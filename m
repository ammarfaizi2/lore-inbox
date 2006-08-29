Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWH2XPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWH2XPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 19:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWH2XPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 19:15:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:40877 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751143AbWH2XPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 19:15:41 -0400
X-Authenticated: #31060655
Message-ID: <44F4CA96.6060607@gmx.net>
Date: Wed, 30 Aug 2006 01:15:34 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060728 SUSE/1.0.4-2.1 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Dag Brattli <dag@brattli.net>, irda-users@lists.sourceforge.net
Subject: General protection fault with aborted ircomm FIR connection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first of all, no proprietary modules have ever been loaded. The "Tainted"
refers to "SUSE unsupported" modules. Machine is a Samsung P35 laptop (x86).
Kernel is 2.6.16.21 with SUSE patches (which don't touch IRDA afaics).
FIR chipset is served by nsc-ircc dongle_id=0x08.

The crash happened when I used gammu to connect to my nokia mobile phone
over /dev/ircomm0. I moved the phone out of the IR beam by accident and
then killed gammu with Ctrl-C while it still had the connection open.
At that moment, the kernel spewed a general protection fault on me.

general protection fault: 0000 [#1]
last sysfs file: /class/net/irda0/ifindex
Modules linked in: bluetooth af_packet nsc_ircc xt_pkttype ipt_LOG xt_limit
cpufreq_ondemand cpufreq_userspace cpufreq_powersave speedstep_centrino freq_table
ircomm_tty ircomm irda snd_pcm_oss crc_ccitt snd_mixer_oss snd_seq snd_seq_device
edd asus_acpi button battery ac ip6t_REJECT xt_tcpudp ipt_REJECT xt_state
iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack
nfnetlink ip_tables ip6table_filter ip6_tables x_tables ipv6 apparmor aamatch_pcre
nls_utf8 ntfs loop dm_mod ipw2200 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm
snd_timer snd soundcore snd_page_alloc pcmcia ieee80211 ieee80211_crypt ide_cd
cdrom firmware_class intel_agp agpgart i8xx_tco shpchp ehci_hcd uhci_hcd
pci_hotplug usbcore yenta_socket rsrc_nonstatic pcmcia_core ohci1394 ieee1394
8139too mii parport_pc lp parport reiserfs fan thermal processor piix radeonfb
i2c_algo_bit i2c_core ide_disk ide_core
CPU:    0
EIP:    0060:[<d530722f>]    Tainted: G     U VLI
EFLAGS: 00010082   (2.6.16.21-0.13-default #1)
EIP is at 0xd530722f
eax: ccf59e40   ebx: ccf59e40   ecx: 00000000   edx: 00000001
esi: cab86240   edi: 00000000   ebp: ccf59e18   esp: ccf59df8
ds: 007b   es: 007b   ss: 0068
Process gammu (pid: 4100, threadinfo=ccf58000 task=ddd8fab0)
Stack: <0>c01140c7 00000000 00000001 d5307218 d5307200 00000246 d5307200 cbac4414
       ccf59e2c c01140f7 00000000 00000000 ccb2d400 d5307224 c0221081 00000000
       e1f1b313 e1f2a500 d5307200 c021ea58 d5307224 cab86240 c021f1d8 00000008
Call Trace:
 [<c01140c7>] __wake_up_common+0x2e/0x4d
 [<c01140f7>] __wake_up+0x11/0x1a
 [<c0221081>] sock_def_wakeup+0x19/0x1b
 [<e1f1b313>] irda_release+0x2f/0x109 [irda]
 [<c021ea58>] sock_release+0x11/0x63
 [<c021f1d8>] sock_close+0x26/0x2a
 [<c014b9f9>] __fput+0x9e/0x14c
 [<c0149492>] filp_close+0x4e/0x54
 [<c0118b00>] put_files_struct+0x63/0xa5
 [<c0119883>] do_exit+0x197/0x617
 [<c0119d55>] sys_exit_group+0x0/0xd
 [<c01201f5>] get_signal_to_deliver+0x34b/0x35b
 [<c010220f>] do_notify_resume+0x89/0x5a0
 [<c01259bc>] autoremove_wake_function+0x0/0x2d
 [<c014b362>] vfs_read+0xb9/0x14d
 [<c014b6bd>] sys_read+0x3c/0x63
 [<c0102a8e>] work_notifysig+0x13/0x25
Code: 00 00 00 00 80 e1 f1 e1 00 00 00 00 40 62 b8 ca 00 d4 b2 cc 4c 9e f5 cc 4c 9e f5 cc 01 00 00 00 00 00 00 00 00 00 00 00 84 7e b8 <ca> ac 60 d0 df 34 75 30 d5 6c a2 4d
c1 50 44 ac cb 50 44 ac cb
 <1>Fixing recursive fault but reboot is needed!

If you need any further info to debug this, please tell me.

Regards,
Carl-Daniel
