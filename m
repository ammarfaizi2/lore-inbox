Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTLVMcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 07:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTLVMcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 07:32:32 -0500
Received: from ping.ovh.net ([213.186.33.13]:46528 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S263609AbTLVMc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 07:32:28 -0500
Date: Mon, 22 Dec 2003 13:30:36 +0100
From: Octave <oles@ovh.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031222123036.GW12491@ovh.net>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221184709.GO25043@ovh.net> <20031221185959.GE1494@louise.pinerecords.com> <20031221234350.GD4897@ovh.net> <Pine.LNX.4.58L.0312220921120.2691@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312220921120.2691@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Octave,
> 
> What do you mean with "server is down" ? The OOM killer killed an
> application ? What were the messages?
> 
> Under out of memory, 2.4.22 should also kill a process, but you say it
> doesnt.

Marcelo,

All I have with 
- 2.4.24-pre1 is
# echo 1 > /proc/sys/vm/vm_gfp_debug        
# for i in `seq 1 100`; do ./full.pl &  done
[1] 849
[2] 850
[...]                                                                                                 
# tail -f /var/log/messages                                                                                                                    
[...]

SOFTDOG: Initiating system reboot.

LILO:

- 2.4.23 
Dec 22 13:16:30 u8668 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)                                                                            
Dec 22 13:16:30 u8668 kernel: f7465e74 c012e1d8 000001d2 00000000 00000001 c493e120 000003ef 00000000                                                           
Dec 22 13:16:30 u8668 kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80                                                    
Dec 22 13:16:30 u8668 kernel:        c1ab6bf0 c0121fe8 f5759d40 00125eac 00000001 c493e120 00000000 0003923f                                                    
Dec 22 13:16:30 u8668 kernel: Call Trace:    [raw_devices+7128/8192] [raw_devices+6016/8192] [buf.0+40/1024] [log_buf+275/16384] [device_list+2031/2032]        
Dec 22 13:16:30 u8668 kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c0121fe8>] [<c0122913>] [<c0111707>]                                                   
Dec 22 13:16:30 u8668 kernel:   [device_list+1636/2032] [dfont_unitable+352/608]                                                                                
Dec 22 13:16:30 u8668 kernel:   [<c011157c>] [<c0106fa0>]                                                                                                       
Dec 22 13:16:30 u8668 kernel: VM: killing process full.pl
Dec 22 13:16:30 u8668 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)                                                                            
Dec 22 13:16:30 u8668 kernel: f7465d40 c012e1d8 000001d2 00000000 00000000 f79d79a4 000003ef 00000000                                                           
Dec 22 13:16:30 u8668 kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80                                                    
Dec 22 13:16:34 u8668 kernel:        00000000 c012595a f7464000 c0000000 f7465eec 00000000 f7ddb788 00001000                                                    
Dec 22 13:16:34 u8668 kernel: Call Trace:    [raw_devices+7128/8192] [raw_devices+6016/8192] [log_buf+12634/16384] [log_buf+14106/16384] [log_buf+13724/16384]  
Dec 22 13:16:34 u8668 kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c012595a>] [<c0125f1a>] [<c0125d9c>]                                                   
Dec 22 13:16:34 u8668 kernel:   [read_ahead+669/1020] [blk_dev+29672/35712] [blk_dev+31175/35712] [blk_dev+32524/35712] [devpts_root_inode_operations+67/80] [df
ont_unitable+119/608]                                                                                                                                           
Dec 22 13:16:35 u8668 kernel:   [<c0135dbd>] [<c013d328>] [<c013d907>] [<c013de4c>] [<c0105ac3>] [<c0106eb7>]
Dec 22 13:16:35 u8668 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec 22 13:16:35 u8668 kernel: f729fe14 c012e1d8 000001d2 00128000 00000001 f77ef8e0 000003ef 00000000 
Dec 22 13:16:35 u8668 kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 22 13:16:35 u8668 kernel:        00104025 c01225a3 f77ef8e0 00128000 00000001 f7317aa0 f7ce4800 c01226bf 
Dec 22 13:16:36 u8668 kernel: Call Trace:    [raw_devices+7128/8192] [raw_devices+6016/8192] [printk_buf.1+451/1024] [printk_buf.1+735/1024] [log_buf+232/16384]
Dec 22 13:16:36 u8668 kernel: Call Trace:    [<c012e1d8>] [<c012dd80>] [<c01225a3>] [<c01226bf>] [<c01228e8>]
Dec 22 13:16:36 u8668 kernel:   [pidhash+2049/4096] [log_buf+704/16384] [log_buf+3230/16384] [DAC960_MessageLevelMap+30/32] [dfont_unitable+119/608]
Dec 22 13:16:36 u8668 kernel:   [<c0121781>] [<c0122ac0>] [<c012349e>] [<c010c6be>] [<c0106eb7>]
Dec 22 13:16:36 u8668 kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Dec 22 13:16:36 u8668 kernel: f729fe14 c012e1d8 000001d2 00128000 00000001 f77ef8e0 000003ef 00000000 
Dec 22 13:16:36 u8668 kernel:        00000018 00000002 c029e998 c029ea94 00000000 000001d2 00000000 c012dd80 
Dec 22 13:16:36 u8668 kernel:        00104025 c01225a3 f77ef8e0 00128000 00000001 f7317aa0 f7ce4800 c01226bf 
Dec 22 13:16:36 u8668 kernel: Call Trace:    [raw_devices+7128/8192] [raw_devices+6016/8192] [printk_buf.1+451/1024] [printk_buf.1+735/1024] [log_buf+232/16384]

[...]

then nothing more.

- 2.4.22

# echo 1 > /proc/sys/vm/vm_gfp_debug
bash: /proc/sys/vm/vm_gfp_debug: No such file or directory
# echo 1 > /proc/sys/vm/            
bdflush            max-readahead      min-readahead      page-cluster
kswapd             max_map_count      overcommit_memory  pagetable_cache
# tail -f /var/log/messages
Dec 22 13:28:34 u8668 kernel: Out of Memory: Killed process 441 (named).
Dec 22 13:28:34 u8668 kernel: Out of Memory: Killed process 443 (named).
Dec 22 13:28:34 u8668 kernel: Out of Memory: Killed process 444 (named).
Dec 22 13:28:34 u8668 kernel: Out of Memory: Killed process 445 (named).
Dec 22 13:28:34 u8668 kernel: Out of Memory: Killed process 446 (named).
Dec 22 13:28:34 u8668 kernel: Out of Memory: Killed process 447 (named).
Dec 22 13:28:42 u8668 kernel: Out of Memory: Killed process 750 (mysqld).
Dec 22 13:28:42 u8668 kernel: Out of Memory: Killed process 760 (mysqld).
Dec 22 13:28:42 u8668 kernel: Out of Memory: Killed process 761 (mysqld).
Dec 22 13:28:48 u8668 kernel: Out of Memory: Killed process 636 (httpd).
Dec 22 13:28:57 u8668 kernel: Out of Memory: Killed process 637 (httpd).
Dec 22 13:29:03 u8668 kernel: Out of Memory: Killed process 638 (httpd).
Dec 22 13:29:14 u8668 kernel: Out of Memory: Killed process 639 (httpd).
SOFTDOG: Initiating system reboot.

Thanks for help

Octave

