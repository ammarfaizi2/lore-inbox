Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVAJGdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVAJGdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVAJGdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 01:33:43 -0500
Received: from web60604.mail.yahoo.com ([216.109.118.242]:2678 "HELO
	web60604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262115AbVAJGdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 01:33:39 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=sXPKoAKRwJtJrNjIR4tK9KbeGP/PpdWBy3s6iNj0I0dfN5X3JB4rRvYrj1BtxC094z3kr3i3AzWufoC5/3TAbRMCpZ2kczI6ywFBDXsqzyhgbAbLMqQEX+A6IEF9GxxdfSEBLRrRBPbOarpnZ8U6M25HiueaWQbPRvfsV95FgBs=  ;
Message-ID: <20050110063338.40429.qmail@web60604.mail.yahoo.com>
Date: Sun, 9 Jan 2005 22:33:38 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Kernel panic Attempted to kill init while intercepting close syscall
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
    I am intercepting syscall in kernel 2.4.28. While,
I was intercepting close() syscall, I got the
following message:
   Kernel panic: Attempted to kill init !
  I have also attached the code here. What could be
the problem? I am storing files opened in a hash table
and then while a particular file descriptor is closed,
I am calling find_pipe_fd to clean the associated
structure in my hash table.

Thanks,
selva
----------------
void find_pipe_fd(unsigned int fd)
{
	unsigned long tfd, tinode, hashkey;
	unsigned int taccess;
	struct list_head *p, *taskp;
	struct resource *my;
	struct my_process *my_task;

	tfd = (long) fd;
	tinode = getinode(tfd);
	taccess = READACCESS;

	//Evaluate for read access resource descriptor
	hashkey = eval_hashkey(tfd, tinode, taccess);
	printk("\nHash key evaluated..[%ld]",hashkey);
        /* Clean the memory using kmalloc */
}

static int my_sys_close(unsigned int fd)
{
	int ret,err;
	unsigned int tfd = fd;
	MOD_INC_USE_COUNT;

	ret = sys_close_saved(tfd);

	/*Upon successful close find and delete the file
descriptor resource from the hash table */
	
	if (ret == 0)
		find_pipe_fd(tfd);

	
	MOD_DEC_USE_COUNT;

	return ret;
}







		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250
