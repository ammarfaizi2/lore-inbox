Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbRBQXxo>; Sat, 17 Feb 2001 18:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129942AbRBQXxe>; Sat, 17 Feb 2001 18:53:34 -0500
Received: from srvr20.engin.umich.edu ([141.213.75.22]:2217 "EHLO
	srvr20.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S129697AbRBQXxa>; Sat, 17 Feb 2001 18:53:30 -0500
Date: Sat, 17 Feb 2001 18:53:27 -0500 (EST)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Mark Swanson <swansma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: System V msg queue bugs in latest kernels
Message-ID: <Pine.SOL.4.02.10102171837390.7014-100000@ultrakey.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred:

> If you want to access values > 65535 from your app you have 2 options:
> 
> 1) use the new msqid64_ds structure. You must pass IPC_64 to the msgctl
> call. This is the only option if you need correct 32-bit uids.

glibc 2.2 will support this natively without needing any changes to your
application (besides a recompile). struct msqid_ds in the glibc 2.2
headers corresponds to struct msqid64_ds in the kernel.

It would be a bad thing to require people to change their source code in
order to build against the improved sysvipc interface :)

(glibc 2.2 also handles the case of a non 2.4 kernel properly, by
detecting the lack of IPC_64 support and emulating it in software-- Jakub
Jelinek wrote this compatibility code because I was too lazy/didn't need
it myself)

-Chris Wing
wingc@engin.umich.edu

