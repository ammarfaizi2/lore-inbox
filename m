Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSEQGlZ>; Fri, 17 May 2002 02:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSEQGlY>; Fri, 17 May 2002 02:41:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36619 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315438AbSEQGlY>;
	Fri, 17 May 2002 02:41:24 -0400
Message-ID: <3CE4A6CD.75039761@zip.com.au>
Date: Thu, 16 May 2002 23:44:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ghozlane Toumi <ghoz@sympatico.ca>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: Your message of "Thu, 16 May 2002 21:50:16 MST."
	             <3CE48C08.B0E59851@zip.com.au> <E178aAR-00020W-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3CE48C08.B0E59851@zip.com.au> you write:
> > Some explanation of how this works, and of why I should not fill
> > your ear with toothpaste would be appreciated here.
> 
> When an include file is found using "-I dir", __FILE__ in that include
> file is "dir/filename":
> 
> gcc -D__KERNEL__ -I/usr/src/working-2.5.15-bug/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=delay  -c -o delay.o delay.c
> 
> Hope that helps,

It would help if you told us whether you're using a toolchain which
combines strings across .o files.

Presumably, you're not.  So the space savings which you're seeing
are due to lessening the bloat which is caused by the inline functions
in headers which expand BUG().   Which is what out_of_line_bug() does too.
Assuming the toolchain fixes that for us in 2.5, you've gone and added
zillions of function names to the kernel image.

-
