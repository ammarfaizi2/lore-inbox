Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUKIApC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUKIApC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUKIAov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:44:51 -0500
Received: from ns1.digitalpath.net ([65.164.104.5]:57288 "HELO
	mail.digitalpath.net") by vger.kernel.org with SMTP id S261344AbUKIAoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:44:21 -0500
Date: Mon, 8 Nov 2004 16:43:03 -0800
From: Ray Van Dolson <rayvd@digitalpath.net>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/prio_tree.c:377
Message-ID: <20041109004303.GA10048@digitalpath.net>
References: <Pine.GSO.4.58.0411032015500.9079@lazuli.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0411032015500.9079@lazuli.engin.umich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh, I applied your patch and it definitely seems to have halped.  The
server lasted nearly three days. :-)  In fact, it didn't really seem to
hard lock but I had to reset it to get things working after the latest
crash.

Details:


 kernel BUG at kernel/exit.c:842!
 invalid operand: 0000 [#1]
 SMP 
 Modules linked in: sch_tbf(U) ppp_async(U) crc_ccitt(U) ppp_mppe(U) ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_multiport(U) iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U) e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U) button(U) battery(U) ac(U) ext3(U) jbd(U)
 CPU:    2
 EIP:    0060:[<02121d10>]    Tainted: P   VLI
 EFLAGS: 00010246   (2.6.9-1.1_FC2custom) 
 EIP is at do_exit+0x3b3/0x3bd
 eax: 00000000   ebx: 26506560   ecx: 26506000   edx: 0381dd60
 esi: 41fec340   edi: 26506030   ebp: 00001000   esp: 23b82f98
 ds: 007b   es: 007b   ss: 0068
 Process pppd (pid: 27091, threadinfo=23b82000 task=26506030)
 Stack: 0d611e00 00001000 23b82000 23b82000 02121e05 00001000 23b82fc4 00000010 
        f6f32684 23b82000 fffec200 00000010 00000000 00000000 00000010 f6f32684 
        fef87938 000000fc 0000007b 0000007b 000000fc f6fa37a2 00000073 00000246 
 Call Trace:
  [<02121e05>] sys_exit_group+0x0/0xd
 Code: c1 e0 07 8d 04 10 ff 88 00 01 00 00 83 3a 02 75 0b 8b 82 08 11 00 00 e8 d8 95 ff ff 89 6f 7c 89 f8 e8 88 f5 ff ff e8 bc 74 19 00 <0f> 0b 4a 03 96 09 2d 02 eb fe 53 85 c0 89 d3 74 05 e8 35 ab ff 
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000024
  printing eip:
 0211ddb0
 *pde = 00004001
 Oops: 0000 [#2]
 SMP 
 Modules linked in: sch_tbf(U) ppp_async(U) crc_ccitt(U) ppp_mppe(U) ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_multiport(U) iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U) e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U) button(U) battery(U) ac(U) ext3(U) jbd(U)
 CPU:    2
 EIP:    0060:[<0211ddb0>]    Tainted: P   VLI
 EFLAGS: 00010286   (2.6.9-1.1_FC2custom) 
 EIP is at mm_release+0x33/0x70
 eax: 00000000   ebx: 26506030   ecx: 00000000   edx: 00000000
 esi: f6ff6828   edi: 00000000   ebp: 0000000b   esp: 23b82e50
 ds: 007b   es: 007b   ss: 0068
 Process pppd (pid: 27091, threadinfo=23b82000 task=26506030)
 Stack: 00000000 00000000 23b82f64 26506030 02121a20 23b82000 23b82f64 00000000 
        022c9112 021064a2 0000000b 23b82f64 022c9112 00000000 000000ff 0000000b 
        00000000 02106784 00001000 23b82f64 00000000 02106784 00001000 02106850 
 Call Trace:
  [<02121a20>] do_exit+0xc3/0x3bd
  [<021064a2>] do_divide_error+0x0/0xea
  [<02106784>] do_invalid_op+0x0/0xd5
  [<02106784>] do_invalid_op+0x0/0xd5
  [<02106850>] do_invalid_op+0xcc/0xd5
  [<0211bff5>] load_balance+0x27/0x135
  [<02121d10>] do_exit+0x3b3/0x3bd
  [<022b9a4a>] schedule+0x87e/0x8aa
  [<0217e45d>] proc_delete_inode+0x0/0x61
  [<022b9a4a>] schedule+0x87e/0x8aa
  [<02121d10>] do_exit+0x3b3/0x3bd
  [<02121e05>] sys_exit_group+0x0/0xd
 Code: 8b 90 14 01 00 00 31 c0 8e e0 8e e8 85 d2 74 11 c7 83 14 01 00 00 00 00 00 00 89 d0 e8 b5 ea ff ff 8b b3 1c 01 00 00 85 f6 74 38 <8b> 47 24 48 7e 32 c7 83 1c 01 00 00 00 00 00 00 89 e2 89 f1 c7 
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000024
  printing eip:
 0211ddb0
 *pde = 00004001
 Oops: 0000 [#3]
 SMP 
 Modules linked in: sch_tbf(U) ppp_async(U) crc_ccitt(U) ppp_mppe(U) ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_multiport(U) iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U) e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U) button(U) battery(U) ac(U) ext3(U) jbd(U)
 CPU:    2
 EIP:    0060:[<0211ddb0>]    Tainted: P   VLI
 EFLAGS: 00010286   (2.6.9-1.1_FC2custom) 
 EIP is at mm_release+0x33/0x70
 eax: 00000000   ebx: 26506030   ecx: 00000000   edx: 00000000
 esi: f6ff6828   edi: 00000000   ebp: 0000000b   esp: 23b82cc8
 ds: 007b   es: 007b   ss: 0068

I started also noticing "Neighbour table overflow" error messages as well.
This server makes heavy use of proxy arp, so I wonder if I need to tweak
the gc_thresh* and the other gc* variables in proc...

The weird thing is that even after these "oopses" happened, the box was
still functioning.  I could access the web server running on it, it was
still passing traffic for existing tunnels, but I could not establish new
ones.  Couldn't ssh in, etc (thus I had to hard reset it).

As you can see, this is running on kernel 2.6.9 (from Fedora Core 2 testing
update tree) w/ your patch you mentioned below.

Any ideas?

On Wed, Nov 03, 2004 at 08:27:09PM -0500, Rajesh Venkatasubramanian wrote:
> Hi Ray,
>
> Can you please apply the patch I recently posted and report
> back.
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109926628920398
>
> The patch fixes a bug reported earlier. However, earlier
> oops were triggered at mm/prio_tree.c:538.
>
> I haven't looked at the trace carefully. I will do so                        .
> Please report back if the previous patch fixes your problem                  .
>
> Thanks,
> Rajesh
>
