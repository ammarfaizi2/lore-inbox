Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269792AbUJAO0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269792AbUJAO0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 10:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269798AbUJAO0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 10:26:13 -0400
Received: from [193.29.205.125] ([193.29.205.125]:35480 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S269792AbUJAO0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 10:26:11 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Windows Logical Disk Manager error
Date: Fri, 1 Oct 2004 16:26:07 +0200
User-Agent: KMail/1.7
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <200409231254.12287@senat> <200410010149.19951@senat> <1096619799.17297.22.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1096619799.17297.22.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410011626.09995@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would not advise you to use volume6 without the md driver.  You are
> then missing the last 32kb off the end and you never know when they

Well, I can't even build it... mdadm failes and driver complains with
md: Dev sda2 smaller than chunk_size: 0k < 32k

Different chunk size doesn't make any difference.

> direction.  Fortunately you can fix this case by using the "--rounding="
> parameter to mdadm.  So if you have a cluster size of 4k try
> --rounding=4.  (If you don't know your cluster size enable debugging in
> the ntfs driver and then do the mount and "dmesg | grep cluster_size"
> will tell you the answer.  To enable debugging in the driver it must be
> compiled with debugging enabled and you need to, as root, do: "echo 1 >
> /proc/sys/fs/ntfs-debug" after loading the module if modular and before
> doing the mount command.)

According to ntfs driver output my cluster size is indeed 4kb, but it still 
failes to read mounted fs.

Error is now:
NTFS-fs error (device md1): ntfs_readdir(): Actual VCN (0x20006500680054) of 
index buffer is different from expected VCN (0x4). Directory inode 0x5 is 
corrupt or driver bug.

Oh, and my system (and kernel) is x86-64 if it matters.

> "chkdsk /f" on it fixed it in that particular case (even though chkdsk
> reported no errors, apparently it fixed them without telling anyone!).
> So this is worth trying before you start messing around with --rounding=
> and mdadm.

I've tried that. No effect though.

-- 
mg
