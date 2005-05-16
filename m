Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVEPUCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVEPUCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVEPUCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:02:49 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:7839 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261810AbVEPUCS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:02:18 -0400
Message-ID: <4288FC4F.9040607@tiscali.de>
Date: Mon, 16 May 2005 22:02:23 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RTL8139 | Strange OOPS & No Forwarding
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to access /proc/sys/net/ipv4/conf/eth0/forwarding this hapens:
[root@iceowl ~]# cat /proc/sys/net/ipv4/conf/eth0/forwarding
Segmentation fault
[root@iceowl ~]# dmesg
[...]
Unable to handle kernel paging request at virtual address 57d61c98
  printing eip:
c0477c54
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: ipt_state iptable_filter ip_tables ohci_hcd ehci_hcd snd_cs4231_lib snd_mpu401 analog ns558
parport_pc parport pcspkr eth1394 snd_cmipci gameport snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device
ohci1394 ieee1394 nvidia i2c_i801 i2c_core usbhid uhci_hcd pci_hotplug tsdev evdev cpufreq_powersave p4_clockmod
speedstep_lib freq_table ip_conntrack_ftp ip_conntrack snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd
soundcore ndiswrapper 8139too mii usbserial usbcore rtc
CPU:    0
EIP:    0060:[<c0477c54>]    Tainted: P      VLI
EFLAGS: 00210296   (2.6.12-rc4-mm2-ott)
EIP is at devinet_sysctl_forward+0x12/0x77
eax: 08066e30   ebx: 00000000   ecx: c0477c42   edx: d646b804
esi: 57d61c98   edi: 00000000   ebp: 00000004   esp: ce543efc
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 4665, threadinfo=ce542000 task=c874fa30)
Stack: 08067234 00000001 00000006 ce543fbc c874fa30 08067234 c9034180 d646b804
        00000000 00000004 c012604d d646b804 00000000 c9034180 08066e30 ce543f40
        ce543fa4 00000400 c9034180 00000400 ce543fa4 00000000 c01260ab 00000000
Call Trace:
  [<c012604d>] do_rw_proc+0x9e/0xaf
  [<c01260ab>] proc_readsys+0x2f/0x33
  [<c015eb0b>] vfs_read+0xb9/0x193
  [<c015eec5>] sys_read+0x4b/0x74
  [<c0102eab>] sysenter_past_esp+0x54/0x75
Code: 24 00 00 00 00 e8 55 16 fd ff 83 c4 04 5b 5e 5f c3 e8 36 c2 05 00 90 eb d4 55 57 56 53 83 ec 18 8b 54 24 2c 8b 5c
24 30 8b 72 08 <8b> 2e 8b 44 24 40 89 44 24 14 8b 44 24 3c 89 44 24 10 8b 44 24

It seems there's something wrong because not only the proc interface is brocken - ip_forwarding has on only an effect on
my secound networks card (wlan0).

Matthias-Christian Ott

