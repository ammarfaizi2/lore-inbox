Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUCCJA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUCCJA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:00:26 -0500
Received: from web20910.mail.yahoo.com ([216.136.226.232]:58893 "HELO
	web20910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261449AbUCCJAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:00:15 -0500
Message-ID: <20040303090013.44688.qmail@web20910.mail.yahoo.com>
Date: Wed, 3 Mar 2004 01:00:13 -0800 (PST)
From: Anonymous <anon78344@yahoo.com>
Subject: Re: init dies after reboot
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0403021145150.489@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the other hand, I've made a strace on "/sbin/init
U" for example, wich is supposed to restart the init
process. On a slack box with init running I got: 


execve("/sbin/init", ["/sbin/init", "U"], [/* 28 vars
*/]) = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
geteuid32()                             = 0
getuid32()                              = 0
getegid32()                             = 0
getgid32()                              = 0
brk(0)                                  = 0x80bb000
brk(0x80bc000)                          = 0x80bc000
umask(022)                              = 022
geteuid32()                             = 0
getpid()                                = 2509
rt_sigaction(SIGALRM, {0x8048980, [], 0x4000000},
NULL, 8) = 0
alarm(3)                                = 0
open("/dev/initctl", O_WRONLY)          = 3
write(3,
"i\31\t\3\1\0\0\0U\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
384) = 384
close(3)                                = 0
alarm(0)                                = 3
semget(IPC_PRIVATE, 0, 0)

...and init is restarted

And on a slack box *without* init I got:

execve("/sbin/init", ["/sbin/init", "u"], [/* 28 vars
*/]) = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
geteuid32()                             = 0
getuid32()                              = 0
getegid32()                             = 0
getgid32()                              = 0
brk(0)                                  = 0x80baeb4
brk(0x80bbeb4)                          = 0x80bbeb4
brk(0x80bc000)                          = 0x80bc000
umask(022)                              = 022
geteuid32()                             = 0
getpid()                                = 23212
rt_sigaction(SIGALRM, {0x8048980, [], 0x4000000},
NULL, 8) = 0
alarm(3)                                = 0
open("/dev/initctl", O_WRONLY)          = 3
write(3,
"i\31\t\3\1\0\0\0u\0\0\0\5\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
384) = 384
close(3)                                = 0
alarm(0)                                = 3
semget(IPC_PRIVATE, 0, 0)               = -1 ENOSYS
(Function not implemented)
_exit(0)                                = ?

...and, of course init is not restarted...

i still don't have more clues...:-/


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> On Tue, 2 Mar 2004, Anonymous wrote:
> 
> > Hello
> >
> > I encountered a strange problem, and i'm not sure
> that
> > it originates or not in the kernel.
> > the probl. is that on many slack boxes init dies
> after
> > some time, but the OS is still up and running.
> > if I 'ps aux' the machine,no init, and /proc/1
> doesn't
> > exist.
> > although, `lsof | grep init` shows:init          1
> > root  cwd    DIR        8,3        472         2 /
> > init          1   root  rtd    DIR        8,3
> > 472         2 /
> > init          1   root  txt    REG        8,3
> > 468916     15607 /sbin/init
> > init          1   root    0r   CHR        1,3
> >        5659 /dev/null
> > init          1   root    1u   CHR        1,3
> >        5659 /dev/null
> > init          1   root    2u   CHR        1,3
> >        5659 /dev/null
> > init          1   root   10u  FIFO        8,3
> >      137774 /dev/initctl
> >
> >
> > Any kind of ideea?
> >
> > Thanks,
> > Uwe Bower
> 
> The kernel will never send a signal 9 to init.
> However, it can
> send many other signals. If the signal handler in
> init got
> corrupt from a buffer overrun, bad memory, etc.,
> it's quite
> possible for init to die. When it dies, it would
> usually
> die as a result of a seg-fault. You can observe
> /proc/1/cwd to
> see where init lives. There may be a core-file in
> that directory.
> The core-file might be able to give you a hint.
> Also, somebody
> who has su privs can `cp /dev/random /dev/initctl`
> with some
> interesting results.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine
> (797.90 BogoMips).
>             Note 96.31% of all statistics are
> fiction.
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
