Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWJEQIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWJEQIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWJEQIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:3540 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932168AbWJEQIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:08:22 -0400
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: sys_splice crashes in 2.6.19rc1 during autotest
Date: Thu, 5 Oct 2006 18:08:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200610051725.53183.ak@suse.de> <20061005155844.GC5170@kernel.dk>
In-Reply-To: <20061005155844.GC5170@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051808.16764.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 17:58, Jens Axboe wrote:
> On Thu, Oct 05 2006, Andi Kleen wrote:
> > 
> > I was running autotest on 2.6.19rc1+x86_64 patchkit and I ended up with a BUG()
> > below sys_splice while running some IO test there.
> > 
> > This was a debugging kernel with PREEMPTION and various other
> > debugging options enabled.
> > 
> > The system ran out of disk space during the test so that
> > might have been related and I ended up with a "fio" process
> > in D. Also the system was confused afterwards with rm
> > oopsing etc.
> > 
> > File system was reiserfs.
> 
> Can you pass me the fio job file you used?

I just ran autotest all_tests

It seems to use

; fio-mixed.job for autotest

[global]
name=fio-sync
;directory=tmpfiles
rw=randrw
rwmixread=67
rwmixwrite=33
bsrange=16K-256K
direct=0
end_fsync=1
verify=crc32
;ioscheduler=x
numjobs=4

[file1]
size=100M
ioengine=sync
mem=malloc

[file2]
stonewall
size=100M
ioengine=aio
mem=shm
iodepth=4

[file3]
stonewall
size=100M
ioengine=mmap
mem=mmap
direct=1

[file4]
stonewall
size=100M
ioengine=splice
mem=malloc
direct=1

-Andi


