Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285274AbRLFXES>; Thu, 6 Dec 2001 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285277AbRLFXEJ>; Thu, 6 Dec 2001 18:04:09 -0500
Received: from adsl-64-164-18-186.dsl.snfc21.pacbell.net ([64.164.18.186]:49731
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S285275AbRLFXEB>; Thu, 6 Dec 2001 18:04:01 -0500
Message-ID: <3C0FF958.5030703@switchmanagement.com>
Date: Thu, 06 Dec 2001 15:03:52 -0800
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011206
X-Accept-Language: en-us
MIME-Version: 1.0
To: robert.gehr@web2cad.de
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oracle
In-Reply-To: <OF46E13F0E.02B90B0D-ONC1256B1A.00428FD8@web2cad.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

robert.gehr@web2cad.de wrote:

>Hello Brian
>
>Sorry for contacting you directly but I could not find any anser in the
>kernel archive concerning the Problem you described.
>
No problem.  I am cc:ing lkml in case anyone else shares this problem, 
hopefully you don't mind?

>
>I face a similiar Problem which is as follows:
>
>I wanted to migrate an Oracle Database from a Prliant Server PentiumII
>450Mhz, 450MB, Wide SCSI Raid 5, Kernel 2.2.10,
>Oracle Version 8.1.7 running under Suse 6.2 on an ext2 Filesystem
>
>The new machine is a bit faster concerning the hardware: Proliant Server
>PentiumIII 600Mhz, 512MB , Ultra2 SCSI Raid 5, Oracle 8.1.7 Suse 7.2
>Kernel 2.4.16
>
>I followed the thread and kicked out reiser, replaced it with ext2,
>installed kernel 2.2.20 and tried all those combinations to and fro with
>the flippin result that the new machine is about 2-3 times slower than the
>old one on every combination imaginable. So much for newer kernels,
>filesystems etc.
>
>Have you found a solution to the problem you described in November. If so I
>would be thankful to know
>
Our current best known 2.4.x setup is Suse 7.2 with stock 2.4.16 with 
Oracle 8.1.7, running large tablespaces (i.e. temp, rbs, large 
data/index tablespaces) on rawio over LVM over RAID10.  The performance 
seems adequate; unfortunately due to the differing workloads I do not 
have exact numbers on 2.2.x vs 2.4.16.  I haven't tried 2.2.x on this 
server yet due to boot problems.  I originally thought it a kernel 
issue, but it turns out that the "2.2.x problem" was Oracle bogosity:  
Oracle was creating core dump directories 50000+ levels deep upon 
startup, running the machine out of VM/file descriptors in the process 
(indicated by e.g. "/bin/ls: permission denied" messages even when 
logged in as root), from which 2.2.20suse could not recover (2.4.16 
handled it adequately).  So I guess I should try 2.2.x for comparison 
and report the results, although I am rather reluctant to reboot a 
production box now that we've got a stable 2.4.x.

What is your workload like?  It seems that with RAID5 you might be doing 
mostly read-only transactions?  Our workload is mostly data warehousing, 
with the (large) difference that we do bulk updates (in the millions of 
rows) on previously loaded data.  I am curious if the slowdowns we have 
experienced only affect massively write-bound Oracle instances.  Also, 
are the number of RAID arrays and the tablespace layout the same across 
the two boxes?

Regards,
Brian Strand
CTO Switch Management


