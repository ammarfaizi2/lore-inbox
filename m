Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVA2TTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVA2TTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVA2TQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:16:16 -0500
Received: from web61304.mail.yahoo.com ([216.155.196.147]:46161 "HELO
	web61304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261557AbVA2TNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:13:04 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=wVnOgX+h9Rlb7c0tfd9oi5AI2qDK1ZPvqk1yPkZ/hS92WV6K/QOywrquVEOQP3x8M3eIP3kKIzS57PflGbyR7l4CdkE22S1YrlrbxXiL8zanGhWm+DTLzGBbpVXXY0hJ1BStTrBVbv4Sr2bvgnkNFpIfCRLNUMIQAcINbJRUKGQ=  ;
Message-ID: <20050129191303.84247.qmail@web61304.mail.yahoo.com>
Date: Sat, 29 Jan 2005 11:13:03 -0800 (PST)
From: Jed Brazos <j_brazos@yahoo.com>
Subject: How do I  get a list of all pids on 2.6? (what's wrong with this code)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I'm trying to list all of the tasks and their
children. (Im using a 2.6.5-7 kernel)

  The code below does not list all of the pids as
compared to the /proc entries.

  Why does the following code not list all of the
active pids in the system?

please cc this id.

  -----------------------




void list_pids(void)
{
    struct task_struct *tp;
    struct list_head   *_p;
    struct list_head   *_n;
    struct task_struct *p;


    read_lock(&tasklist_lock);
    for (tp = &init_task;  (tp = next_task(tp)) !=
&init_task; ) {
         printk("[parent]  pid =%d    \n" ,tp->pid );
         list_for_each_safe(_p,_n, &tp->children ){
             p = list_entry(_p,struct
task_struct,sibling);
             printk("   [child]  pid =%d   \n", p->pid
);

         }
    }
    read_unlock(&tasklist_lock);
 return ;
}





		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
