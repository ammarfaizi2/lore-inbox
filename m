Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUAPFOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUAPFOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:14:15 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:33229 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265270AbUAPFON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:14:13 -0500
Date: Thu, 15 Jan 2004 21:14:02 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115211402.04c5c2c4.pj@sgi.com>
In-Reply-To: <20040115181525.GA31086@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I give, Joe.  Given the several details that are better with your
solution, I endorse your solution, with the couple of minor edits you
have in the pipeline.

It pains me to see the minor code growth (parsing went from 391 bytes
of machine code to 625), with non-trivial code duplication of the
simple_stroull() routine, and admitted increase in code complexity.

But, yes, better bits than bytes, better not to alloca(), and
better using existing bitops than misplaced arch dependencies.

And better you than me ... tag - you're it <grin>.

Bonus question:

  Should any of the other inline routines in include/bitmap.h
  be moved to your new file lib/bitmap.c?

  Others have commented that too much stuff is marked inline,
  and this might be such a case.

  For example, I count about a dozen copies of bitmask_empty(),
  mostly as cpus_empty(), in various generic and i386 files,
  each one worth perhaps 80 bytes of kernel text space.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
