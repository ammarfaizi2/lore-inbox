Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUDEUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUDEUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:55:58 -0400
Received: from web40504.mail.yahoo.com ([66.218.78.121]:3893 "HELO
	web40504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263014AbUDEUyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:54:13 -0400
Message-ID: <20040405205412.60071.qmail@web40504.mail.yahoo.com>
Date: Mon, 5 Apr 2004 13:54:12 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: John Stoffel <stoffel@lucent.com>
Cc: Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <16497.48378.82191.330004@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- John Stoffel <stoffel@lucent.com> wrote:
> >>>>> "Sergiy" == Sergiy Lozovsky
> <serge_lozovsky@yahoo.com> writes:
> 
> Sergiy> Basically there are two reasons.
> 
> Sergiy> 1. Give system administrator possibility to
> change security
> Sergiy> policy easy enough without C programminig
> inside the kernel
> Sergiy> (we should not expect system administartor
> to be a kernel
> Sergiy> guru). Language of higher lavel make code
> more compact (C - is
> Sergiy> too low level, that's why people use PERL
> for example or
> Sergiy> LISP). Lisp was chosen because of very
> compact VM - around
> Sergiy> 100K.
> 
> Why in god's name does this need to be in the
> kernel?  This is purely
> a userspace issue, and the tool for managing the
> security policy
> should be completely in userspace.  

UNIX security policy is already implemented in the
Kernel, or should we move checking of root priveleges
and file permissions to the userspace? I just extended
existing security features.

> Under this design, /bin/ls would be a kernel module,
> and not a
> userspace tool!   

No :-) What you suggest is kernel should receive
system call from user space. Instead of handling it -
kernel should forward it back to userspace, than it
should be forwarded back to the kernel. Looks not very
nice to me. Why not to handle security policy inside
the kernel as it is done for the file permissions and
root priveleges?

> Sergiy> 2. Protect system from bugs in security
> policy created by
> Sergiy> system administrator (user).  
> 
> C'mon, GIGO will kill you from user space or from
> kernel space.  What
> makes you think LISP will protect you?  
> 
> Sergiy> LISP interpreter is a LISP Virtual Machine
> (as Java VM). So
> Sergiy> all bugs are incapsulated and don't affect
> kernel.
> 
> Then *WHY* does the LISP interpreter need to be in
> the kernel in the
> first place?  Hint, you just said you wanted to
> protect the kernel...

All LISP errors are incapsulated within LISP VM.
 
> Sergiy> Even severe bugs in this LISP kernel module
> can cause
> Sergiy> termination of user space application only
> (except of stack
> Sergiy> overflow - which I can address). LISP error
> message will be
> Sergiy> printed in the kernel log.
> 
> Hah!  You just gave the number one reason why you
> don't want or need a
> LISP interpreter in the kernel yourself.  

What reason you have in mind? All available security
models have predefined stack usage, so it is
completely safe to use them. 

For those who want to define their security model (not
security policy!) - they shoud respect stack
limitations for now. Which sounds reasonable. Using
existing security models it is impossible to cause
stack overflow. (depth of subroutine calls is
constant).

Serge.

> John
>    John Stoffel - Senior Unix Systems Administrator
> - Lucent Technologies
> 	 stoffel@lucent.com - http://www.lucent.com -
978-952-7548


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
