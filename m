Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTLJNmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTLJNmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:42:22 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:56979 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262788AbTLJNmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:42:17 -0500
Message-ID: <3FD722BC.1000205@xfs.org>
Date: Wed, 10 Dec 2003 07:42:20 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mihai RUSU <dizzy@roedu.net>
CC: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/xfs/support/debug.c:106!
References: <Pine.LNX.4.56L0.0312100953310.8346@ahriman.bucharest.roedu.net>
In-Reply-To: <Pine.LNX.4.56L0.0312100953310.8346@ahriman.bucharest.roedu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai RUSU wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hi
>
>Another problem now, on another system. This one is a 2xP3 1.1 Ghz, 3 GB 
>RAM, MB Intel SCB2, Adaptec 7899 Controller onboard having one 18 GB SCSI 
>disk connected to it (for XFS external journal, swap and / partition which 
>is on ext3), Mylex 170 RAID connected to external storage enclosure with 3 
>x 70 GB SCSI RAID5. The kernel error message is:
>
>  
>

Mihai,

You missed one thing out of your report, the console message xfs output 
before
this.

I suspect it would have been this: xfs_iget_core: ambiguous vns: vp/0x .....
but it would be good to confirm it. This was supposed to be a dead code
path which there was no longer a route to, it is possible something in the
NFS interface in 2.6 has changed to cause this though. Basically a race
between two threads looking up the same inode, xfs has it cached already
and two threads raced to setup the mapping from the linux inode.

The use of iget_locked when looking up new inodes is supposed to protect
against just this condition.

Steve


