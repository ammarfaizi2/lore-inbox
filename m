Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWBHJlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWBHJlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBHJlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:41:17 -0500
Received: from odin2.bull.net ([192.90.70.84]:7086 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932435AbWBHJlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:41:16 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: PREEMPT_RT and mptbase, mptscsih : I loose my file systems ( 2.6.15-rt16 )
Date: Wed, 8 Feb 2006 10:48:14 +0100
User-Agent: KMail/1.7.1
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Message-Id: <200602081048.15418.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 02/08/2006 10:41:12 AM,
	Serialize by Router on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 02/08/2006 10:41:14 AM,
	Serialize complete at 02/08/2006 10:41:14 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have some problems with 2.6.15 and rt16 patch from ingo.
I have the following problems :

I can reproduce the problem easily after each reboot at any realtime priority with only one program.
The problem occurs if all the IRQ's are affected to CPU 0 ( smp_affinity ) and the test run on CPU 0.
Only one program which makes 60000000000ULL  loops.
Before I run this program, I type the command script to keep the results.
When the test stop, I quit the script command <ctrl>d.
I am in the standard shell.
The result file from the script command is empty. This is how I find the problem :

I have no more access to the file system. I can only do less and some other command.
I get Input/Output error for all new command not in memory.
If I try to ssh from another machine, I obtain the following messages :
[root@dist2 root]# ssh dist1
root@dist1's password: 
Last login: Mon Jan 16 11:13:49 2006 from dist2.btsn.xxxxxxxxxx
/usr/X11R6/bin/xauth:  error in locking authority file /root/.Xauthority
I can't access .Xauthority file which exists. I could access it before the test.

At this point, If I try to reboot, I get the following messages.
<CTRL><ALT><DEL> => INIT: cannot execute "/sbin/shutdown"
/sbin/reboot   => Input/Output error

Before launching the script and the test, the system works correctly.

If you need more infos, I can  try some commands, debug options ...
Do I need to use a special CONFIG option ?

With more debug infos, I get the following messages :
...
mptscsih: ioc0: attempting task abort! (sc=f67e1680)
sd 0:0:0:0:
        command: Write (10): 2a 00 01 c3 db 1a 00 00 10 00
mptbase: Initiating ioc0 recovery
mptscsih: ioc0: task abort: SUCCESS (sc=f67e1680)
mptscsih: ioc0: attempting task abort! (sc=f67e1680)
sd 0:0:0:0:
        command: Test Unit Ready: 00 00 00 00 00 00
mptbase: Initiating ioc0 recovery
mptscsih: ioc0: task abort: SUCCESS (sc=f67e1680)
mptscsih: ioc0: attempting task abort! (sc=f67e1800)
sd 0:0:0:0:
        command: Test Unit Ready: 00 00 00 00 00 00
mptbase: Initiating ioc1 recovery
mptscsih: ioc0: task abort: SUCCESS (sc=f67e1800)
mptscsih: ioc0: attempting task abort! (sc=f668c680)
sd 0:0:0:0:
        command: Test Unit Ready: 00 00 00 00 00 00
mptbase: Initiating ioc0 recovery
mptscsih: ioc0: task abort: SUCCESS (sc=f668c680)
mptscsih: ioc0: attempting task abort! (sc=f668c500)
sd 0:0:0:0:
        command: Test Unit Ready: 00 00 00 00 00 00
mptbase: Initiating ioc1 recovery
mptscsih: ioc0: task abort: SUCCESS (sc=f668c500)
mptscsih: ioc0: attempting target reset! (sc=f67e1680)
sd 0:0:0:0:
        command: Write (10): 2a 00 01 c3 db 1a 00 00 10 00
mptscsih: ioc0: Issue of TaskMgmt failed!
mptscsih: ioc0: target reset: FAILED (sc=f67e1680)
mptscsih: ioc0: attempting bus reset! (sc=f67e1680)
sd 0:0:0:0:
        command: Write (10): 2a 00 01 c3 db 1a 00 00 10 00
mptbase: Initiating ioc0 recovery
mptscsih: ioc0: bus reset: SUCCESS (sc=f67e1680)
mptscsih: ioc0: Attempting host reset! (sc=f67e1680)
mptbase: Initiating ioc0 recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1619926
lost page write due to I/O error on sda6
Buffer I/O error on device sda6, logical block 1619927
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1619948
lost page write due to I/O error on sda6
Buffer I/O error on device sda6, logical block 1619949
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1619908
lost page write due to I/O error on sda6
Buffer I/O error on device sda6, logical block 1619909
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1635317
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1637550
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 8763
lost page write due to I/O error on sda6
sd 0:0:0:0: SCSI error: return code = 0x10000
end_request: I/O error, dev sda, sector 17350666
Buffer I/O error on device sda6, logical block 1616591
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
Aborting journal on device sda6.
Aborting journal on device sda8.
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
__journal_remove_journal_head: freeing b_committed_data
journal commit I/O error
ext3_abort called.
EXT3-fs error (device sda6): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
sd 0:0:0:0: rejecting I/O to offline device
printk: 26 messages suppressed.
Buffer I/O error on device sda6, logical block 1605634
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda8, logical block 6225925
lost page write due to I/O error on sda8
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 0
lost page write due to I/O error on sda6
Buffer I/O error on device sda6, logical block 1
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1245272
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda6, logical block 1605635
lost page write due to I/O error on sda6
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device
EXT3-fs error (device sda6): ext3_find_entry: reading directory #793762 offset 0
sd 0:0:0:0: rejecting I/O to offline device
sd 0:0:0:0: rejecting I/O to offline device

-- 
Serge Noiraud
