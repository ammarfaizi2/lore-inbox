Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311405AbSCSQIo>; Tue, 19 Mar 2002 11:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311406AbSCSQIZ>; Tue, 19 Mar 2002 11:08:25 -0500
Received: from smtp.polymtl.ca ([132.207.4.11]:48308 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S311405AbSCSQIU>;
	Tue, 19 Mar 2002 11:08:20 -0500
Message-ID: <3C976267.71756479@polymtl.ca>
Date: Tue, 19 Mar 2002 11:08:07 -0500
From: Christian Robert <christian.robert@polymtl.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to run kernel 2.4.18  it panic at boot
In-Reply-To: <3C96C714.E6967570@polymtl.ca> <20020319085943.B4750@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
> On Tue, Mar 19, 2002 at 12:05:24AM -0500, Christian Robert wrote:
> 
> > My root "/"       is on /dev/hde2  Maxstor 60 Gigs disk on Promise ATA/100 ide controller (2.01 build 27)
> > my boot "/boot"   is on /dev/hda1
> > NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> > FAT: bogus logical sector size 0
> > FAT: bogus logical sector size 0
> > and here it goes wrong, I type it from a piece of paper since it has not started to log to file and
> > even ctrl-Page-Up is not working (machine completely jammed). I removed some leading zeroes.
> >
> > invalid operand: 0000
> > CPU: 0
> > EIP:  0010: [<c012dcdc>] not tainted
> 
> In ideal world you'd lookup this EIP value (And also all values from back trace
> in your System.map file (either by ksymoops program or by hand).
> 
> Also double check you have reiserfs compiled into your kernel.
> 
> Bye,
>     Oleg

I have reiserfs, but no hpfs partitions ( but yes, it is compiled in the kernel )

here the trace you rightly suggested me to produce:

EIP:
c012dcdc    00000000c012dc8c t grow_buffers

Call Trace:

c012c17b    00000000c012c154 T getblk
c012c358    00000000c012c340 T bread
c0182d0c    00000000c0182cb8 T hpfs_unlock_3inodes
c018ba6d    00000000c018b910 T hpfs_read_super
c012e739    00000000c012e700 t insert_super
c012ea8b    00000000c012ea34 t read_super
c010e770    00000000c010e4bc T schedule
c011b727    00000000c011b69c T flush_scheduled_tasks
c0105160    00000000c010510c t prepare_namespace
c0105254    00000000c0105248 t init
c0105688    00000000c0105660 T kernel_thread

my next step will be to recompile kernel without "hpfs" to see if it help.
 
Xtian.
