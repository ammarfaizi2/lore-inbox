Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVERS3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVERS3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVERS2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:28:54 -0400
Received: from mail2.dolby.com ([204.156.147.24]:36357 "EHLO dolby.com")
	by vger.kernel.org with ESMTP id S262311AbVERSYR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:24:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Subject: RE: Illegal use of reserved word in system.h
Date: Wed, 18 May 2005 11:23:33 -0700
Message-ID: <2692A548B75777458914AC89297DD7DA08B0866E@bronze.dolby.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Illegal use of reserved word in system.h
Thread-Index: AcVbRKTuz1VVU1T1R9S3/QU8Umw/8gAhp4dQ
From: "Gilbert, John" <JGG@dolby.com>
To: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Sorry about the automatic disclaimer at the bottom of these emails, it's
part of working here at Dolby. I'm sure it doesn't apply to this
discussion.

I had a few responses to this bug fix request (which I did mail to this
list), none were what I was hoping for, namely "This will be fixed in
the next release", so allow me to clarify.

The problem: Linux kernel headers use C++ reserved words as variable
names. This breaks builds of C++ code that include kernel headers.

Examples: The use of "new" in the macro __cmpxchg in system.h. This hits
MySQL which links into the kernel headers to determine if the platform
is SMP aware or not (don't ask me why.) 
	The use of "virtual" in the structure drm_buf_map in drm.h, used
by drm_bufs.c. This hits C++ code that uses the DRI interface to lock
with vertical retrace.

The solution: rename these variables, keep C++ reserved words out of
headers, make this practice part of the style guide.

I'm not advocating writing parts of the kernel in C++, or cleaning out
reserved words in the entire kernel. I know the one and only true
language is C, but for Linux to achieve world domination it needs to be
inclusive at running (and building) any software in whatever language.

As to the comments stating that "Userspace code shouldn't include kernel
headers", that's fine in the "Hello, World", but in the real world,
applications need access to devices and system resources, which means
communicating with the kernel with the proper ioctls, flags, system
configuration, data structures, etc., which are kept in kernel headers.
For this reason, breaking these apart from the application build
environment is a really bad idea, no mater what Linus Torvalds has to
say about it (see
http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html). It needs to
be an fully integrated system for everything to run correctly.

Besides, I don't have time to rewrite MySQL in C to make it "correct".
I've got more important things to do. ;^)

So please, keep your headers clean.

John Gilbert
jgg@dolby.com

Ignore the sig.
###############

-----------------------------------------
This message (including any attachments) may contain confidential
information intended for a specific individual and purpose.  If you are not
the intended recipient, delete this message.  If you are not the intended
recipient, disclosing, copying, distributing, or taking any action based on
this message is strictly prohibited.

