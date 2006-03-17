Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932764AbWCQU6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbWCQU6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWCQU6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:58:04 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13320 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932769AbWCQU5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:35 -0500
Date: Fri, 17 Mar 2006 21:56:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Phillip Susi <psusi@cfl.rr.com>, Steven Rostedt <rostedt@goodmis.org>,
       Nick Warne <nick@linicks.net>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: chmod 111
Message-ID: <20060317205621.GF21493@w.ods.org>
References: <200603171746.18894.nick@linicks.net> <6f6293f10603171007vbf752e5n8a3d6f2d65e0a1e7@mail.gmail.com> <200603171811.01963.nick@linicks.net> <1142620004.9478.13.camel@localhost.localdomain> <Pine.LNX.4.64.0603171036240.3618@g5.osdl.org> <441B1025.7000708@cfl.rr.com> <Pine.LNX.4.64.0603171202240.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603171202240.3618@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 17, 2006 at 12:11:35PM -0800, Linus Torvalds wrote:
(...) 
> And finally don't get me wrong - you _can_ build up security around the 
> executable bits, but it has to be a lot more involved than just assuming 
> that being unreadable means that nobody can see what a binary does. So for 
> example, you _can_ create a system where you only have a certain subset of 
> binaries that will be run (no debuggers), and where user-supplied binaries 
> simply won't execute (mounting any user-writable area no-exec, and make 
> sure that none of the executable loaders like /lib/ld.so will load a 
> non-exec image).
> 
> But in general, I'd say that is only applicable in some embedded 
> environments (you could have a special chroot'ed jail environment where it 
> could be very hard to read the binaries that you expose in the jail 
> environment, for example). It's not useful in something that gives shell 
> access and allows the user to create his own executable program files.

Personnally, I'm used to limit all permissions to the least needed. And
particularly, no executable except shell scripts have the read permission
for others. I must say that I do this in reduced environments (less than
20 MB root image) where it improves security : when I was a student,
I found it so much useful to simply copy every shell or suid program
to disassemble them or simply try to crash them and dissect their
cores that I know I couldn't have gotten some root priviledges if at
the beginning I could not have had access to this precious information.

Also, during a security audit, I had the opportunity to abuse a web
server to retrieve application executables in which paths and IP
addresses were hard-coded. Once again, this would not have been
possible with a chmod -r.

But users should be aware that information provided under /proc/self
to those binaries is reduced. Bash does not support /dev/stdin and
friends if it is unreadable, because it replaces this with
/proc/self/fd/0 which is unreachable.

That said, I tend to agree with you. Every now and then we see
a /proc or ptrace exploit or something like this which lets you
dump the binary, so chmod -r is not the universal solution to
local attacks.

> 		Linus

Cheers,
Willy

