Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTK1Thv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 14:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTK1Thu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 14:37:50 -0500
Received: from [80.93.235.74] ([80.93.235.74]:56224 "EHLO office.kom")
	by vger.kernel.org with ESMTP id S261973AbTK1ThD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 14:37:03 -0500
Subject: Re: /proc/<pid>/status: VmSize
From: Vladimir Zidar <vladimir@mindnever.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1070047087.4058.469.camel@mravojed>
References: <1070047087.4058.469.camel@mravojed>
Content-Type: text/plain
Organization: MindNever Dot Org
Message-Id: <1070048518.31302.7.camel@mravojed>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 28 Nov 2003 20:41:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 In addition, here are status and statm files:

[ status ]

Name:   v
State:  S (sleeping)
Tgid:   15675
Pid:    15675
PPid:   15651
TracerPid:      0
Uid:    502     502     502     502
Gid:    502     502     502     502
FDSize: 16384
Groups: 502 10
VmSize:  2111108 kB
VmLck:         0 kB
VmRSS:   1114900 kB
VmData:   190332 kB
VmStk:        40 kB
VmExe:        28 kB
VmLib:      5424 kB
SigPnd: 0000000000000000
SigBlk: 0000000080000000
SigIgn: 0000000000001000
SigCgt: 0000000380000002
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000

[ statm ]

425731 278725 180470 8 276340 2377 276132


On Fri, 2003-11-28 at 20:18, Vladimir Zidar wrote:
>  Hola,
> 
>  We are running kernel 2.4.22 on i686 SMP box.
> Inside are two Intel(R) XEON(TM) CPU 2.00GHz, with hyperthreading
> enabled, so /proc/cpuinfo shows four CPUs. 
>  This box has 4GB of RAM installed, and 2GB of swap space.
> 
>  The problems we are experiencing are related to heavy usage of VM.
> 
>  We have multithreaded application that uses lots of mmap()-ed memory
> (one big file in size around 700 MB, and lots of anonymous mappings to
> /dev/zero in average size between 64k and 1MB). This program sometimes
> grow up to 1.6 GB in size (SIZE that is shown by top utility).. But,
> sometimes /proc/<pid>/status shows VmSize with more than 2GB, where at
> the same time top and other /proc/<pid> entries show 1.6GB. This somehow
> affects pthread_create() call which fails then.
> 
>  The question is, how can happen that different numbers are shown in
> proc filesystem, for same pid ? (which is part of multithreaded
> process), and why pthread_create() fails ? Is there maybe 2GB limit on
> memory size that single process can manage on i386 ? Also, when such
> program crashes, it creates 2GB core file, which is not completly usable
> from gdb. (gdb complains that some addresses are not accessible)..
>  I suspect that this has something to do with amount of RAM (4GB), but
> we are still trying to get this server tested with only 2GB running in
> standard (not paged) mode.. but this can take some time, since it is one
> of our production machines.
> 
> 
>  Anybody, idea ?
> 
>  Thanks.
-- 

