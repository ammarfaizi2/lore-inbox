Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVCGD0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVCGD0v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 22:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCGD0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 22:26:51 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:55200 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261449AbVCGD0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 22:26:48 -0500
Subject: Re: [patch] inotify for 2.6.11
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: hch@infradead.org, rml@novell.com, ttb@tentacle.dhs.org, torvalds@osdl.org
Content-Type: text/plain
Date: Sun, 06 Mar 2005 22:13:51 -0500
Message-Id: <1110165231.1967.16.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Sat, Mar 05, 2005 at 07:40:06PM -0500, Robert Love wrote:
>> On Sun, 2005-03-06 at 00:04 +0000, Christoph Hellwig wrote:
 
>>> The user interface is still bogus.
>>
>> I presume you are talking about the ioctl.  I have tried to engage you
>> and others on what exactly you prefer instead.  I have said that moving
>> to a write interface is fine but I don't see how ut is _any_ better than
>> the ioctl.  Write is less typed, in fact, since we lose the command
>> versus argument delineation.
>> 
>> But if it is a anonymous decision, I'll switch it.  Or take patches. ;-)
>> It isn't a big deal.
>
> See the review I sent.  Write is exactly the right interface for that kind
> of thing.  For comment vs argument either put the number first so we don't
> have the problem of finding a delinator that isn't a valid filename, or
> use '\0' as such.

That's just putrid. You've proposed an interface that
combines the worst of ASCII with the worst of binary.

It is now well-established that ASCII interfaces are
horribly slow. This one will be no exception... but
with the '\0' in there, you have a binary interface.
So, it's an evil hybrid.

An ioctl() is a syscall with scope restricting it to a
single fd. This is a fine user interface, not a bogus one.
(keep 32-on-64 operation in mind to be polite)

If you'd rather have a normal (global) system call though,
that'll do too, likely leading to a bit more type checking
in the glibc-provided headers.

Adding plain old syscalls is rather nice actually.
It's only a pain at first, while waiting for glibc
to catch up.


