Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbTLMTZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbTLMTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 14:25:23 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:64139 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S265288AbTLMTZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 14:25:17 -0500
Message-ID: <20031213192516.4897.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "(-> surya <-) " <surya_prabhakar@linuxmail.org>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 14 Dec 2003 00:25:15 +0500
Subject: Re: In fs/proc/array.c error in function proc_pid_stat
X-Originating-Ip: 203.200.54.66
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lee,
   Thx for the reply . Anyway I patched array.c with this patch(available in the lists posted by Marco Roeland )  , it was working fine .
 
rgds
surya
_____________________________________________________________________________________

--- linux-2.6.0-test8/fs/proc/array.c.orig 2003-10-21 16:18:40.000000000 +0200
+++ linux-2.6.0-test8/fs/proc/array.c 2003-10-23 09:30:27.000000000 +0200
@@ -302,6 +302,7 @@
pid_t ppid;
int num_threads = 0;
struct mm_struct *mm;
+ unsigned long long starttime;

state = *get_task_state(task);
vsize = eip = esp = 0;
@@ -343,9 +344,7 @@
read_lock(&tasklist_lock);
ppid = task->pid ? task->real_parent->pid : 0;
read_unlock(&tasklist_lock);
- res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+ res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu ",
task->pid,
task->comm,
state,
@@ -355,7 +354,9 @@
tty_nr,
tty_pgrp,
task->flags,
- task->min_flt,
+ task->min_flt);
+ starttime = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
+ res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu ",
task->cmin_flt,
task->maj_flt,
task->cmaj_flt,
@@ -367,15 +368,15 @@
nice,
num_threads,
jiffies_to_clock_t(task->it_real_value),
- (unsigned long long)
- jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES),
+ starttime,
vsize,
mm ? mm->rss : 0, /* you might want to shift this left 3 */
task->rlim[RLIMIT_RSS].rlim_cur,
mm ? mm->start_code : 0,
mm ? mm->end_code : 0,
mm ? mm->start_stack : 0,
- esp,
+ esp);
+ res += sprintf(buffer + res,"%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
eip,
___________________________________________________________________________________________________



----- Original Message -----
From: William Lee Irwin III <wli@holomorphy.com>
Date: 	Sat, 13 Dec 2003 09:57:17 -0800
To: Surya prabhakar <surya_prabhakar@linuxmail.org>
Subject: Re: In fs/proc/array.c error in function proc_pid_stat

> On Sat, Dec 13, 2003 at 10:51:01PM +0500, Surya prabhakar wrote:
> > Hai all , 
> >     When trying to compile 2.6.0-test11 . I am getting a compile time
> > error as below
> 
> This is a gcc problem fixed in newer gcc versions.
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



rgds
surya

-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
