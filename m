Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUDEUwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUDEUwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:52:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:47113 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262905AbUDEUwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:52:14 -0400
Message-ID: <4071CBD4.9080506@techsource.com>
Date: Mon, 05 Apr 2004 17:12:52 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405175940.94093.qmail@web40509.mail.yahoo.com>
In-Reply-To: <20040405175940.94093.qmail@web40509.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergiy Lozovsky wrote:

> 
> 1. Give system administrator possibility to change
> security policy easy enough without C programminig
> inside the kernel (we should not expect system
> administartor to be a kernel guru). Language of higher
> lavel make code more compact (C - is too low level,
> that's why people use PERL for example or LISP). Lisp
> was chosen because of very compact VM - around 100K.

And you expect your sysadmins to know LISP?  I would hardly think of 
LISP as any kind of simplification to anything.

I mean, I like the language and all, but it is in no way "simpler" than 
C and it's definately not appropriate for in-kernel stuff.

> 
> 2. Protect system from bugs in security policy created
> by system administrator (user). LISP interpreter is a
> LISP Virtual Machine (as Java VM). So all bugs are
> incapsulated and don't affect kernel. Even severe bugs
> in this LISP kernel module can cause termination of
> user space application only (except of stack overflow
> - which I can address). LISP error message will be
> printed in the kernel log.

In theory, we could develop the kernel in a language that does all sorts 
of protection, garbage collection, run-time checking, etc.  Kernel 
developers choose not to because the performance hit would be HORRIBLE.


Now... that doesn't mean you can't do kernel-level stuff in LISP.  You 
just don't do it _in_ the kernel.  Given the absolutely MASSIVE overhead 
you're already incurring by using a LISP interpreter, having to 
context-switch into user space won't hurt in the least.  So, what you do 
is have a C-based stub in the kernel which passes stuff off to the 
user-space LISP daemon which calls back into the kernel for accessing 
devices, etc.

THAT would be a much better way of doing this.

