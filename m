Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUI3Vvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUI3Vvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUI3Vvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:51:40 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54712 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269530AbUI3VvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:51:21 -0400
Message-ID: <415C7FDA.5070709@namesys.com>
Date: Thu, 30 Sep 2004 14:51:22 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Oomen <erik.oomen@home.nl>
CC: linux-kernel@vger.kernel.org, vs <vs@thebsh.namesys.com>
Subject: Re: 2.6.9rc2-mm1 (reiser4 related?) oops
References: <Pine.LNX.4.58.0409302236360.2783@paris>
In-Reply-To: <Pine.LNX.4.58.0409302236360.2783@paris>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the future, please cc reiserfs-dev with such things.

vs will handle this.

Hans

Erik Oomen wrote:

>This oops happened when I started mencoder for recording television
>broadcast to a reiser4 partition.
>
>/dev/hda1 is the reiser4 partition, /dev/hda3 is reiser3
>
>root@paris:~$ df -h
>Filesystem            Size  Used Avail Use% Mounted on
>/dev/hda3              28G   18G  9.6G  65% /
>/dev/hda1             9.3G   29M  9.3G   1% /var/movies
>tmpfs                  94M     0   94M   0% /dev/shm
>
>System is an PIII-650 with 192Mb memory
>
>Unable to handle kernel paging request at virtual address 140007d8
> printing eip:
>c01ec130
>*pde = 00000000
>Oops: 0000 [#1]
>PREEMPT
>Modules linked in: snd_es1938 snd_opl3_lib snd_hwdep snd_mpu401_uart tuner
>msp3400 bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc
>videodev ohci_hcd usbcore sis_agp agpgart 8250_pnp sd_mod sg sr_mod
>scsi_mod autofs4 snd_bt87x snd_ens1371 snd_rawmidi snd_seq_device
>snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
>snd soundcore 8250 serial_core lm78 i2c_sensor i2c_isa i2c_core rtc
>CPU:    0
>EIP:    0060:[<c01ec130>]    Not tainted VLI
>EFLAGS: 00010292   (2.6.9-rc2-mm1)
>EIP is at pre_commit_hook_bitmap+0x60/0x1b0
>eax: 14000808   ebx: cc902000   ecx: c2724e40   edx: cb06b500
>esi: 00000da8   edi: cac51000   ebp: 140007d8   esp: cb3a1dec
>ds: 007b   es: 007b   ss: 0068
>Process ktxnmgrd:hda1:t (pid: 960, threadinfo=cb3a0000 task=cb798550)
>Stack: 00000da8 00000003 01100100 00000da8 c2724eb0 c2724e40 c11d4400 00000000
>       00000000 00000000 00000000 000012a1 cb3a0000 cb06c800 cb3a0000 c11d4400
>       c01b52c5 c01bd17c c01c1cd9 c836546c c836546c cb3a0000 cb3a1ed8 c8365460
>Call Trace:
> [<c01b52c5>] pre_commit_hook+0x5/0x10
> [<c01bd17c>] reiser4_write_logs+0x2c/0x2b0
> [<c01c1cd9>] release_prepped_list+0x109/0x140
> [<c01c1cd9>] release_prepped_list+0x109/0x140
> [<c01c18a8>] finish_fq+0x38/0x40
> [<c01c190e>] finish_all_fq+0x5e/0xa0
> [<c01b5e4a>] commit_current_atom+0x11a/0x200
> [<c01b6772>] try_commit_txnh+0x122/0x1a0
> [<c01b6827>] commit_txnh+0x37/0xb0
> [<c01b563e>] txn_end+0x2e/0x40
> [<c01b5658>] txn_restart+0x8/0x20
> [<c01b61f1>] commit_some_atoms+0xc1/0x140
> [<c01c232a>] scan_mgr+0x2a/0x50
> [<c026ba2f>] snprintf+0x1f/0x30
> [<c01c2234>] ktxnmgrd+0x174/0x200
> [<c01c20c0>] ktxnmgrd+0x0/0x200
> [<c010229d>] kernel_thread_helper+0x5/0x18
>Code: 8b 43 08 a8 08 0f 85 59 01 00 00 8b 44 24 14 8b 54 24 14 83 c0 70 89
>44 24 10 8b 42 70 39 44 24 10 8d 68 d0 74 1c 90 8d 74 26 00 <8b> 45 00 a8
>40 0f 85 95 00 00 00 8b 45 30 39 44 24 10 8d 68 d0
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

