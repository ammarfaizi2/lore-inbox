Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUFIU5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUFIU5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUFIU43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:56:29 -0400
Received: from mail.inter-page.com ([12.5.23.93]:23057 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S265985AbUFIUyC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:54:02 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Jesse Pollard'" <jesse@cats-chateau.net>,
       "'Ingo Molnar'" <mingo@elte.hu>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Wed, 9 Jun 2004 13:53:16 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAdFYhVEbxb0Kgbx4hvCgIkQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <04060911530500.08612@tabby>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which is why I, later in the same message, wrote:

Architecturally the easy-application-accessible switch should be something more than
a syscall to prevent a return-address-twiddle invoking the call directly.  I'd make
it a /proc/self something, or put it in a separate include-only-if-used shared
library or something.  If the minimal distance is opening and writing a
normally-untouched file then you get a nice support matrix.  (e.g. no file means no
feature, file plus action means executable stack, no action means system default (old
can, new cannot), hacks would require a variable (fd) and executing arbitrary code to
open and write that file, programs/programmers that want/need the old behavior can
achieve it without having to know how to manipulate their ELF headers or tool-chains,
etc.)

Which is not susceptible to the 1-2 attack you mention below because the open and
write cannot be done on a protected stack or heap, since it would then have to be
(er... ) executed to perform the hack.

Ahhhh, yes...

-----Original Message-----
From: Jesse Pollard [mailto:jesse@cats-chateau.net] 
Sent: Wednesday, June 09, 2004 9:53 AM
To: Robert White; 'Ingo Molnar'; 'Christoph Hellwig'; 'Mike McCormack';
linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2

On Tuesday 08 June 2004 16:50, Robert White wrote:
> I would think that having an easy call to disable the NX modification would
> be both safe and effective.  That is, adding a syscall (or whatever) that
> would let you mark your heap and/or stack executable while leaving the new
> default as NX, is "just as safe" as flagging the executable in the first
> place.

ahhhh no.

The first attack against a vulerable server  would be to load a string
on the stack that would:
1. have address of the syscall to turn off NX, then return to the stack.
2. have normal worm/virus code following.



