Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTDPRjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTDPRjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:39:16 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:41108 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S264520AbTDPRjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:39:05 -0400
Message-ID: <3E9D984F.20402@hccnet.nl>
Date: Wed, 16 Apr 2003 19:52:15 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: tconnors@astro.swin.edu.au, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl> <1050172083.2291.459.camel@localhost> <3E993C54.40805@hccnet.nl> <1050255133.733.6.camel@localhost> <3E99A1E4.30904@hccnet.nl> <20030415120000.A30422@beaverton.ibm.com> <3E9C6F10.10001@hccnet.nl> <20030415144051.A31514@beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>
>Can you capture output for the mount with scsi logging on?
>
>It may or may not help track down what is happening.
>
>If you haven't done much scsi, some scsi logging info:
>
>Check that your .config has CONFIG_SCSI_LOGGING on.
>
>Then do something like:
>
>sync
>sync
>echo scsi log all > /proc/scsi/scsi 
>mount /dev/sdw1 /mnt/sdw1
>  
>
scsi logging level set to 0xffffffff
sd_open: disk=sda
scsi_block_when_processing_errors: rtn: 1
sd_media_changed: disk=sda
scsi_block_when_processing_errors: rtn: 1
scsi_block_when_processing_errors: rtn: 1
Trying ioctl with scsi command 0
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 10000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = 00000000,
bufflen = 0, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command failed c7ea4060 2 busy=1 failed=0
bh?: old sense key No Sense
Non-extended sense class 0 code 0x0
Waking error handler thread
Error handler scsi_eh_0 waking up
scsi_eh_prt_fail_stats: 0:0:6:0 cmds failed: 1, cancel: 0
Total of 1 commands on 1 devices require eh work
scsi_eh_0: requesting sense for id: 6
scsi_add_timer: scmd: c7ea4060, time: 10000, (c0239f10)
scsi_eh_done scmd: c7ea4060 result: 0
scsi_send_eh_cmnd: scmd: c7ea4060, rtn:2002
scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
sense requested for c7ea4060 result 2
Current bh?: sense key Unit Attention
Additional sense: Not ready to ready change, medium may have changed
scsi_eh_0: flush finish cmd: c7ea4060
Notifying upper driver of completion for device 6 8000002
scsi_restart_operations: waking up host to restart
Error handler scsi_eh_0 sleeping
Ioctl returned  0x8000002
IOCTL Releasing command
sd_init_onedisk: disk=sda
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 0, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 8, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 4, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 4, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command failed c7ea4060 2 busy=1 failed=0
bh?: old sense key No Sense
Non-extended sense class 0 code 0x0
Waking error handler thread
Error handler scsi_eh_0 waking up
scsi_eh_prt_fail_stats: 0:0:6:0 cmds failed: 1, cancel: 0
Total of 1 commands on 1 devices require eh work
scsi_eh_0: requesting sense for id: 6
scsi_add_timer: scmd: c7ea4060, time: 10000, (c0239f10)
scsi_eh_done scmd: c7ea4060 result: 0
scsi_send_eh_cmnd: scmd: c7ea4060, rtn:2002
scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
sense requested for c7ea4060 result 2
Current bh?: sense key Illegal Request
Additional sense: Invalid field in cdb
scsi_eh_0: flush finish cmd: c7ea4060
Notifying upper driver of completion for device 6 8000002
scsi_restart_operations: waking up host to restart
Error handler scsi_eh_0 sleeping
sda: cache data unavailable
sda: assuming drive cache: write through
scsi_block_when_processing_errors: rtn: 1
Trying ioctl with scsi command 30
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 10000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = 00000000,
bufflen = 0, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
Ioctl returned  0x0
IOCTL Releasing command
sd_init_onedisk: disk=sda
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 0, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 8, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 4, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0
sda: Write Protect is off
sda: Mode Sense: 25 00 00 08
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea4060, time: 30000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea40b1, buffer = c0fffe00,
bufflen = 4, done = c023bb90)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
scsi_delete_timer: scmd: c7ea4060, rtn: 1
Command failed c7ea4060 2 busy=1 failed=0
bh?: old sense key No Sense
Non-extended sense class 0 code 0x0
Waking error handler thread
Error handler scsi_eh_0 waking up
scsi_eh_prt_fail_stats: 0:0:6:0 cmds failed: 1, cancel: 0
Total of 1 commands on 1 devices require eh work
scsi_eh_0: requesting sense for id: 6
scsi_add_timer: scmd: c7ea4060, time: 10000, (c0239f10)
scsi_eh_done scmd: c7ea4060 result: 0
scsi_send_eh_cmnd: scmd: c7ea4060, rtn:2002
scsi_send_eh_cmnd: scsi_eh_completed_normally 2002
sense requested for c7ea4060 result 2
Current bh?: sense key Illegal Request
Additional sense: Invalid field in cdb
scsi_eh_0: flush finish cmd: c7ea4060
Notifying upper driver of completion for device 6 8000002
scsi_restart_operations: waking up host to restart
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: c7ea41a0, time: 10000, (c0239cc0)
scsi_dispatch_cmnd (host = 0, channel = 0, target = 6, command = 
c7ea41f1, buffer = 00000000,
bufflen = 0, done = c023b0f0)
queuecommand : routine at c02417a0
leaving scsi_dispatch_cmnd()
Error handler scsi_eh_0 sleeping
sda: cache data unavailable
sda: assuming drive cache: write through
 sda:scsi_delete_timer: scmd: c7ea41a0, rtn: 1
Command finished 1 0 0x0
Notifying upper driver of completion for device 6 0



   Gert

