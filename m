Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311463AbSCNBIL>; Wed, 13 Mar 2002 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311462AbSCNBIC>; Wed, 13 Mar 2002 20:08:02 -0500
Received: from rj.sgi.com ([204.94.215.100]:15273 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311461AbSCNBHp>;
	Wed, 13 Mar 2002 20:07:45 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Anton Blanchard <anton@samba.org>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile 
In-Reply-To: Your message of "Wed, 13 Mar 2002 13:44:43 -0800."
             <3C8FC84B.1060704@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Mar 2002 12:07:15 +1100
Message-ID: <27361.1016068035@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002 13:44:43 -0800, 
Dave Hansen <haveblue@us.ibm.com> wrote:
>The final linking stage in the makefile looks like this:
>
>vmlinux: piggy.o $(OBJECTS)
>	$(LD) $(ZLINKFLAGS) -o vmlinux $(OBJECTS) piggy.o
>
>If we link in chunks, we can parallelize this.
>Image 26 object files: [a-z].o
>
>ld -r -o abcd.o [abcd].o
>ld -r -o efgh.o [efgh].o
>...
>ld -r -o abcdefgh.o {abcd,efgh,...}.o
>
>then, instead of the old final link stage:
>$(LD) $(ZLINKFLAGS) -o vmlinux {abcdefgh,...}.o piggy.o
>
>The final link will still take a while, but we will have at least broken 
>up SOME of the work.  I'm going to see if this will actually work now. 
>Any comments?

I'm sorry Dave, you can't do that ;) The init_call order is controlled
by link order, change the link order and you corrupt the kernel
initialization order, double plus ungood.  The link of vmlinux requires
that $(OBJECTS) be exactly as coded.

