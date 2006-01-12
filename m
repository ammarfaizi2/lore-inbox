Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWALJAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWALJAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWALJAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:00:44 -0500
Received: from relay01.pair.com ([209.68.5.15]:15624 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1030331AbWALJAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:00:44 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: linux-kernel@vger.kernel.org
Subject: Bad page state at free_hot_cold_page
Date: Thu, 12 Jan 2006 03:00:59 -0600
User-Agent: KMail/1.9
Organization: Clientec, Inc.
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120301.00361.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
	(I'm posting this to LKML and CK because I'm not sure if any of 2.6.15-ck1's 
changes might cause this scenario)
	Recently I've noticed that after my desktop has been up for a while, my music 
playback / mouse cursor movement will on occasion pause briefly. I got 
frustrated with it a minute ago and decided to kill artsd, wondering if there 
could be issues with both arts and amarok's backend holding the audio device 
open at once.
	When running killall artsd, I locked up for a second and found this in dmesg:

Bad page state at free_hot_cold_page (in process 'artsd', page b1761620)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761640)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761660)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761680)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b17616a0)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b17616c0)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b17616e0)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761700)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761720)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761740)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761760)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b1761780)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b17617a0)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b17617c0)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page b17617e0)
flags:0x80000404 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<b0148e9a>] bad_page+0x84/0xbc
 [<b0149699>] free_hot_cold_page+0x65/0x13a
 [<b0153bf1>] zap_pte_range+0x1d1/0x28f
 [<b0153d70>] unmap_page_range+0xc1/0x122
 [<b0153ebe>] unmap_vmas+0xed/0x242
 [<b0158099>] unmap_region+0xb4/0x156
 [<b01583e2>] do_munmap+0x108/0x144
 [<b015846f>] sys_munmap+0x51/0x76
 [<b0102eff>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed

Any thoughts? Further diagnostics?

Thanks,
Chase
