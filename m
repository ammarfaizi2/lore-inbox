Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVAKKtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVAKKtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVAKKtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:49:22 -0500
Received: from web60603.mail.yahoo.com ([216.109.118.223]:18828 "HELO
	web60603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262695AbVAKKtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:49:20 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=AToV3hCN1+dL8dL6oZxLgLnG5Cn2KB5kMA3122iosqF88NcUjEM9eD4IRyLHE1FvFQP4NTtfvnQrEmXlS1oDCWR+lKROSZolnZvNpJ8EPObve9l/P9kTt6tvtiVXkUCV+RmYC1UYCz6QJAN1AuDDPoCEdzJPeJZkwcBSIFs4a9Y=  ;
Message-ID: <20050111104919.64122.qmail@web60603.mail.yahoo.com>
Date: Tue, 11 Jan 2005 02:49:19 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: pipe_wait illustration needed
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-experts,
    I can't understand this function pipe_wait defined
in linux/fs/pipe.c line by line,especially the lines
after add_wait_queue. If the process is added to the
wait queue and schedule() is called then after that a
new process will be selected and will be given the
CPU. So, the current process will be out of the way.
Then, how can the kernel reach the line 
remove_wait_queue. 
    Also, how the scheduler will know that the pipe
event has occurred and it's safe to set the process
state to TASK_RUNNING?

Thanks,
selva
----------------
/* Drop the inode semaphore and wait for a pipe event,
atomically */
void pipe_wait(struct inode * inode)
{
	DECLARE_WAITQUEUE(wait, current);
	current->state = TASK_INTERRUPTIBLE;
	add_wait_queue(PIPE_WAIT(*inode), &wait);
	up(PIPE_SEM(*inode));
	schedule();
	remove_wait_queue(PIPE_WAIT(*inode), &wait);
	current->state = TASK_RUNNING;
	down(PIPE_SEM(*inode));
}


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

