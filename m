Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTAOSUv>; Wed, 15 Jan 2003 13:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTAOSUv>; Wed, 15 Jan 2003 13:20:51 -0500
Received: from mailbox.ucsd.edu ([132.239.1.54]:47116 "EHLO mailbox2.ucsd.edu")
	by vger.kernel.org with ESMTP id <S266805AbTAOSUu>;
	Wed, 15 Jan 2003 13:20:50 -0500
Date: Wed, 15 Jan 2003 10:33:56 -0800
To: linux-kernel@vger.kernel.org
Subject: process switch and page directory on INTEL ????
Message-ID: <20030115183356.GA29528@cannon.ucsd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Yang Yang <yangyang@juggler.ucsd.edu>
X-MailScanner: PASSED (v1.2.7 98397 h0FITeoT028230 mailbox2.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC me on answers, I haven't been admitted into this list
yet,thanks)

hi all:
	thank you for reading this, this has puzzled me for quite a
	time.

	I read "INTEL architecture developers' manual", and became
	interested in how process / context switch ( called task switch
	in INTEL doc ) is done in linux, to me , looks like these
	happened:
	1)an interupt gate ( for timer interupt ) directs flow
	  to kernel mode for old process
	
	2) kernel changes EIP,ESP and other registers, load new cr3  for
	   new process 
	
	3) goes into USER mode for new process


	my question is,
	a) for (1) to catch the interrupt, it must know the interrupt
	vector, so it must have an entry in its page directory and page
	table for the IDT, ( and similarly, GDT, TSS .... ) , because
	from intel doc, the IDTR ( and all other descriptor tables,
	registers except cr3 ) use *linear* address instead of physical.
	so , every process,and kernel thread must have a page
	table/directory mapping for the IDT,and that mapping maps to the
	same physical address ? same with GDT,TSS? if this is true, my 
	thought is, in linux, it may well be that light weight process
	solves this----- sharing a page directory/table? but what with
	other OS'es ? they must provide a mapping of IDT for each
	process, because this is determined by hardware.

 	(b) from 1) to 2) , is the page table/directory changed at all?
	    ( if changed, this might be called a "task gate" instead )
	    what paging system does the kernel use ? 


	    thank you all

	    yang
