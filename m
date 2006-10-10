Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWJJPsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWJJPsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJJPr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:47:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53424 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932160AbWJJPr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:47:59 -0400
Subject: BUG in filp_close() (was: Re: 2.6.19-rc1-mm1)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Vadim Lobanov <vlobanov@speakeasy.net>
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 10:47:49 -0500
Message-Id: <1160495269.9864.18.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 00:09 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/

I'm seeing an exception in filp_close(), called from sys_dup2().  I have
only seen it when I try to start up a java application (Lotus
Workplace).

I suspect that it may be related to the fdtable work, but I haven't
investigated it too closely.

> +fdtable-delete-pointless-code-in-dup_fd.patch
> +fdtable-make-fdarray-and-fdsets-equal-in-size.patch
> +fdtable-remove-the-free_files-field.patch
> +fdtable-implement-new-pagesize-based-fdtable-allocator.patch
> 
>  Redo the fdtable code.

BUG: unable to handle kernel paging request at virtual address 3237304a
 printing eip:
c015636f
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
last sysfs file: /block/hda/hda5/stat
Modules linked in: irda crc_ccitt tun airo e1000 pcmcia yenta_socket rsrc_nonstatic pcmcia_core radeon rtc ntfs jfs
CPU:    0
EIP:    0060:[<c015636f>]    Not tainted VLI
EFLAGS: 00010206   (2.6.19-rc1-mm1 #1)
EIP is at filp_close+0xc/0x5e
eax: 00000000   ebx: 32373036   ecx: cbc66000   edx: 00000000
esi: 00000001   edi: dff0cc80   ebp: cbc67f8c   esp: cbc67f80
ds: 007b   es: 007b   ss: 0068
Process java (pid: 12945, ti=cbc66000 task=ce9d6b00 task.ti=cbc66000)
Stack: 0000020c 00000001 cef765c0 cbc67fb4 c01623ed 32373036 dff0cc80 dff0cca4 
       32373036 dff0cc80 00000007 00000000 fffffff4 cbc66000 c0102e05 00000007 
       0000020c 00000000 00000000 fffffff4 bf966c14 0000003f 0000007b c03b007b 
Call Trace:
 [<c01623ed>] sys_dup2+0xdb/0x10f
 [<c0102e05>] sysenter_past_esp+0x56/0x79
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x79
Leftover inexact backtrace:
 =======================
Code: 26 00 8b 43 04 8b 40 0c 0f b3 30 3b 73 4c 73 03 89 73 4c 89 f8 e8 c0 51 26 00 5b 5e 5f 5d c3 55 89 e5 57 8b 7d 0c 56 53 8b 5d 08 <8b> 43 14 85 c0 75 0f 68 a1 e8 3f c0 31 f6 e8 54 35 fc ff 59 eb 
EIP: [<c015636f>] filp_close+0xc/0x5e SS:ESP 0068:cbc67f80
 <1>BUG: unable to handle kernel paging request at virtual address 02404e7c
 printing eip:
c015636f
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
last sysfs file: /block/hda/hda5/stat
Modules linked in: irda crc_ccitt tun airo e1000 pcmcia yenta_socket rsrc_nonstatic pcmcia_core radeon rtc ntfs jfs
CPU:    0
EIP:    0060:[<c015636f>]    Not tainted VLI
EFLAGS: 00010202   (2.6.19-rc1-mm1 #1)
EIP is at filp_close+0xc/0x5e
eax: 00000000   ebx: 02404e68   ecx: cc636000   edx: 00000000
esi: 00000001   edi: dfcfecc0   ebp: cc637f8c   esp: cc637f80
ds: 007b   es: 007b   ss: 0068
Process java (pid: 13593, ti=cc636000 task=ce97f550 task.ti=cc636000)
Stack: 0000020c 00000001 cbc56b80 cc637fb4 c01623ed 02404e68 dfcfecc0 dfcfece4 
       02404e68 dfcfecc0 00000007 00000000 fffffff4 cc636000 c0102e05 00000007 
       0000020c 00000000 00000000 fffffff4 bfc5f704 0000003f 0000007b c03b007b 
Call Trace:
 [<c01623ed>] sys_dup2+0xdb/0x10f
 [<c0102e05>] sysenter_past_esp+0x56/0x79
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x79
Leftover inexact backtrace:
 =======================
Code: 26 00 8b 43 04 8b 40 0c 0f b3 30 3b 73 4c 73 03 89 73 4c 89 f8 e8 c0 51 26 00 5b 5e 5f 5d c3 55 89 e5 57 8b 7d 0c 56 53 8b 5d 08 <8b> 43 14 85 c0 75 0f 68 a1 e8 3f c0 31 f6 e8 54 35 fc ff 59 eb 
EIP: [<c015636f>] filp_close+0xc/0x5e SS:ESP 0068:cc637f80
 <1>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000127
 printing eip:
c01874ca
*pde = 00000000
Oops: 0000 [#3]
PREEMPT 
last sysfs file: /block/hda/hda5/stat
Modules linked in: irda crc_ccitt tun airo e1000 pcmcia yenta_socket rsrc_nonstatic pcmcia_core radeon rtc ntfs jfs
CPU:    0
EIP:    0060:[<c01874ca>]    Not tainted VLI
EFLAGS: 00210246   (2.6.19-rc1-mm1 #1)
EIP is at dnotify_flush+0xf/0x73
eax: c8892c4b   ebx: b7f96e4a   ecx: cab2c000   edx: b7f96e4a
esi: 000000ff   edi: c148a280   ebp: cab2df70   esp: cab2df64
ds: 007b   es: 007b   ss: 0068
Process java (pid: 13942, ti=cab2c000 task=d572d4d0 task.ti=cab2c000)
Stack: b7f96e4a 00000000 c148a280 cab2df8c c01563a6 b7f96e4a c148a280 0000020c 
       00000001 cef5dec0 cab2dfb4 c01623ed b7f96e4a c148a280 c148a2a4 b7f96e4a 
       c148a280 00000007 00000000 fffffff4 cab2c000 c0102e05 00000007 0000020c 
Call Trace:
 [<c01563a6>] filp_close+0x43/0x5e
 [<c01623ed>] sys_dup2+0xdb/0x10f
 [<c0102e05>] sysenter_past_esp+0x56/0x79
DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x79
Leftover inexact backtrace:
 =======================
Code: ff ff 53 e8 d3 00 fe ff 83 c4 0c eb 07 89 f0 e8 6b 40 23 00 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 8b 55 08 57 56 53 8b 42 08 8b 70 30 <0f> b7 46 28 25 00 f0 00 00 3d 00 40 00 00 75 4c 8d 7e 70 89 f8 
EIP: [<c01874ca>] dnotify_flush+0xf/0x73 SS:ESP 0068:cab2df64
 

-- 
David Kleikamp
IBM Linux Technology Center

