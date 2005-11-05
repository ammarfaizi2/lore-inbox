Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVKEG2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVKEG2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 01:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVKEG2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 01:28:22 -0500
Received: from mail.dvmed.net ([216.237.124.58]:39869 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751253AbVKEG2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 01:28:21 -0500
Message-ID: <436C50FE.3030600@pobox.com>
Date: Sat, 05 Nov 2005 01:28:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond.Myklebust@netapp.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: recent NFS problems?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit weird.  Running 2.6.14-g6037d6bb (libata-dev.git branch 
'upstream') on both client and server.  Its latest Linux 
(7015faa7df829876a0f931cd18aa6d7c24a1b581) plus one libata patch.  All 
NFSv4 kernel options are enabled, on both client and server.

On Host A, I mirror a local directory /garz/nsmail to an NFS directory 
Host_B:/g/g/nsmail via rsync+ssh.  Host A also NFS mounts Host_B:/g 
locally.  mount on Host A says

	host_b:/g on /g type nfs (rw,tcp,intr,posix,addr=10.10.10.1)

Seeing some directory weirdness, where wildcard matches fail 
(NFS-related dcache bugs?) but direct accesses succeed:

[jgarzik@host_a~]$ ssh host_b "ls -d /g/g/nsmail/Trash.sbd/*11*"
/g/g/nsmail/Trash.sbd/Sent.20051105
/g/g/nsmail/Trash.sbd/Sent.20051105.msf
/g/g/nsmail/Trash.sbd/Sent.20051105.sbd
/g/g/nsmail/Trash.sbd/Trash.20051105
/g/g/nsmail/Trash.sbd/Trash.20051105.msf
/g/g/nsmail/Trash.sbd/Trash.20051105.sbd

[jgarzik@host_a ~]$ ls -d /g/g/nsmail/Trash.sbd/*11*
ls: /g/g/nsmail/Trash.sbd/*11*: No such file or directory

[jgarzik@host_a ~]$ ls -l /g/g/nsmail/Trash.sbd/Trash.20051105
-rw-rw-r--  1 jgarzik jgarzik 67484129 Nov  5 00:02 
/g/g/nsmail/Trash.sbd/Trash.20051105

[jgarzik@host_a~]$ wc -l /g/g/nsmail/Trash.sbd/Trash.20051105
1739088 /g/g/nsmail/Trash.sbd/Trash.20051105
