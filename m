Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUGAE7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUGAE7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUGAE7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:59:46 -0400
Received: from lakermmtao02.cox.net ([68.230.240.37]:7390 "EHLO
	lakermmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263971AbUGAE7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:59:38 -0400
In-Reply-To: <20040701041158.GE1564@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Date: Thu, 1 Jul 2004 00:59:36 -0400
To: Jamie Lokier <jamie@shareable.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01, 2004, at 00:11, Jamie Lokier wrote:
> Can you confirm in a simple way that mapping a file, or some anonymous
> memory, without PROT_READ, really isn't writable under MacOS X?  Can
> you confirm it with a word write, if that would be relevant?

I hope I didn't make some stupid mistake in my program, but here it is, 
and
here are my results.  I'll probably go file a bug with Apple now :-D

zeus:~ kylemoffett$ cat >testp.c
#include <sys/types.h>
#include <sys/mman.h>

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/mman.h>

int main(int argc, char **argv) {
         long x = 100;
         void *mem;
         fprintf(stderr,"Starting...\n");
         mem = mmap(0,4096,PROT_WRITE,MAP_ANON|MAP_SHARED,-1,0);
         fprintf(stderr,"Mapped memory!\n");
         if (mem == 0) return 1;
         fprintf(stderr,"Address is %lx\n",(unsigned long)mem);
         ((long *)mem)[1] = x;
         fprintf(stderr,"Done!!!\n");
         return 0;
}
^D
zeus:~ kylemoffett$ gcc testp.c -o testp
zeus:~ kylemoffett$ ./testp
Starting...
Mapped memory!
Address is 4000
Bus error
zeus:~ kylemoffett$

Cheers,
Kyle Moffett

