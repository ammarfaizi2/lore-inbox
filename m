Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264479AbSIQSl3>; Tue, 17 Sep 2002 14:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264488AbSIQSl3>; Tue, 17 Sep 2002 14:41:29 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:34209 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S264479AbSIQSl1>; Tue, 17 Sep 2002 14:41:27 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032287359.4588.36.camel@phantasy>
References: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com> 
	<1032250378.969.112.camel@phantasy>  <1032253191.4592.15.camel@phantasy> 
	<1032271821.11913.10.camel@spc9.esa.lanl.gov> 
	<1032287359.4588.36.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Sep 2002 12:42:51 -0600
Message-Id: <1032288171.11907.27.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 12:29, Robert Love wrote:
> On Tue, 2002-09-17 at 10:10, Steven Cole wrote:
> 
> > I booted that so-patched kernel and it got much further than before,
> > up to where syslogd was able to write some stuff to /var/log/messages.
> 
> That is what is happening to me... if you trace when you lockup, its due
> to the printk.  My machines in these cases are only livelocked, I can
> still ping etc.
>  
> > Trace; c011c51b <put_files_struct+bb/d0>
> > Trace; c011d08b <do_exit+35b/370>
> > Trace; c012d67f <do_munmap+11f/130>
> > Trace; c012d6c5 <sys_munmap+35/60>
> > Trace; c010918f <syscall_call+7/b>
> 
> Ugh this looks like the exit path which should not be triggered.
> 
I grabbed the 2.5.35-bk3 patch provided by Jeff Garzik so that I could
test something even more current and applied your patches to that (one
hunk was already there in -bk3).

I ran several of the stack dumps through ksymoops.  Perhaps some of
these might point to something interesting.

Steven

ksymoops 2.4.4 on i686 2.5.35.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

f773df4c c01167a6 c02834a0 f77801c0 c0337f20 c011c4eb c1b0eec0 f7936c60
       f773c000 f773c000 f773c000 f77021a0 c011d05b 00000000 0000a9db f77021a0
       c0122340 f7744760 f78cd2e0 f7744760 f773c000 bffffd08 c0122522 4213030c
Call Trace: [<c01167a6>] [<c011c4eb>] [<c011d05b>] [<c0122340>] [<c0122522>]
   [<c010918f>]
f773df4c c01167a6 c02834a0 f77801c0 c0337f20 c011c4eb c1b0eec0 f7936ee0
       f773c000 f773c000 f773c000 f77021a0 c011d05b c022305b 00000003 bfffea00
       0000001c 00000000 0804b3c8 00000014 00000003 bfffea00 0000001c 4213030c
Call Trace: [<c01167a6>] [<c011c4eb>] [<c011d05b>] [<c022305b>] [<c010918f>]
f7739f4c c01167a6 c02834a0 f77801c0 c0337f20 c011c4eb c1b0eec0 f7936820
       f7738000 f7738000 f7738000 f772a800 c011d05b 00000000 f7738000 bffff7a4
       f7739fb0 0807e210 04000000 42029098 00000000 00000000 00000000 4213030c
Call Trace: [<c01167a6>] [<c011c4eb>] [<c011d05b>] [<c010918f>]
f7789f4c c01167a6 c02834a0 f7c5e760 c0337f20 c011c4eb c1b0eec0 c1b71da0
       f7788000 f7788000 f7788000 f7ea8d60 c011d05b 0000006e 00000000 00000005
       c0222fb0 00000005 f77fa1a0 fffffff7 00000005 bffffb28 c0142fe3 4213030c
Call Trace: [<c01167a6>] [<c011c4eb>] [<c011d05b>] [<c0222fb0>] [<c0142fe3>]
   [<c010918f>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01167a6 <schedule+36/3d0>
Trace; c011c4eb <put_files_struct+bb/d0>
Trace; c011d05b <do_exit+35b/370>
Trace; c0122340 <process_timeout+0/10>
Trace; c0122522 <sys_nanosleep+122/1a0>
Trace; c010918f <syscall_call+7/b>
Trace; c01167a6 <schedule+36/3d0>
Trace; c011c4eb <put_files_struct+bb/d0>
Trace; c011d05b <do_exit+35b/370>
Trace; c022305b <sys_socketcall+13b/200>
Trace; c010918f <syscall_call+7/b>
Trace; c01167a6 <schedule+36/3d0>
Trace; c011c4eb <put_files_struct+bb/d0>
Trace; c011d05b <do_exit+35b/370>
Trace; c010918f <syscall_call+7/b>
Trace; c01167a6 <schedule+36/3d0>
Trace; c011c4eb <put_files_struct+bb/d0>
Trace; c011d05b <do_exit+35b/370>
Trace; c0222fb0 <sys_socketcall+90/200>
Trace; c0142fe3 <sys_write+33/40>
Trace; c010918f <syscall_call+7/b>


1 warning issued.  Results may not be reliable.




