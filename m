Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTEEEjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTEEEjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:39:49 -0400
Received: from pop3.galileo.co.il ([199.203.130.130]:33695 "EHLO
	galileo5.il.marvell.com") by vger.kernel.org with ESMTP
	id S261917AbTEEEjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:39:47 -0400
Message-ID: <3EB5FC05.5080003@il.marvell.com>
Date: Mon, 05 May 2003 07:51:43 +0159
From: Zeev Fisher <Zeev.Fisher@il.marvell.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: processes stuck in D state
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got a continuos problem of unkillable processes stuck in D state ( 
uninterruptable sleep ) on my Linux servers.
It happens randomly every time on other server on another process ( all 
the servers are configured the same with 2.4.18-10 kernel ). Here's an 
example :

root@lnx35 /]# ps -el|grep D
 F S   UID   PID  PPID  C PRI  NI ADDR    SZ WCHAN  TTY          TIME CMD
000 D   911 29327     1  0  75   0    -  9382 lock_p ?        00:00:00 
calibre
000 D   894 30049 15854  0  75   0    -  8995 lock_p ?        00:00:01 
calibrewb
000 D   894 30092  8661  0  75   0    -  8995 lock_p ?        00:00:01 
calibrewb
000 D   894 29773 26052  0  75   0    -  8977 lock_p ?        00:00:01 
calibrewb


It was probably stuck while trying to get a lock (which was
certainly free) on an NFS volume mounted from a Netapp server.

Enabling debug mode on rpc ( echo '65535' >/proc/sys/sunrpc/rpc_debug ) 
didn't gave me any clue.
Tracing the stucked process pid doesn't give any output.

Those processes are there already few days and will stay there until 
next reboot.

The load average is now 4 ( although the machine is 100% idle ) and the 
system seems to work fine.
If other programs are started again they run and use the same mounts 
that the processes above are stuck on.

Another detail is that those problems started when i added the 'intr' 
option to my nfs mounted fs but i'm not sure. Also, i can't easily check 
that since this problem is not reproducible.

Has anyone noticed the same behavior ? Is this a well known problem ?


Thanks for your help.

-- 
Zeev Fisher - Unix System Administrator
Marvell Semiconductor Israel Ltd
Moshav Manof, D.N. Misgav 20184, ISRAEL
Email    -  Zeev.Fisher@il.marvell.com
Tel      -  + 972 4 9091402
Cell     -  + 972 54 995402
Fax      -  + 972 4 9091501
WWW Page:     http://www.marvell.com

------------------------------------------------------------------------
This message may contain confidential, proprietary or legally privileged
information. The information is intended only for the use of the individual
or entity named above. If the reader of this message is not the
intended recipient, you are hereby notified that any dissemination, distribution
or copying of this communication is strictly prohibited.
If you have received this communication in error, please notify us
immediately by telephone, or by e-mail and delete the message from your
computer.


