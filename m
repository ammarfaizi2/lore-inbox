Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbULBHFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbULBHFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbULBHFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:05:24 -0500
Received: from umail.mtu.ru ([195.34.32.101]:28295 "EHLO umail.ru")
	by vger.kernel.org with ESMTP id S261567AbULBHE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:04:57 -0500
Subject: Re: ReiserFS 4 BUG
From: Vladimir Saveliev <vs@namesys.com>
To: Ruben Fonseca <fonseka@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <79a6fb1e041201153328fed785@mail.gmail.com>
References: <79a6fb1e041201153328fed785@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-WpWbcSj9/8OD5Whd/Qpo"
Message-Id: <1101971070.2515.51.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 02 Dec 2004 10:04:31 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WpWbcSj9/8OD5Whd/Qpo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Thu, 2004-12-02 at 02:33, Ruben Fonseca wrote:
> happen with 2.6.10-rc2-mm2 and mm3 (and maybe latter, but didn't notive this)
> 
> when installing PHP or OpenOffice, the instalation break and kernel says:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:58!

Please try with the attached patch.

> invalid operand: 0000 [#1]
> PREEMPT 
> Modules linked in: ipw2100 ieee80211 ieee80211_crypt eth1394 ohci_hcd
> parport_pc parport ohci1394 ieee1394 ehci_hcd uhci_hcd joydev evdev
> snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq
> snd_seq_device nls_iso8859_1 ntfs snd_intel8x0 snd_ac97_codec snd_pcm
> snd_timer snd snd_page_alloc
> CPU:    0
> EIP:    0060:[<c022e438>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.10-rc2-mm3) 
> EIP is at get_nonexclusive_access+0x28/0x40
> eax: c390df1c   ebx: cc106d30   ecx: d67c2340   edx: cc106cd8
> esi: cc106d00   edi: cc106cd8   ebp: d673c5f4   esp: c390dc7c
> ds: 007b   es: 007b   ss: 0068
> Process setup.bin (pid: 15101, threadinfo=c390c000 task=d5fb3540)
> Stack: c022cff7 cc106cd8 d7076800 00000000 00000000 00000000 00000000 00000000 
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
>        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> Call Trace:
>  [<c022cff7>] unix_file_filemap_nopage+0x67/0xd0
>  [<c022cf90>] unix_file_filemap_nopage+0x0/0xd0
>  [<c014fc77>] do_no_page+0xd7/0x3a0
>  [<c0150241>] handle_mm_fault+0x1d1/0x210
>  [<c014e3e5>] follow_page+0x25/0x30
>  [<c014e59a>] get_user_pages+0x16a/0x3e0
>  [<c022c466>] reiser4_get_user_pages+0x96/0xc0
>  [<c022d570>] write_unix_file+0x300/0x450
>  [<c01e29f5>] init_context+0x75/0xc0
>  [<c01fcc2f>] reiser4_write+0x8f/0x100
>  [<c0160e5a>] vfs_write+0x13a/0x180
>  [<c0161f49>] fget_light+0x89/0xa0
>  [<c0160f71>] sys_write+0x51/0x80
>  [<c01032c1>] sysenter_past_esp+0x52/0x71
> Code: 00 00 00 b8 00 e0 ff ff 21 e0 8b 00 8b 54 24 04 8b 80 b8 04 00
> 00 8b 40 3c 8b 48 08 85 c9 75 0b 89 d0 ff 00 0f 88 8b 12 00 00 c3 <0f>
> 0b 3a 00 38 f7 41 c0 eb eb 8d b4 26 00 00 00 00 8d bc 27 00
> 
> after that the system becomes unusable.. have to reboot....
> 
> no data damaged, but can't install those applications :(
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--=-WpWbcSj9/8OD5Whd/Qpo
Content-Disposition: attachment; filename=1.1765
Content-Type: text/plain; name=1.1765; charset=koi8-r
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/23 14:07:34+03:00 vs@tribesman.namesys.com 
#   read_unix_file: missing calls to txn_restart() are added
# 
# plugin/file/file.c
#   2004/11/23 14:07:31+03:00 vs@tribesman.namesys.com +4 -1
#   read_unix_file: missing calls to txn_restart() are added
# 
diff -Nru a/plugin/file/file.c b/plugin/file/file.c
--- a/plugin/file/file.c	2004-11-23 14:45:34 +03:00
+++ b/plugin/file/file.c	2004-11-23 14:45:34 +03:00
@@ -1741,6 +1741,8 @@
 	while (left > 0) {
 		size_t to_read;		
 
+		txn_restart_current();
+
 		size = i_size_read(inode);
 		if (*off >= size)
 			/* position to read from is past the end of file */
@@ -1774,7 +1776,6 @@
 		if (user_space)
 			reiser4_put_user_pages(pages, nr_pages);
 		drop_nonexclusive_access(uf_info);
-		txn_restart_current();
 
 		if (read < 0) {
 			result = read;
@@ -1974,6 +1975,8 @@
 
 	drop_nonexclusive_access(unix_file_inode_data(inode));
 	up_read(&reiser4_inode_data(inode)->coc_sem);
+
+	txn_restart_current();
 
 	reiser4_exit_context(&ctx);
 	return page;

--=-WpWbcSj9/8OD5Whd/Qpo--

