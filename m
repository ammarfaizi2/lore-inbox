Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267687AbUH1Tor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUH1Tor (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUH1Tor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:44:47 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:59871 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S267708AbUH1ToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:44:25 -0400
Message-ID: <4130E094.1010309@backtobasicsmgmt.com>
Date: Sat, 28 Aug 2004 12:44:20 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: 2.6.9-rc1 bk-current v2 mount "stale file handle" problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded two of my boxes here to 2.6.9-rc1 pulled from BitKeeper 
a few hours ago. One of them is my NFS server, using the kernel NFS 
daemon and serving XFS filesystems. The other is an NFS root client, 
using the kernel's autoconfiguration and NFS root mounting (using all 
default mount options).

After booting the NFS client, I had very strange behavior when creating 
symlinks on the NFS root if the link target path began with '.'. Just 
this sequence:

# mkdir foo
# cd foo
# ln -sf . test1
# ln -sf . test2
...

Would result in a successfully created link but an error message from ln 
reporting "stale NFS file handle".

Switching the NFS root client's mount to v3 from v2 seems to have 
avoided the problem.
