Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281458AbRLBQdS>; Sun, 2 Dec 2001 11:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281255AbRLBQbx>; Sun, 2 Dec 2001 11:31:53 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:28935 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S281059AbRLBQb0>; Sun, 2 Dec 2001 11:31:26 -0500
Message-Id: <4.3.2.7.2.20011202110544.00e49cd0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 02 Dec 2001 11:31:20 -0500
To: manu@agat.net
From: David Relson <relson@osagesoftware.com>
Subject: Re: what happened with thread, from 2.2 to 2.4 ?!
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <01120215334302.00742@extasia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:33 AM 12/2/01, you wrote:
>Hi
>what happenned with thread from 2.2 to 2.4?
>I have some problems with threaded programs, working under 2.2 and no more
>under 2.4
>The test program is short:
>----
>#include <stdlib.h>
>void main() {
>   char *t="1.0";
>   double d=0;
>   d=strtod(t,(char **)NULL);
>}
>---
>this program compiled with "gcc -g -lpthread test.c" has strange behaviour.
>The problem only appear using gdb to see the value of d
>In most case, the value returned by strtod under a 2.4 kernel is nan.
>I say most, because some 2.4 kernels don't fail other this line.
>I have done some test with differents distributions, and so differents
>version of kernel, gcc, gdb and libc.
>http://manu.agat.net/bug.html
>
>When it was possible, for the computer with the bug, under an 2.4 kernel,
>I've recompiled a 2.2.20, and the bug has disappeared!
>
>Does someone have an idea about that ?

I verified your problem using 2.4.16 (with gdb-20010813(MI_OUT)) and 
2.2.15pre18 (with gdb-4.18).  Thinking about it, I remembered that in the 
past there have been some problems with newer versions of gdb with threaded 
programs.  So, I tried using gdb-4.18 on 2.4.16 and it worked fine.

Methinks that this looks like a gdb issue.

As further testing I added a couple of statements after the strtod() call:
         printf( "%f\n", d);
         return;

If I step through the program, I see the nan value displayed by gdb and 
also printed by printf().  If I put a breakpoint at the printf() and run 
the program, the proper value is printed out.  This looks a whole lot like 
gdb is having a problem when stepping over the strtod() call.

I will forward a copy of this message to the gdb mailing list.

David

