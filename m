Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVAFJbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVAFJbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVAFJaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:30:16 -0500
Received: from web60604.mail.yahoo.com ([216.109.118.242]:48275 "HELO
	web60604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262793AbVAFJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:28:55 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=Ui+qlv67z5lb/gS/xzYxY+Wnab5j72b+z8yUnMizTlfW2A/ruS2t54SELS8+C418Z2v1TrQBTjAPnpT8RDtYa5K1muGLyBi7ebgAikrOSibCI0Z7hqpFbIUsNM+KE/OEU9s8GD2PwSQTlGR0z5dSXSiDqSGV0DRG6D7tonNRsjQ=  ;
Message-ID: <20050106092854.32803.qmail@web60604.mail.yahoo.com>
Date: Thu, 6 Jan 2005 01:28:54 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Completing syscall operations on module exit
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernelexperts,
  I am intercepting system calls in kernel 2.4.28. I
have implemented it as a kernel module. In my pipe
syscall implementation, I am storing the file
descriptors created in a linked list structure using
kernel linked list interface. (<linux/list.h>) and I
am printing the list in the exit module portion.
  Now, It stores all descriptors created in the linked
list. While unloading, my module will restore the
original syscall pointer. 
   But if I rmmod the module, the last entry is
missing. It is not added into the list. What could be
the problem?
I think while my syscall is executing, rmmod stops it
and redirects it to the original sycall. How can I
rewrite my exit module to ensure that it will also
record the last descriptor created?

Regards,
selva

void __exit exit_sched(void)
{
	extern long sys_call_table[];
	//struct my_process *temp = NULL, *freetemp = NULL;
	struct my_process *my;
	struct list_head *p;

	/* better put back the real sys call !*/
	sys_call_table[__NR_pipe] = (unsigned
long)sys_pipe_saved;
	sys_call_table[__NR_close] = (unsigned long)
sys_close_saved;
	printk("\n Writing Pipe Access Details for every
process..");
	printk("\n ProcessID,ReadEnd,WriteEnd");

	list_for_each(p,&proinit.list)	{
		my = list_entry(p, struct my_process, list);
		printk("\n%ld,", my -> pid);
		printk("%d,",  my -> pipe_read_end);
		printk("%d",  my -> pipe_write_end);
	}

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
