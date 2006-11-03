Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752951AbWKCCmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbWKCCmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbWKCCmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:42:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:4883 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752988AbWKCCmG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:42:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=btdJhbrVMPw4kqNoZAhYlh5l45+gMd2sbThq+i6UhIYChyLrLj5h0eOZ0PCiFlS8Og11EcpzalKhMv6C29o2ShA0LDETwxHzPKs+9fymiZjBH5N+dR/X5V2KvXLrfZgnsIcwgnPNx30+4jgkx6TDa9L9W9RH4R5ddychQszCWV4=
Message-ID: <aaf959cb0611021842m2a4e73d9w874f6334d4d9a25a@mail.gmail.com>
Date: Fri, 3 Nov 2006 10:42:04 +0800
From: "zhou drangon" <drangon.mail@gmail.com>
To: "Eric Dumazet" <dada1@cosmosbay.com>
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Cc: linux-kernel@vger.kernel.org, "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Oleg Verych" <olecom@flower.upol.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Johann Borck" <johann.borck@densedata.com>, drangon.zhou@gmail.com
In-Reply-To: <4549A261.9010007@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1154985aa0591036@2ka.mipt.ru> <20061101132506.GA6433@2ka.mipt.ru>
	 <20061101160551.GA2598@elf.ucw.cz>
	 <20061101162403.GA29783@2ka.mipt.ru>
	 <slrnekhpbr.2j1.olecom@flower.upol.cz>
	 <20061101185745.GA12440@2ka.mipt.ru>
	 <5c49b0ed0611011812w8813df3p830e44b6e87f09f4@mail.gmail.com>
	 <aaf959cb0611011829k36deda6ahe61bcb9bf8e612e1@mail.gmail.com>
	 <aaf959cb0611011830j1ca3e469tc4a6af3a2a010fa@mail.gmail.com>
	 <4549A261.9010007@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/11/2, Eric Dumazet <dada1@cosmosbay.com>:
> zhou drangon a écrit :
> > performance is great, and we are exciting at the result.
> >
> > I want to know why there can be so much improvement, can we improve
> > epoll too ?
>
> Why did you remove most of CC addresses but lkml ?
> Dont do that please...
I seldom reply to the mailing list, Sorry for this.
>
> Good question :)
>
> Hum, I think I can look into epoll and see how it can be improved (if necessary)
>
I have an other question.
As for the VFS system, when we introduce the AIO machinism, we add aio_read,
aio_write, etc... to file ops, and then we make the read, write op to
call aio_read,
aio_write, so that we only remain one implement in kernel.
Can we do event machinism the same way?
when kevent is robust enough, can we implement epoll/select/io_submit etc...
base on kevent ??
In this way, we can simplified the kernel, and epoll can gain
improvement from kevent.

> This is not to say we dont need kevent ! Please Evgeniy continue your work !
Yes! We are expecting for you greate work.

I create an userland event-driven framework for my application.
but I have to use multiple thread to receive event, epoll to wait most event,
and io_getevent to wait disk AIO event, I hope we can get a universal
event machinism
to make the code elegance.
>
> Just to remind you that according to
> http://www.xmailserver.org/linux-patches/nio-improve.html David Libenzi had to
> wait 18 months before epoll being officialy added into kernel.
>
> At that time, many applications were using epoll, and we were patching our
> kernels for that.
>
>
> I cooked a very simple program (attached in this mail), using pipes and epoll,
> and got 250.000 events received per second on an otherwise lightly loaded
> machine (dual opteron 246 , 2GHz, 1MB cache per cpu) with 10.000 pipes (20.000
> handles)
>
> It could be nice to add support for other event providers in this program
> (AF_INET & AF_UNIX sockets for example), and also add support for kevent, so
> that we really can compare epoll/kevent without a complex setup.
> I should extend the program to also add/remove sources during lifetime, not
> only insert at setup time.
>
> # gcc -O2 -o epoll_pipe_bench epoll_pipe_bench.c -lpthread
> # ulimit -n 1000000
> # epoll_pipe_bench -n 10000
> ^C after a while...
>
> oprofile results say that ep_poll_callback() and sys_epoll_wait() use 20% of
> cpu time.
> Even if we gain a two factor in cpu time or cache usage, we wont eliminate
> other costs...
>
> oprofile results gave :
>
> Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a unit
> mask of 0x00 (No unit mask) count 50000
> samples  %        symbol name
> 2015420  11.1309  ep_poll_callback
> 1867431  10.3136  pipe_writev
> 1791872   9.8963  sys_epoll_wait
> 1357297   7.4962  fget_light
> 1277515   7.0556  pipe_readv
> 998447    5.5143  current_fs_time
> 801597    4.4271  __mark_inode_dirty
> 755268    4.1713  __wake_up
> 587065    3.2423  __write_lock_failed
> 582931    3.2195  system_call
> 297132    1.6410  iov_fault_in_pages_read
> 296136    1.6355  sys_write
> 290106    1.6022  __wake_up_common
> 270692    1.4950  bad_pipe_w
> 261516    1.4443  do_pipe
> 257208    1.4205  tg3_start_xmit_dma_bug
> 254917    1.4079  pipe_poll
> 252925    1.3969  copy_user_generic_c
> 234212    1.2935  generic_pipe_buf_map
> 228659    1.2629  ret_from_sys_call
> 212541    1.1738  sysret_check
> 166529    0.9197  sys_read
> 160038    0.8839  vfs_write
> 151091    0.8345  pipe_ioctl
> 136301    0.7528  file_update_time
> 107173    0.5919  tg3_poll
> 77846     0.4299  ipt_do_table
> 75081     0.4147  schedule
> 73059     0.4035  vfs_read
> 69787     0.3854  get_task_comm
> 63923     0.3530  memcpy
> 60019     0.3315  touch_atime
> 57490     0.3175  eventpoll_release_file
> 56152     0.3101  tg3_write_flush_reg32
> 54468     0.3008  rw_verify_area
> 47833     0.2642  generic_pipe_buf_unmap
> 47777     0.2639  __switch_to
> 44106     0.2436  bad_pipe_r
> 41824     0.2310  proc_nr_files
> 41319     0.2282  pipe_iov_copy_from_user
>
>
> Eric
>
>
>
> /*
>  * How to stress epoll
>  *
>  * This program uses many pipes and two threads.
>  * First we open as many pipes we can. (see ulimit -n)
>  * Then we create a worker thread.
>  * The worker thread will send bytes to random pipes.
>  * The main thread uses epoll to collect ready pipes and read them.
>  * Each second, a number of collected bytes is printed on stderr
>  *
>  * Usage : epoll_bench [-n X]
>  */
> #include <pthread.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/epoll.h>
> #include <signal.h>
> #include <unistd.h>
> #include <sys/time.h>
>
> int nbpipes = 1024;
>
> struct pipefd {
>         int fd[2];
> } *tab;
>
> int epoll_fd;
>
> static int alloc_pipes()
> {
>         int i;
>
>         epoll_fd = epoll_create(nbpipes);
>         if (epoll_fd == -1) {
>                 perror("epoll_create");
>                 return -1;
>         }
>         tab = malloc(sizeof(struct pipefd) * nbpipes);
>         if (tab ==NULL) {
>                 perror("malloc");
>                 return -1;
>         }
>         for (i = 0 ; i < nbpipes ; i++) {
>                         struct epoll_event ev;
>                 if (pipe(tab[i].fd) == -1)
>                         break;
>                 ev.events = EPOLLIN | EPOLLOUT | EPOLLHUP | EPOLLPRI | EPOLLET;
>                 ev.data.u64 = (uint64_t)i;
>                 epoll_ctl(epoll_fd, EPOLL_CTL_ADD, tab[i].fd[0], &ev);
>         }
>         nbpipes = i;
>         printf("%d pipes setup\n", nbpipes);
>         return 0;
> }
>
>
> unsigned long nbhandled;
> static void timer_func()
> {
>         char buffer[32];
>         size_t len;
>         static unsigned long old;
>         unsigned long delta = nbhandled - old;
>         old = nbhandled;
>         len = sprintf(buffer, "%lu\n", delta);
>         write(2, buffer, len);
> }
>
> static void timer_setup()
> {
>         struct itimerval it;
>         struct sigaction sg;
>
>         memset(&sg, 0, sizeof(sg));
>         sg.sa_handler = timer_func;
>         sigaction(SIGALRM, &sg, 0);
>         it.it_interval.tv_sec = 1;
>         it.it_interval.tv_usec = 0;
>         it.it_value.tv_sec = 1;
>         it.it_value.tv_usec = 0;
>         if (setitimer(ITIMER_REAL, &it, 0))
>                 perror("setitimer");
> }
>
> static void * worker_thread_func(void *arg)
> {
>         int fd;
>         char c = 1;
>         for (;;) {
>                 fd = rand() % nbpipes;
>                 write(tab[fd].fd[1], &c, 1);
>         }
> }
>
>
> int main(int argc, char *argv[])
> {
>         char buff[1024];
>         pthread_t tid;
>         int c;
>
>         while ((c = getopt(argc, argv, "n:")) != EOF) {
>                 if (c == 'n') nbpipes = atoi(optarg);
>         }
>         alloc_pipes();
>         pthread_create(&tid, NULL, worker_thread_func, (void *)0);
>         timer_setup();
>
>         for (;;) {
>                 struct epoll_event events[128];
>                 int nb = epoll_wait(epoll_fd, events, 128, 10000);
>                 int i, fd;
>                 for (i = 0 ; i < nb ; i++) {
>                         fd = tab[events[i].data.u64].fd[0];
>                         if (read(fd, buff, 1024) > 0)
>                                 nbhandled++;
>                 }
>         }
> }
>
>
>
