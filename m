Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261647AbSJAOgp>; Tue, 1 Oct 2002 10:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbSJAOgp>; Tue, 1 Oct 2002 10:36:45 -0400
Received: from [204.248.145.126] ([204.248.145.126]:6824 "HELO mail.lig.net")
	by vger.kernel.org with SMTP id <S261647AbSJAOgn>;
	Tue, 1 Oct 2002 10:36:43 -0400
Message-ID: <3D99B60C.20303@lig.net>
Date: Tue, 01 Oct 2002 10:49:48 -0400
From: "Stephen D. Williams" <sdw@lig.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Rsync SSH session hang, AGAIN  -  Help!  Deadlock debugging needed.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been a recurring problem for a couple years which I and others 
have experienced.  I was free from it for a while, but after upgrading 
OpenSSL/OpenSSH to avoid the recent exploit it is back and highly 
repeatable.  This has been persistant enough that I am going to start 
with the assumption that it may be a kernel bug, or at least probably 
debuggable definitively only by a proficient kernel developer.  We have 
got to squash this once and for all; SSH is used everywhere and it needs 
to be reliable.  Probably there is a race condition in ssh, as mentioned 
below, but it must be subtle.

rsync/ssh transfers from local system to local system work perfectly. 
 Between the systems, there is nearly always large delays at certain 
times and usually a complete hang.  After a long period, this often 
produces a timeout.  These sytems are on 100baseT on the same switch. 
 One system appears to be having mild packet loss (400 out of 400,000 on 
both send and receive as frame/carrier erros).  BTW, running a cpio 
through the SSH connections causes a nearly immediate hang, so it is 
unlikely to be a problem with rsync.

Both systems work find receiving rsync/ssh from my laptop over a 400Kb 
DSL connection with:
OpenSSH 3.1p1
openssl 0.9.6c
rsync 2.5.4
gcc 2.96
kernel 2.4.19

(systems are a combination of Suse and Redhat 7.3, upgraded variously by 
hand)

My standard rsync/ssh script looks like:

brsyncndz (backup rsync no delete or compression):
#!/bin/sh
if [ "$PORT" = "" ]; then PORT=22; fi
rsync -vv -HpogDtSxlra --partial --progress --stats -e "ssh -p $PORT" $*

On both sides:
OpenSSL-0.9.6g
Openssh-3.4p1
rsync-2.5.5

On 'old' system:
gcc 2.95.2
kernel 2.4.3

On 'new' system:
gcc 2.96
kernel 2.4.20-pre8


References to past discussions:  (Tried the TCP buffers tuning.)
http://lists.insecure.org/linux-kernel/2001/Mar/0374.html
http://lists.insecure.org/linux-kernel/2001/Mar/0380.html
http://lists.insecure.org/linux-kernel/2001/Mar/0400.html
Haven't tried this code yet:
http://lists.insecure.org/linux-kernel/2001/Mar/0652.html

Thanks!
sdw
-- 
sdw@lig.net http://sdw.st
Stephen D. Williams 43392 Wayside Cir,Ashburn,VA 20147-4622
703-724-0118W 703-995-0407Fax Dec2001



