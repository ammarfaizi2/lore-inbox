Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEHQqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEHQqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:46:04 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:53412 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP id S261858AbTEHQqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:46:03 -0400
Message-ID: <002501c31583$3f49b500$0305a8c0@arch.sel.sony.com>
From: "Ming Lei" <lei.ming@attbi.com>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: <linux-kernel@vger.kernel.org>
References: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com> <20030508094321.GH1469@wohnheim.fh-wedel.de>
Subject: Re: linux rt priority  thread corrupt  global variable?
Date: Thu, 8 May 2003 09:59:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anyone know about  how Intel x86 debug register monitor the write
access to a specified mem address? I looked the gdb code and found only the
process VM address of the variable to be watched is writen to the debug
register. Does it mean that x86 debug register only watchs the VM address? I
want to know if Intel hardware watchs the real physical address or VM
address or CPU cache? where can I find this info? I didnt find it in intel
manual.


> > a program has 3 threads of priority 12, 10, 6 respectively, and the main
> > process at priority 0. All the threads except main process is created
with
> > pthread_create, and defined SCHED_FIFO as real time scheduler policy.
> >
> > There is a global variable I define with 'int cpl'. All the threads and
main
> > process may alter cpl at any time. cpl may have one of these values {0,
> > 0xf000006e, 0xf0000068, 0xe0000000, 0xe0000060}. cpl is protected by
mutex
> > for any access.
> >
> > <Problem=> at some point of execution which cpl should be a value say
> > e0000060, but the actual value retained at cpl is another say e0000000;
that
> > is, the value is changed without the program actually done anything on
it.
> > The retained value I observed is kind of historic value(one of these
value
> > in the above set), not the arbituary value. The problem had occured just
> > after context switch, also occured during a thread execution.
> >
> > <Confirm> I used Intel debug register to track any writing to the cpl
memory
> > address globally, which is the way GDB use for x86 hardware watchpoint
> > implementation. I could see all the writing from my program to change
cpl,
> > but failed to see the source from which the problem occured. So I dont
know
> > what cause the problem.
> >
> > Can anyone listening give me a direction or hint on this annoying
situation?
>
> Sounds a bit like a caching problem. Old value in cache, new value
> written to memory, chache line dirty => flushed, old value written to
> memory again. But it could also be something else.

