Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTDAKRN>; Tue, 1 Apr 2003 05:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTDAKRN>; Tue, 1 Apr 2003 05:17:13 -0500
Received: from [12.47.58.55] ([12.47.58.55]:7177 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262258AbTDAKRK>;
	Tue, 1 Apr 2003 05:17:10 -0500
Date: Tue, 1 Apr 2003 02:28:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@zip.com.au,
       adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-Id: <20030401022844.2dee1fe8.akpm@digeo.com>
In-Reply-To: <20030401100237.GA459@zip.com.au>
References: <20030401100237.GA459@zip.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 10:28:27.0039 (UTC) FILETIME=[6E7E4AF0:01C2F839]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> The journal recovery rangers from slow to really friggin slow under
> 2.5.66 with definate pauses in disk io stretching for 10s of seconds.
> This does not happen with 2.5.63 and if I hit ^c on fsck and let the
> kernel handle the journal recover for all partitions  on mountime
> the recovery under 2.5.66 is either so fast that you don't notice
> it or just a buttload faster. Very objective measurements of time but
> the slowness of a journal recover as done by fsck is so noticible it's
> not funny.
> 
> At the time of fsck journal recover or moiunt-time kernel journal
> recover DMA is turned on the drive.
> 
> e2fsprogs 1.27 is in use. (1.27-2 from debian woody)
> 

e2fsck 1.32 seems to work fine here.

Try arranging for a partition to _not_ be mounted at boot (disable it in
/etc/fstab).  Then do a `reboot -f' and when you get a login prompt, run
e2fsck against that partition.

If the journal recovery is still slow then try capturing the state when it is
stuck with sysrq-T.

