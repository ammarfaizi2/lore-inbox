Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWDVWMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWDVWMg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWDVWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 18:12:36 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:2023 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1751163AbWDVWMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 18:12:35 -0400
Date: Sun, 23 Apr 2006 00:12:32 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.6.15.3 on amd64
Message-ID: <20060422221232.GA6269@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My dual-core AMD64 machine (Athlon 64 X2 3800+) has been unstable (hanging
completely from the to time) since I ever got it, with various kernels (2.6.8
up to 2.6.17-rc1), even more so after the I/O load increased on it (earlier
it hung about once a month; now it's more once a day). This time, however, I
had a minicom logging everything on the serial console, so I have a
traceback:

[117109.540473] Unable to handle kernel paging request at ffff8000027a7c68 RIP:                        
[117109.545881] <ffffffff8015abe8>{isolate_lru_pages+77}                        
[117109.554498] PGD 0                                   
[117109.556897] Oops: 0002 [1] SMP 
[117109.560610] CPU 0              
[117109.563007] Modules linked in: af_packet w83627hf hwmon_vid i2c_isa ide_disk ide_cd cdrom ipv6 joydev evdev i2c_nforce2 snd_ac97_bus analog psmouse floppy parport_pc parport i2c_core soundcore gameport pcspkr serio_raw rtc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod ide_generic sd_mod sata_nv libata scsi_mod ehci_hcd generic forcedeth amd74xx ide_core ohci_hcd thermal processor fan unix
[117109.605544] Pid: 192, comm: kswapd0 Not tainted 2.6.15.3 #1 
[117109.612045] RIP: 0010:[<ffffffff8015abe8>] <ffffffff8015abe8>{isolate_lru_pages+77}
[117109.620752] RSP: 0018:ffff81007e729c58  EFLAGS: 00010086                           
[117109.627149] RAX: ffff8000027a7c68 RBX: 0000000000000020 RCX: 0000000000000018
[117109.635469] RDX: ffff81000000c618 RSI: ffff81000000c618 RDI: ffff81007e729e04
[117109.643796] RBP: ffff81000000c380 R08: ffff810001761ce0 R09: ffff81007e729de8
[117109.652086] R10: 0000000000000018 R11: 0000000000000019 R12: 0000000000000000
[117109.660388] R13: 000000000000000c R14: ffff81007e729e78 R15: 0000000000000000
[117109.668722] FS:  0000000000000000(0000) GS:ffffffff803a8800(0000) knlGS:0000000055844e60
[117109.678123] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b                           
[117109.684840] CR2: ffff8000027a7c68 CR3: 000000001791d000 CR4: 00000000000006e0
[117109.693134] Process kswapd0 (pid: 192, threadinfo ffff81007e728000, task ffff81007e724f60)
[117109.702739] Stack: ffff81000000c380 ffffffff8015b288 ffff810025a08000 0000000000000010    
[117109.711844]        0000000000000000 0000000000000041 0000002000000000 0000000000000020 
[117109.721158]        0000000000000000 0000000000000001                                   
[117109.727087] Call Trace:<ffffffff8015b288>{shrink_zone+1474} <ffffffff801d7c3d>{find_next_bit+90}
[117109.737326]        <ffffffff8810406f>{:mbcache:mb_cache_shrink_fn+41} <ffffffff801d63ba>{__up_read+19}
[117109.748145]        <ffffffff8015aa42>{shrink_slab+314} <ffffffff8015bcd0>{balance_pgdat+535}          
[117109.757953]        <ffffffff8029f279>{schedule+1} <ffffffff8015bf36>{kswapd+263}            
[117109.766566]        <ffffffff801420ac>{autoremove_wake_function+0} <ffffffff8010e66e>{child_rip+8}
[117109.776910]        <ffffffff8015be2f>{kswapd+0} <ffffffff8010e666>{child_rip+0}                  
[117109.785461]                                                                    
[117109.788162]        
[117109.788163] Code: 48 89 10 49 c7 40 08 00 02 20 00 49 c7 00 00 01 10 00 f0 41 
[117109.798435] RIP <ffffffff8015abe8>{isolate_lru_pages+77} RSP <ffff81007e729c58>
[117109.806956] CR2: ffff8000027a7c68                                              
[117109.810858]  NMI Watchdog detected LOCKUP on CPU 1
[117115.843485] CPU 1                                 
[117115.845901] Modules linked in: af_packet w83627hf hwmon_vid i2c_isa ide_disk ide_cd cdrom ipv6 joydev evdev i2c_nforce2 snd_ac97_bus analog psmouse floppy parport_pc parport i2c_core soundcore gameport pcspkr serio_raw rtc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod ide_generic sd_mod sata_nv libata scsi_mod ehci_hcd generic forcedeth amd74xx ide_core ohci_hcd thermal processor fan unix
[117115.888369] Pid: 18498, comm: proftpd Not tainted 2.6.15.3 #1
[117115.895066] RIP: 0010:[<ffffffff802a08e7>] <ffffffff802a08e7>{.text.lock.spinlock+46}
[117115.903984] RSP: 0018:ffff81004c72fb40  EFLAGS: 00200082                             
[117115.910397] RAX: 0000000000000001 RBX: ffff81000000c380 RCX: 0000000000001000
[117115.918699] RDX: ffff81004c72fc10 RSI: 0000000000000000 RDI: ffff81000000c600
[117115.926992] RBP: ffff810001b83b60 R08: ffff81005344f940 R09: ffff81005344f940
[117115.935300] R10: ffffffff801d06de R11: ffffffff801d06de R12: ffff81004c72fb88
[117115.943609] R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000020
[117115.951936] FS:  0000000000000000(0000) GS:ffffffff803a8880(0063) knlGS:000000005589dea0
[117115.961327] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b                           
[117115.968009] CR2: 000000005556f000 CR3: 0000000047c8b000 CR4: 00000000000006e0
[117115.976312] Process proftpd (pid: 18498, threadinfo ffff81004c72e000, task ffff81005169f790)
[117115.986117] Stack: ffffffff8015a02a ffff81005344f940 ffff810001b83c08 ffff81004c72fcf8      
[117115.995231]        0000000000000020 ffff81005344f940 ffffffff801910f3 ffffffff8811fa86 
[117116.004543]        ffff810060f761f0 0000000000000004                                   
[117116.010465] Call Trace:<ffffffff8015a02a>{__pagevec_lru_add+76} <ffffffff801910f3>{mpage_readpages+246}
[117116.021389]        <ffffffff8811fa86>{:ext3:ext3_get_block+0} <ffffffff8015614c>{__do_page_cache_readahead+318}
[117116.033151]        <ffffffff8024295c>{lock_sock+158} <ffffffff80242c9b>{release_sock+19}                       
[117116.042579]        <ffffffff80271bd7>{tcp_sendpage+1565} <ffffffff8015646b>{blockable_page_cache_readahead+83}
[117116.054194]        <ffffffff8015654b>{make_ahead_window+129} <ffffffff801566f4>{page_cache_readahead+401}     
[117116.065298]        <ffffffff80150fae>{do_generic_mapping_read+294} <ffffffff8014f816>{file_send_actor+0} 
[117116.076326]        <ffffffff8015127e>{generic_file_sendfile+71} <ffffffff80170642>{do_sendfile+458}     
[117116.086860]        <ffffffff8018088c>{sys_fcntl+718} <ffffffff8017072e>{sys_sendfile64+75}         
[117116.096459]        <ffffffff8011d14b>{cstar_do_call+27}                                   
[117116.102883]                                             
[117116.102884] Code: 83 3f 00 7e f9 e9 c1 fe ff ff f3 90 83 3f 00 7e f9 e9 d2 fe 
[117116.113139] console shuts up ...                                              
[117116.116932]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
[117116.125356]  NMI Watchdog detected LOCKUP on CPU 0                          
[117121.478568] CPU 0                                 
[117121.480969] Modules linked in: af_packet w83627hf hwmon_vid i2c_isa ide_disk ide_cd cdrom ipv6 joydev evdev i2c_nforce2 snd_ac97_bus analog psmouse floppy parport_pc parport i2c_core soundcore gameport pcspkr serio_raw rtc ext3 jbd mbcache raid6 raid5 xor raid10 raid1 raid0 linear md_mod dm_mod ide_generic sd_mod sata_nv libata scsi_mod ehci_hcd generic forcedeth amd74xx ide_core ohci_hcd thermal processor fan unix
[117121.523462] Pid: 7245, comm: syslogd Not tainted 2.6.15.3 #1
[117121.530074] RIP: 0010:[<ffffffff802a08e7>] <ffffffff802a08e7>{.text.lock.spinlock+46}
[117121.538983] RSP: 0018:ffff81007c903ab0  EFLAGS: 00000082                             
[117121.545395] RAX: 0000000000000001 RBX: ffff810002745620 RCX: 0000000000000000
[117121.553689] RDX: 0000000000000000 RSI: ffff81007c903b28 RDI: ffff81000000c600
[117121.561972] RBP: ffff81000000c380 R08: 0000000000000004 R09: 0000000000000008
[117121.570283] R10: 00000000fffffff9 R11: 0000000000000000 R12: ffff810002c14fa0
[117121.578583] R13: ffff810002c14f60 R14: 0000000000000000 R15: ffff810018018138
[117121.586893] FS:  0000000000000000(0000) GS:ffffffff803a8800(0063) knlGS:00000000556b36c0
[117121.596301] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b                           
[117121.603000] CR2: ffff8000027a7c68 CR3: 000000007d881000 CR4: 00000000000006e0
[117121.611311] Process syslogd (pid: 7245, threadinfo ffff81007c902000, task ffff81007d4c8380)
[117121.621029] Stack: ffffffff8015a184 0000000000000000 ffff810002745620 0000000000000008     
[117121.630152]        ffffffff8015a22b ffff8100251a1298 ffffffff801738cf ffff8100251a1298 
[117121.639431]        ffff81005e7106b8 ffff810029ccba80                                   
[117121.645316] Call Trace:<ffffffff8015a184>{activate_page+34} <ffffffff8015a22b>{mark_page_accessed+33}
[117121.656034]        <ffffffff801738cf>{__find_get_block+373} <ffffffff801738fa>{__getblk+25}          
[117121.665745]        <ffffffff8811d68b>{:ext3:__ext3_get_inode_loc+549} <ffffffff8811d81d>{:ext3:ext3_reserve_inode_write+33}
[117121.678660]        <ffffffff8811dd18>{:ext3:ext3_mark_inode_dirty+22} <ffffffff8811e15e>{:ext3:ext3_dirty_inode+99}        
[117121.690804]        <ffffffff8018f9fc>{__mark_inode_dirty+44} <ffffffff80151da8>{__generic_file_aio_write_nolock+678}
[117121.703008]        <ffffffff80151ee1>{__generic_file_write_nolock+149}                                              
[117121.710632]        <ffffffff80181530>{poll_freewait+73} <ffffffff801420ac>{autoremove_wake_function+0}
[117121.721437]        <ffffffff80151f38>{generic_file_writev+62} <ffffffff801960dc>{compat_do_readv_writev+374}
[117121.732860]        <ffffffff8016fa8b>{do_sync_write+0} <ffffffff80196254>{compat_sys_writev+89}             
[117121.742971]        <ffffffff8011d14b>{cstar_do_call+27}                                        
[117121.749368]                                             
[117121.749369] Code: 83 3f 00 7e f9 e9 c1 fe ff ff f3 90 83 3f 00 7e f9 e9 d2 fe 
[117121.759660] console shuts up ...                                              

I guess the two last follow from the first one, but I guess having all the
information there still would be in order. :-) Please Cc me on any replies;
I'm not subscribed to the list.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
