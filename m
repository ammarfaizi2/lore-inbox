Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUK0LHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUK0LHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 06:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUK0LHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 06:07:23 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:25216 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261187AbUK0LHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 06:07:05 -0500
Subject: Re: 2.6.10-rc2-mm3, reiser4 and subversion
From: Vladimir Saveliev <vs@namesys.com>
To: Florian Engelhardt <flo@dotbox.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041126223337.44e2366a@discovery.hal.lan>
References: <20041126223337.44e2366a@discovery.hal.lan>
Content-Type: multipart/mixed; boundary="=-peEq8Vkj7NFEPsOgm56E"
Message-Id: <1101553607.2229.23.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 27 Nov 2004 14:06:55 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-peEq8Vkj7NFEPsOgm56E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Sat, 2004-11-27 at 00:33, Florian Engelhardt wrote:
> Hello,
> 
> i had some serious trouble with stability in the last time. Sometimes my
> box freezes and was not leaving any log messages in /var/log but
> yesterday, when i was trying to commit a few changes to my local
> repository, i got some strange error messages from subversion, followed
> by a complete freezed computer :(
> After i was rebooting, i found this error message in /var/log/kern.log
> 
> ------------[ cut here ]------------
> kernel BUG at fs/reiser4/plugin/file/tail_conversion.c:58!

Please try with this patch

> invalid operand: 0000 [#1]
> PREEMPT 
> Modules linked in: lirc_serial lirc_dev
> CPU:    0
> EIP:    0060:[<c0212918>]    Tainted: P      VLI
> EFLAGS: 00010282   (2.6.10-rc2-mm3) 
> EIP is at get_nonexclusive_access+0x28/0x40
> eax: f56f5f24   ebx: f5346330   ecx: f716bc40   edx: f53462d8
> esi: f5346300   edi: f53462d8   ebp: f6d0fcd4   esp: f56f5c70
> ds: 007b   es: 007b   ss: 0068
> Process svnadmin (pid: 10782, threadinfo=f56f4000 task=f707c040)
> Stack: c02114d7 f53462d8 f783f800 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 Call Trace:
> [<c02114d7>] unix_file_filemap_nopage+0x67/0xd0
> [<c0145386>] do_no_page+0xc6/0x390
> [<c0145940>] handle_mm_fault+0x1c0/0x200
> [<c0143c17>] follow_page+0x27/0x30
> [<c0143dbe>] get_user_pages+0x15e/0x3d0
> [<c021099a>] reiser4_get_user_pages+0x9a/0xd0
> [<c0210f96>] read_unix_file+0x266/0x2f0
> [<c01c92a5>] init_context+0x75/0xc0
> [<c01e20df>] reiser4_read+0x8f/0xf0
> [<c0160581>] sys_fstat64+0x31/0x40
> [<c015584a>] vfs_read+0x13a/0x180
> [<c0155c84>] sys_pread64+0x64/0x80
> [<c0103191>] sysenter_past_esp+0x52/0x71
> Code: 00 00 00 b8 00 e0 ff ff 8b 54 24 04 21 e0 8b 00 8b 80 b8 04 00 00
> 8b 40 3c 8b 48 08 85 c9 75 0b 89 d0 ff 00 0f 88 5a 12 00 00 c3 <0f> 0b
> 3a 00 1c ed 49 c0 eb eb 8d b4 26 00 00 00 00 8d bc 27 00 
> 
> >From now on, every time i try to do execute "svnadmin recover" (to
> recover the repository) or "svnadmin create", the system freezes. I am
> not able to start any new programms, nor can i save open files to the
> harddisk, but i am able to execute some simple commands like ls and i
> can edit opened files in vi. If i execute "svnadmin create" for the
> second time, the system totaly freezes and i am unable to anything, only
> hit the reboot button.
> 
> Executing "fsck.reiser4 --check /dev/sda2" (my root partition) just
> tells me that everything is fine.
> 
> Kind regards
> 
> Florian Engelhardt

--=-peEq8Vkj7NFEPsOgm56E
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

--=-peEq8Vkj7NFEPsOgm56E--

