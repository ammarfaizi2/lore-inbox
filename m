Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268037AbUH3NiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268037AbUH3NiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268039AbUH3NiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:38:18 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:18662 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268037AbUH3NiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:38:15 -0400
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.1
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: andersen@codepoet.org, mmazur@kernel.pl
Content-Type: text/plain
Organization: 
Message-Id: <1093873012.431.6998.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Aug 2004 09:36:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen writes:
> On Sun Aug 29, 2004 at 10:32:13PM +0200, Mariusz Mazur wrote:

>> Nothing special, really. One bigger change - on archs that
>> have >1 possible page sizes (PAGE_SIZE definition in asm/page.h)
>> we're now using a call to libc's getpagesize(), so don't count
>> on it being static on archs like ia64.
>
> I really do not like this change.  Since PAGE_SIZE has always
> been a constant, the change you have made is likely to break a
> fair amount of code, basically any code doing stuff like:
>   
>  static int* foo[PAGE_SIZE];
 
SuSE has already done this, so it's nothing new.

> Your change will result in cryptic errors such as
>
>     "error: variable-size type declared outside of any function"
>     "error: storage size of `foo' isn't constant"
 
You'll get a line number too. At least it's a compile-time
error, instead of a quiet data-corrupting run-time error.

> depending on whether the declaration is outside a function or in one.
> I think it would be much better to either
>
>     a) remove PAGE_SIZE or make using it an error somehow,
 
Nope. That breaks more code than necessary.

>     b) make PAGE_SIZE an install time config option
 
Nope. Executables need to run on multiple kernels.

>     c) declare that on architectures such as mips that support 
>        variable PAGE_SIZE values, the libc kernel headers shall
>        always provide the largest fixed size value of PAGE_SIZE

Nope. This is silent data corruption.

You'll break stuff like this:   P_rss *= (PAGE_SIZE/1024);


