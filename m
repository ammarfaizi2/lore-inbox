Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWKFGPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWKFGPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 01:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWKFGPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 01:15:25 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:20461 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932596AbWKFGPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 01:15:25 -0500
Message-ID: <454ED2F8.9050608@garzik.org>
Date: Mon, 06 Nov 2006 01:15:20 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Poor NFSv4 first impressions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being a big user of NFS at home, and a big fan of NFSv4, it was high 
time that I converted my home network from NFSv3 to NFSv4.

Unfortunately applications started breaking left and right.  vim 
noticeably malfunctioned, trying repeatedly to create a swapfile (sorta 
like a lockfile).  Mozilla Thunderbird would crash reproducibly whenever 
it tried anything remotely major with a mailbox, such as compressing 
folders (removing deleted messages).

Both NFSv4 server and NFSv4 client were x86-64 Linux boxes, running 
hyper-recent kernel 2.6.19-rc4-g10b1fbdb 
(10b1fbdb0a0ca91847a534ad26d0bc250c25b74f).  FC5 userland on the server, 
FC6 userland on the client.  There were no other clients connected to 
the NFS server, much less using my NFS homedir.  This data was not being 
accessed on the server directly, either.

/etc/exports contains:
/g 
10.10.10.0/255.255.255.0(rw,fsid=0,insecure,no_subtree_check,no_root_squash)

NFSv4 /etc/fstab line:
pretzel:/       /g      nfs4    defaults,proto=tcp,hard,intr    0 0

NFSv3 (previous) /etc/fstab line for same file server:
pretzel:/g              /g              nfs     defaults,tcp    0 0


I hope this is just a temporary problem, but as it looks right now, 
NFSv4 isn't ready for prime time, with all these apps breaking :/

	Jeff


