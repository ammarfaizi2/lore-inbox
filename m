Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUANGkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 01:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUANGkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 01:40:46 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:38801 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S263679AbUANGkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 01:40:42 -0500
Message-ID: <40057E9E.1000705@sedal.usyd.edu.au>
Date: Thu, 15 Jan 2004 04:38:38 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Nuno Silva <nuno.silva@vgertech.com>, Robin Holt <holt@sgi.com>
Subject: The Difference in Load Average calculations in linux 2.4.19 and 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please can anyone who has written/define Load Average confirm the following statement.


"If there is only 1 CPU in the box, then the Load Average Calculations are going to be almost same in
2.6 and 2.4"


In 2.6 Linux kernel

static unsigned long count_active_tasks <http://lxr.linux.no/ident?v=2.6.0;i=count_active_tasks>(void)
 {
         return (nr_running <http://lxr.linux.no/ident?v=2.6.0;i=nr_running>() + nr_uninterruptible <http://lxr.linux.no/ident?v=2.6.0;i=nr_uninterruptible>()) * FIXED_1 <http://lxr.linux.no/ident?v=2.6.0;i=FIXED_1>;
 }
 
In 2.4 linux kernel
static unsigned long count_active_tasks <http://lxr.linux.no/ident?v=2.4.19;i=count_active_tasks>(void)
 {
         struct task_struct <http://lxr.linux.no/ident?v=2.4.19;i=task_struct> *p <http://lxr.linux.no/ident?v=2.4.19;i=p>;
         unsigned long nr <http://lxr.linux.no/ident?v=2.4.19;i=nr> = 0;
 
         read_lock <http://lxr.linux.no/ident?v=2.4.19;i=read_lock>(&tasklist_lock <http://lxr.linux.no/ident?v=2.4.19;i=tasklist_lock>);
         for_each_task <http://lxr.linux.no/ident?v=2.4.19;i=for_each_task>(p <http://lxr.linux.no/ident?v=2.4.19;i=p>) {
                 if ((p <http://lxr.linux.no/ident?v=2.4.19;i=p>->state <http://lxr.linux.no/ident?v=2.4.19;i=state> == TASK_RUNNING <http://lxr.linux.no/ident?v=2.4.19;i=TASK_RUNNING> ||
                      (p <http://lxr.linux.no/ident?v=2.4.19;i=p>->state <http://lxr.linux.no/ident?v=2.4.19;i=state> & TASK_UNINTERRUPTIBLE <http://lxr.linux.no/ident?v=2.4.19;i=TASK_UNINTERRUPTIBLE>)))
                         nr <http://lxr.linux.no/ident?v=2.4.19;i=nr> += FIXED_1 <http://lxr.linux.no/ident?v=2.4.19;i=FIXED_1>;
         }
         read_unlock <http://lxr.linux.no/ident?v=2.4.19;i=read_unlock>(&tasklist_lock <http://lxr.linux.no/ident?v=2.4.19;i=tasklist_lock>);
         return nr <http://lxr.linux.no/ident?v=2.4.19;i=nr>;
 }


Thanks
Sena Seneviratne
Computer Engineering Lab
Sydney University


