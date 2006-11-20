Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWKTXSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWKTXSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966877AbWKTXSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:18:12 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:26382 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S965823AbWKTXSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:18:11 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.19-rc6-rt5
Date: Mon, 20 Nov 2006 23:18:11 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061120220230.GA30835@elte.hu>
In-Reply-To: <20061120220230.GA30835@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202318.11142.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 22:02, Ingo Molnar wrote:
> i've released the 2.6.19-rc6-rt5 tree, which can be downloaded from the
> usual place:

Couple of problems:

[  320.142298] ehci_hcd: Unknown symbol usb_hcd_pci_suspend
[  320.142837] ehci_hcd: Unknown symbol usb_free_urb
[  320.142901] ehci_hcd: Unknown symbol usb_hub_tt_clear_buffer
[  320.142954] ehci_hcd: Unknown symbol usb_hcd_resume_root_hub
[  320.143006] ehci_hcd: Unknown symbol usb_hcd_pci_probe
[  320.143144] ehci_hcd: Unknown symbol usb_calc_bus_time
[  320.143201] ehci_hcd: Unknown symbol usb_hcd_pci_shutdown
[  320.143255] ehci_hcd: Unknown symbol usb_hcd_pci_resume
[  320.143365] ehci_hcd: Unknown symbol usb_get_urb
[  320.143417] ehci_hcd: Unknown symbol usb_hcd_giveback_urb
[  320.143478] ehci_hcd: Unknown symbol usb_hcd_pci_remove
[  320.143544] ehci_hcd: Unknown symbol usb_root_hub_lost_power

Not sure why. Don't notice it on 2.6.19-rc6. Means my distro's udev script
takes eons to complete, but I can get to init 3.

Got this when I mounted my /home partition:

[  375.927366] XFS mounting filesystem md2
[  376.724666] Ending clean XFS mount for filesystem: md2
[  441.121031] stopped custom tracer.
[  441.121067]
[  441.121068] =============================================
[  441.121131] [ INFO: possible recursive locking detected ]
[  441.121165] 2.6.19-rc6-rt5 #3
[  441.121197] ---------------------------------------------
[  441.121231] as/1018 is trying to acquire lock:
[  441.121264]  ((struct compat_rw_semaphore *)(&(&ip->i_lock)->mr_lock)){----}, at: [<ffffffff80332b27>] xfs_ilock+0x67/0xa0
[  441.121397]
[  441.121398] but task is already holding lock:
[  441.121459]  ((struct compat_rw_semaphore *)(&(&ip->i_lock)->mr_lock)){----}, at: [<ffffffff80332b27>] xfs_ilock+0x67/0xa0
[  441.121589]
[  441.121590] other info that might help us debug this:
[  441.121652] 2 locks held by as/1018:
[  441.121684]  #0:  (&inode->i_mutex){--..}, at: [<ffffffff8021c380>] open_namei+0x100/0x6c0
[  441.121833]  #1:  ((struct compat_rw_semaphore *)(&(&ip->i_lock)->mr_lock)){----}, at: [<ffffffff80332b27>] xfs_ilock+0x67
/0xa0
[  441.121984]
[  441.121985] stack backtrace:
[  441.122044]
[  441.122045] Call Trace:
[  441.122108]  [<ffffffff80271eb3>] dump_trace+0xc3/0x4a0
[  441.122145]  [<ffffffff802722d3>] show_trace+0x43/0x70
[  441.122180]  [<ffffffff80272315>] dump_stack+0x15/0x20
[  441.122217]  [<ffffffff802adaa1>] __lock_acquire+0x991/0xce0
[  441.122254]  [<ffffffff802ade78>] lock_acquire+0x88/0xc0
[  441.122289]  [<ffffffff802a8989>] compat_down_write+0x39/0x50
[  441.122325]  [<ffffffff80332b27>] xfs_ilock+0x67/0xa0
[  441.122361]  [<ffffffff80333794>] xfs_iget+0x384/0x880
[  441.122397]  [<ffffffff8034b4c4>] xfs_trans_iget+0xc4/0x150
[  441.122433]  [<ffffffff80337d2e>] xfs_ialloc+0x9e/0x4d0
[  441.122469]  [<ffffffff8034c09f>] xfs_dir_ialloc+0x7f/0x2d0
[  441.122505]  [<ffffffff80352a94>] xfs_create+0x354/0x6c0
[  441.122541]  [<ffffffff8035c73a>] xfs_vn_mknod+0x15a/0x2f0
[  441.122577]  [<ffffffff8035c8eb>] xfs_vn_create+0xb/0x10
[  441.122613]  [<ffffffff8023d000>] vfs_create+0x90/0xf0
[  441.122649]  [<ffffffff8021c455>] open_namei+0x1d5/0x6c0
[  441.122685]  [<ffffffff80229818>] do_filp_open+0x28/0x50
[  441.122721]  [<ffffffff8021af0a>] do_sys_open+0x5a/0xf0
[  441.122757]  [<ffffffff80233d3b>] sys_open+0x1b/0x20
[  441.122793]  [<ffffffff80265d5e>] system_call+0x7e/0x83
[  441.122831]  [<000000337b1ac630>]
[  441.122863]
[  441.122893] 2 locks held by as/1018:
[  441.122925]  #0:  (&inode->i_mutex){--..}, at: [<ffffffff8021c380>] open_namei+0x100/0x6c0
[  441.123073]  #1:  ((struct compat_rw_semaphore *)(&(&ip->i_lock)->mr_lock)){----}, at: [<ffffffff80332b27>] xfs_ilock+0x67/0xa0
[  441.123224] ---------------------------
[  441.123256] | preempt count: 00000000 ]
[  441.123288] | 0-level deep critical section nesting:
[  441.123322] ----------------------------------------

Also, I assume latency tracing still isn't working on x86_64? I don't
get a /proc/sys/kernel/preempt_max_latency file, but I have
the right option enabled.

Find my config and the entire dmesg log here:

http://devzero.co.uk/~alistair/2.6.19-rc6-rt5/

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
