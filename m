Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbTABLoI>; Thu, 2 Jan 2003 06:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTABLoI>; Thu, 2 Jan 2003 06:44:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:39619 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261398AbTABLoH>;
	Thu, 2 Jan 2003 06:44:07 -0500
Message-ID: <3E1427FD.16A7B021@digeo.com>
Date: Thu, 02 Jan 2003 03:52:29 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kallsyms crashes in 2.5.54
References: <20030102091325.GA24352@averell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 11:52:30.0321 (UTC) FILETIME=[6DC24E10:01C2B255]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> The kernel symbol stem compression patch included in 2.5.54 unfortunately
> had a few problems, triggered by various circumstances.
> 

With your patch I am still seeing an instant oops when running top(1):

connect(6, {sin_family=AF_UNIX, path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No such file or directory)
close(6)                                = 0
open("/etc/group", O_RDONLY)            = 6
fcntl64(0x6, 0x1, 0, 0x1)               = 0
fcntl64(0x6, 0x2, 0x1, 0x1)             = 0
fstat64(6, {st_mode=S_IFREG|0644, st_size=720, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40023000
read(6, "root:x:0:root\nbin:x:1:root,bin,d"..., 4096) = 720
close(6)                                = 0
munmap(0x40023000, 4096)                = 0
open("/proc/1/cmdline", O_RDONLY)       = 6
read(6, "init [3]\0\0\0\0\0\0\0\0\0\0\0", 2047) = 19
close(6)                                = 0
open("/proc/1/wchan", O_RDONLY)         = 6
read(6, 


The oops isn't very informative.  EIP is 0x00000000, call trace
is just "scheduling_functions_start_here+0x3dd/0x4a8"

Using procps from http://surriel.com/procps/
