Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTFCQSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFCQSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:18:01 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41265 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265080AbTFCQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:17:59 -0400
Date: Tue, 3 Jun 2003 12:31:24 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sys_lookup_dcookie on s390
Message-ID: <20030603123124.A10799@devserv.devel.redhat.com>
References: <OFB6EC5BCF.26B6C560-ONC1256D3A.0030FEB2@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFB6EC5BCF.26B6C560-ONC1256D3A.0030FEB2@de.ibm.com>; from schwidefsky@de.ibm.com on Tue, Jun 03, 2003 at 11:22:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
> Date: Tue, 3 Jun 2003 11:22:32 +0200

> > Are you going to assign a number for lookup_dcookie? If yes, when?
> 
> You can use 110 for lookup_dcookie (reusing i386 specific iopl number that
> have always been unused for s390). Never came around porting the oprofile
> stuff to s390. Do you plan to do it ?

I am going to use it with timer profiling at first.
It is essentially zero effort port, just add the syscall
and config.in entry.

Still, do you have a suggestion for any other interrupt?
For instance, on i386 it can use NMI. It is my understanding
(perhaps incorrect), that using other interrupt can
a) increase precision, if HZ is low, but other interrupt can
fire more often, b) reduce overhead. Also, sometimes you can
do tricks, if hardware allows it. On sparc, for instance,
you can redefine __local_cli() in such a way that all interrupts
would be closed except the profiling interrupt. Then, the
profiler gathers data about people sitting on spinlocks, etc.
This is what I am looking for, but I'm not sufficiently versed
in the architecture for decide if we have a suitable interrupt
source.

-- Pete
