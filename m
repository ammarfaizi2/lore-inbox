Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSAHPXl>; Tue, 8 Jan 2002 10:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287976AbSAHPXb>; Tue, 8 Jan 2002 10:23:31 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:20230 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S288112AbSAHPXM>; Tue, 8 Jan 2002 10:23:12 -0500
Date: Tue, 8 Jan 2002 09:23:10 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200201081523.JAA05696@tomcat.admin.navo.hpc.mil>
To: Martin.Rode@programmfabrik.de, linux-kernel@vger.kernel.org
Subject: Re: Question about bi-directional pipes.
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> I was just wondering if it is possible under Linux to use popen in a
> bi-directional way? I want to use popen under php and must write _and_
> read from and to the pipe. Some guy at the php mailing list stated that
> this is possible to do with BSD, he wasn't sure about linux.
> 
> If this is a kernel issue and not a glibc one, is there a way to get
> popen work bi-directionally under linux? Say I want a 
> 
> pipe = popen ('somefile', 'w+');
> 
> return a valid pipe. As it is now, popen (at least under php, but I
> think this should be the same), does not return a handle for mode 'w+'.
> It does return a handle only for modes 'r' and 'w'.
> 
> Regards,

It is a convention used to reduce the risk of deadlock between the two
processes. If you are reading from a fd, you can't be writing to the
other (the pipe syscall returns two fds). If both processes attempt read
simultaneously, both sleep forever (unless using select/poll with a timeout).

Pipes were designed for creating one-way communication paths between processes.

It is better to use a domain socket which has better semantics for just
this occurance. Then you can use the accept/send/recv... network functions
which are much better at bi-directional communication.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
