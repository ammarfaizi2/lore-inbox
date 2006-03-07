Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWCGA5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWCGA5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCGA5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:57:47 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:11701 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932291AbWCGA5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:57:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=USWF2jjB3ON9tDRkTsemxsGi/OooowsjaQQAwDBGAjes3IV176sZnzWDoWeB8HqhriFi2GUVgSpq46Fr+fzoPmanQTyOdpg42k5gQEYpAlvfHmEnqRbhqm/US7deJN8SGcq3ppyaI1f23ebnUwtMkylvzBxn8qTLv9CKNkDZ22k=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.16-rc5][ALSA] ISA SB-AWE32 oops on sound init
Date: Mon, 6 Mar 2006 19:57:39 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603061957.39339.shawn.starr@rogers.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally taken the plunge (so to speak) and finally switched an old box 
away from OSS, however, ALSA doesn't seem to work well with it ;-)

Whoever wants to depreciate OSS, please wait :)

Model below:

[17179579.964000] ALSA device list:
[17179579.964000]   #0: Sound Blaster 16 at 0x220, irq 10, dma 1&5

Hope this stack dump is useful, 

Shawn.


[17180154.576000]  <1>Unable to handle kernel paging request at virtual 
address e48606a0
[17180203.620000]  printing eip:
[17180203.620000] e481e75a
[17180203.620000] *pde = 23f8c067
[17180203.620000] *pte = 00000000
[17180203.620000] Oops: 0000 [#2]
[17180203.620000] DEBUG_PAGEALLOC
[17180203.620000] Modules linked in: snd_pcm_oss snd_mixer_oss lm80 ipt_recent 
xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter ip_tables x_tables 
snd_opl3_lib snd_sb16_dsp snd_sb16_csp snd_sb_common snd_hwdep 
snd_mpu401_uart snd_rawmidi snd_seq_device snd_pcm snd_timer snd 
snd_page_alloc i2c_piix4
[17180203.620000] CPU:    0
[17180203.620000] EIP:    0060:[<e481e75a>]    Not tainted VLI
[17180203.620000] EFLAGS: 00010286   (2.6.16-rc5 #2)
[17180203.620000] EIP is at snd_ctl_open+0x5a/0x168 [snd]
[17180203.620000] eax: e48606a0   ebx: e48269c0   ecx: 0000002c   edx: 
daefeac0
[17180203.620000] esi: e1e76bf8   edi: 00000000   ebp: e18ecf58   esp: 
dcbc2ecc
[17180203.620000] ds: 007b   es: 007b   ss: 0068
[17180203.620000] Process xmms (pid: 2742, threadinfo=dcbc2000 task=daefeac0)
[17180203.620000] Stack: <0>ffffffd8 c012617a e48269c0 e18ecf58 00000000 
e215fe3c e481a215 c01c643f
[17180203.620000]        e352f11c 00000000 e215fe3c e18ecf58 c015e6f2 dcbc2f4c 
e18ecf58 e215fe3c
[17180203.620000]        dcbc2f4c c015e670 c01541b2 e3fcdb68 e280ff6c e18ecf58 
00000000 dcbc2f4c
[17180203.620000] Call Trace:
[17180203.620000]  [<c012617a>] in_group_p+0x3a/0x80
[17180203.620000]  [<e481a215>] snd_open+0x75/0x1a0 [snd]
[17180203.620000]  [<c01c643f>] kobject_get+0xf/0x20
[17180203.620000]  [<c015e6f2>] chrdev_open+0x82/0x180
[17180203.620000]  [<c015e670>] chrdev_open+0x0/0x180
[17180203.620000]  [<c01541b2>] __dentry_open+0xb2/0x1e0
[17180203.620000]  [<c0154395>] nameidata_to_filp+0x35/0x40
[17180203.620000]  [<c01543eb>] do_filp_open+0x4b/0x60
[17180203.620000]  [<c01540e4>] get_unused_fd+0xb4/0xd0
[17180203.620000]  [<c015444a>] do_sys_open+0x4a/0xe0
[17180203.620000]  [<c0102a8b>] sysenter_past_esp+0x54/0x75
[17180203.620000] Code: 89 d8 8b 74 24 0c 8b 5c 24 08 8b 7c 24 10 8b 6c 24 14 
83 c4 18 c3 89 ea e8 34 c0 ff ff 85 c0 78 da 8b 86 34 01 00 00 85 c0 74 14 
<83> 38 02 bb f2 ff ff ff 0f 84 e0 00 00 00 ff 80 e0 00 00 00 ba
[17180203.620000]
