Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbTBLLqr>; Wed, 12 Feb 2003 06:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTBLLqr>; Wed, 12 Feb 2003 06:46:47 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:17412 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267035AbTBLLqq>;
	Wed, 12 Feb 2003 06:46:46 -0500
Message-Id: <200302121149.GAA01822@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Oleg Drokin <green@namesys.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.60 
In-Reply-To: Your message of "12 Feb 2003 01:11:23 MST."
             <m17kc5yl3o.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Feb 2003 06:49:49 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com said:
> Just for throwing out suggestions, UML can easily avoid using glibc
> altogether as it is already intimate with the system call layer. 

Easily?  As in write my own system call wrappers?  And how is UML intimate
with the system calls, anyway?  It is no more intimate with the host's
system calls than any other app.

It also uses some smaller higher-level pieces of libc (printf early in boot,
readdir et al in hostfs, etc).

> Or it can use the linker to play games with symbol names to move the
> kernel off into it's own separate name space.

Maybe, I'm not expert enough with the linker to do that.

> This sounds like a good opportunity to figure out which makes most
> sense  and future proof UML. 

My current thinking is that I will bundle all the userspace code into a
single object which then gets linked (-r IIRC) against libc.  That should
resolve all libc references, at which point I can link it into the kernel,
and I think there won't be any conflicts.

				Jeff

