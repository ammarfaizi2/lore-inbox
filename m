Return-Path: <linux-kernel-owner+w=401wt.eu-S1754308AbWL3KrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbWL3KrX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 05:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbWL3KrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 05:47:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:43121 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291AbWL3KrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 05:47:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KuQ9mmrMI7oYtaKKsDe7wWLBIzklTc8MLkcJ+YZFPQHCHFG4/kAZVIzaz9OR2MIzmkoMK51djf93YHE/Q/FQHkKLUQkKVlZIQwGbmCzHdPQAzkd8mt6S6j4t7fJju7tV3IKDs+ZsgC6doNLcbk872DwrBznCk90f9ogF5+owYU8=
Message-ID: <a44ae5cd0612300247n529f48a6t81edb503bc646f73@mail.gmail.com>
Date: Sat, 30 Dec 2006 02:47:20 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, yi.zhu@intel.com
Subject: 2.6.20-rc2-mm1 -- INFO: possible recursive locking detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Andrew, I am not sure which maintainer to contact about this.  I
CCed gregkh for sysfs and Yi for ipw2200.  Hopefully this is helpful.
BTW, I also found that none of my network drivers were recognized by
hal (lshal did not show their "net" entries) unless I set
CONFIG_SYSFS_DEPRECATED=y.  I am running Ubuntu development (Feisty
Fawn), so it seems like I ought to be running pretty current hal
utilities:   hal-device-manager       0.5.8.1-4ubuntu1.  After
reenabling CONFIG_SYSFS_DEPRECATED, I am able to use my IPW2200
driver, in spite of this recursive locking message, so this INFO
message may not indicate a problem.

[ INFO: possible recursive locking detected ]
2.6.20-rc2-mm1 #21
---------------------------------------------
modprobe/1779 is trying to acquire lock:
 (&sysfs_inode_imutex_key){--..}, at: [<c02db236>] mutex_lock+0x1c/0x1f

but task is already holding lock:
 (&sysfs_inode_imutex_key){--..}, at: [<c02db236>] mutex_lock+0x1c/0x1f

other info that might help us debug this:
3 locks held by modprobe/1779:
 #0:  (rtnl_mutex){--..}, at: [<c02db236>] mutex_lock+0x1c/0x1f
 #1:  (&priv->mutex){--..}, at: [<c02db236>] mutex_lock+0x1c/0x1f
 #2:  (&sysfs_inode_imutex_key){--..}, at: [<c02db236>] mutex_lock+0x1c/0x1f

stack backtrace:
 [<c0104eab>] show_trace_log_lvl+0x1a/0x2f
 [<c010558b>] show_trace+0x12/0x14
 [<c010563d>] dump_stack+0x16/0x18
 [<c0132147>] __lock_acquire+0x12e/0xb75
 [<c0132bf6>] lock_acquire+0x68/0x82
 [<c02db094>] __mutex_lock_slowpath+0xdc/0x262
 [<c02db236>] mutex_lock+0x1c/0x1f
 [<c019bca3>] sysfs_drop_dentry+0xb7/0x12b
 [<c019d331>] sysfs_remove_dir+0x6f/0x10b
 [<c01dcf9d>] kobject_del+0xb/0x15
 [<c0243701>] device_del+0x1b0/0x1c4
 [<c0243720>] device_unregister+0xb/0x15
 [<f90dc384>] _request_firmware+0x2e0/0x300 [firmware_class]
 [<f90dc43c>] request_firmware+0x12/0x14 [firmware_class]
 [<f9212d05>] ipw_load+0x5b/0x1690 [ipw2200]
 [<f92143ca>] ipw_up+0x90/0x7d7 [ipw2200]
 [<f921b6e1>] ipw_net_init+0x1f/0x3e [ipw2200]
 [<c028b612>] register_netdevice+0xa9/0x2e5
 [<c028c9b3>] register_netdev+0x40/0x4d
 [<f921da23>] ipw_pci_probe+0x78b/0x833 [ipw2200]
 [<c01f65c9>] pci_device_probe+0x39/0x5b
 [<c0245505>] driver_probe_device+0xaa/0x123
 [<c0245675>] __driver_attach+0x6a/0xa1
 [<c0244b0a>] bus_for_each_dev+0x36/0x5b
 [<c024538c>] driver_attach+0x19/0x1b
 [<c0244dfa>] bus_add_driver+0x6a/0x170
 [<c0245954>] driver_register+0x79/0x7e
 [<c01f671e>] __pci_register_driver+0x53/0x80
 [<f90d502e>] ipw_init+0x2e/0x73 [ipw2200]
 [<c0138cc9>] sys_init_module+0x131a/0x1469
 [<c0103ed6>] sysenter_past_esp+0x5f/0x99
PM: Adding info for No Bus:eth1
