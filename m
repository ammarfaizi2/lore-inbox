Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbTCKXDa>; Tue, 11 Mar 2003 18:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbTCKXDa>; Tue, 11 Mar 2003 18:03:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:47247 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261652AbTCKXD3>;
	Tue, 11 Mar 2003 18:03:29 -0500
Date: Tue, 11 Mar 2003 15:09:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: george@mvista.com, felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030311150913.20ddb760.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
References: <20030311144448.4d9ee416.akpm@digeo.com>
	<Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2003 23:14:06.0170 (UTC) FILETIME=[E9ACA3A0:01C2E823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> 
> On Tue, 11 Mar 2003, Andrew Morton wrote:
> > 
> > gcc will generate 64bit * 64bit multiplies without resorting to
> > any library code
> 
> However, gcc is unable to do-the-right-thing and generate 32x32->64 
> multiplies, or 32x64->64 multiplies, even though those are both a _lot_ 
> faster than the full 64x64->64 case.

2.95.3 and 3.2.1 seem to do it right?



long a;
long b;
long long c;

void foo(void)
{
	c = a * b;
}



	.file	"t.c"
	.version	"01.01"
gcc2_compiled.:
.text
	.align 4
.globl foo
	.type	 foo,@function
foo:
	pushl %ebp
	movl %esp,%ebp
	movl a,%eax
	imull b,%eax
	movl %eax,c
	cltd
	movl %edx,c+4
.L2:
	movl %ebp,%esp
	popl %ebp
	ret
.Lfe1:
	.size	 foo,.Lfe1-foo
	.comm	a,4,4
	.comm	b,4,4
	.comm	c,8,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"

