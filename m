Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTETUIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTETUIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:08:41 -0400
Received: from [208.186.192.194] ([208.186.192.194]:50049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261180AbTETUIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:08:39 -0400
Message-Id: <200305202021.h4KKLUT32174@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: re-aim - 2.5.69, -mm6 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Tue, 20 May 2003 12:51:40 PDT." <20030520125140.16f5cb46.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 May 2003 13:21:30 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> >  This is the result of running the Reaim test against the 
> >  2.5.69 and 2.5.69-mm6 kernels. The -mm kernels are a bit
> >  slower, and i'm wondering if i'm missing a tuning knob somewhere..
> >  advice appreciated.
> 
> I can look into the slowdown.  Could you please tell me exactly how you are
> invoking the benchmark?  Show me what commands you're using, so I can do
> exactly the same thing.

For these runs, i'm using the STP wrap.sh - you can get that kit from stp cvs 
if you need.
The wrap.sh does the disk setup and a few other things,then invokes the test. 

The two runs are done like this -> (4 cpu machine)
./reaim -s4 -x -t -i4 -f workfile.new_dbase -r3 -b -lstp.config -> for the 
maxjobs convergence
./reaim -s4 -q -t -i4 -f workfile.new_dbase -r3 -b -lstp.config -> for the 
'quick' convergence

stp.config has the poolsizes and path for disk directories:
FILESIZE 80k
POOLSIZE 1024k
DISKDIR /mnt/disk1
DISKDIR /mnt/disk2
DISKDIR /mnt/disk3
DISKDIR /mnt/disk4

Options: 
the -b surpresseses stdout and creates an html version of the report. - this 
is for STP and
not necessary. 
the -r3 runs the test three times
-t turns off the adaptive increment

cliffw

> 
> >  Attempting a second pass of -mm7 caused the hang reported earlier. 
> 
> I have a bad feeling I won't be able to reproduce this.  If you could
> capture the output from a sysrq-T (or "echo t > /proc/sysrq-trigger") then
> that would help a lot.
> 
> It could be a hole in the new dynamic request allocation code, or a driver
> problem.  Or something else.
> 


