Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268364AbSIRUmd>; Wed, 18 Sep 2002 16:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbSIRUmd>; Wed, 18 Sep 2002 16:42:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33507 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268364AbSIRUmc>; Wed, 18 Sep 2002 16:42:32 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209182047.g8IKl6T27992@eng2.beaverton.ibm.com>
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Wed, 18 Sep 2002 13:47:06 -0700 (PDT)
Cc: bcrl@redhat.com (Benjamin LaHaise), pbadari@us.ibm.com (Badari Pulavarty),
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <200209181630.g8IGUGe15097@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Sep 18, 2002 08:30:16 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

aio_read/aio_write() are now working with a minor fix to fs/aio.c

io_submit_one():
	
	if (likely(EIOCBQUEUED == ret))

		needs to be changed to

	if (likely(-EIOCBQUEUED == ret))
		  ^^^


I was wondering what happens to following case (I think this
happend in my test program).

Lets say, I did an sys_io_submit() and my test program did exit().
When the IO complete happend, it tried to do following and got
an OOPS in aio_complete().

	if (ctx == &ctx->mm->default_kioctx) { 

I think "mm" is freed up, when process exited. Do you think this is
possible ?  How do we handle this ?

- Badari
