Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUDEXuC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbUDEXuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:50:02 -0400
Received: from web40509.mail.yahoo.com ([66.218.78.126]:40602 "HELO
	web40509.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263526AbUDEXt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:49:58 -0400
Message-ID: <20040405234957.69998.qmail@web40509.mail.yahoo.com>
Date: Mon, 5 Apr 2004 16:49:57 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Timothy Miller <miller@techsource.com>
Cc: Chris Wright <chrisw@osdl.org>, John Stoffel <stoffel@lucent.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <4071DC20.6040005@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Timothy Miller <miller@techsource.com> wrote:
> 
> 
> Sergiy Lozovsky wrote:
> 
> > 
> > 
> > LSM use another way of doing similar things :-)
> I'm
> > not sure that it is nice to forward system calls
> back
> > to userspace where they came from in the first
> place
> > :-) VXE use high level language to create security
> > models.
> > 
> 
> "Kernel space -> user space -> kernel space" is

To be more precise "user space -> kernel space -> user
space -> kernel space -> user space" 

against ordinary "user space -> kernel space -> user
space"

So, what happens - task makes system calls and blocks;
request goes to a user space security server. Will it
process request right away? No, it will wait for
scheduler to chose it for execution. Ok server got CPU
and returns results to the kernel. Will initial task
continue? No, it will wait for be chosen by scheduler.
This is what I call overhead (though i understand,
that can be wrong). My system (VXE) doesn't involve
scheduler at all.

So we should not just look into length of this chain
at the picture. - "user space -> kernel space -> user
space -> kernel space -> user space" - we should
remember that it involves to mandatory task switches
to accomplish jus one system call.

> nothing compared to the 
> overhead of a LISP interpreter.

LISP code, is very small actually. And nobody can just
kill it. I know it's not a real protection, but intent
was to place a security system in such place where it
will be more protected by itself. I placed additional
security mechanisms in the place where designers of
UNIX placed theirs (file permissions an so on) - in
the kernel.
 
> Doing interpretation of LISP is a monster compared
> to some piddly 
> context switches.

When people say LISP they mean Common LISP, which is a
monster and I agree with you. VXE uses stripped down
version of LISP and syntax of LISP is far simpler than
C for example.

Serge.


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
