Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJTLB1>; Sun, 20 Oct 2002 07:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbSJTLB1>; Sun, 20 Oct 2002 07:01:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:65293 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261645AbSJTLB1>;
	Sun, 20 Oct 2002 07:01:27 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: longjmp/setjmp in kernel
In-reply-to: Your message of "Sun, 20 Oct 2002 11:31:35 +0100."
             <20021020113135.A25278@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Oct 2002 21:07:20 +1000
Message-ID: <23470.1035112040@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002 11:31:35 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>For instance, one of my patches - the rdunzip one.  It would be _really_
>nice to get some feedback on it; it isn't perfect, because the behaviour
>of gunzip is inherently undeterministic when given bad input data.  The
>only real solution IMHO is setjmp/longjmp, which I think would suck in
>the kernel.  I would have expected _this_ to attract some comments from
>people like you.  Maybe you feel that setjmp/longjmp is an approprate
>solution.  Unfortunately, I don't know that because no one has replied
>to tell me so.

Why should setjmp/longjmp suck in kernel?  I use it in kdb to recover
from debugging errors and to quit large amounts of output without
overloading every bit of debugging code with checks for "has the user
typed q?".  It meant I had to write/modify setjmp/longjmp code to work in
the kernel for i386 and ia64, no big deal.

Given the kernel model, there are few places where setjmp/longjmp make
sense.  If the code takes locks, disables interrupts etc. then forget
setjmp, cleanup after longjmp is too messy.  But if you want to recover
from unexpected events in a large body of code which does not take
locks then it is a valid use for longjmp, especially if the code
requires several levels of function calls and you want to bail out from
a low level function.

