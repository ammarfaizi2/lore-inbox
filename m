Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTEMVPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTEMVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:15:00 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:9978 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263376AbTEMVO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:14:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Yoav Weiss <ml-lkml@unpatched.org>
Subject: Re: The disappearing sys_call_table export.
Date: Tue, 13 May 2003 16:26:15 -0500
X-Mailer: KMail [version 1.2]
Cc: 76306.1226@compuserve.com, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305131633030.20904-100000@marcellos.corky.net>
In-Reply-To: <Pine.LNX.4.44.0305131633030.20904-100000@marcellos.corky.net>
MIME-Version: 1.0
Message-Id: <03051316261500.20373@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 08:44, Yoav Weiss wrote:
> > > Until linux gets a real encrypted swap (the kind OpenBSD implements),
> > > you can settle for encrypting your whole swap with one random key that
> > > gets lost on reboot.  Encrypted loop dev with a key from /dev/random
> > > easily gives you that.
> >
> > Ahhh not a good idea if you want job restart or suspend/resume. And large
> > systems DO want a job restart... as do laptops. During suspension you can
> > do anything to the disk (as in remove it, insert in another system, read
> > it, then put it back ...)
>
> While I agree with most of what you said in your post, I fail to see the
> problem with this one.  My laptop has encrypted swap and it poses no
> problem when suspending.  The disk can be taken out and read, but its
> encrypted with a random key that exists only in memory so its harder to
> extract.  (and if someone can extract my memory, the swap is the least of
> my concerns).

Not the above - that one is obvious that the key can be compromised.

> Maybe you're talking about hibernation rather than suspension.  (when
> everything is written to disk and the memory is wiped).  In this case,
> again, the encrypted swap's key is the least of your concern since all
> your memory is written to disk plaintext anyway.  If hibernation is
> implemented in software, you can have it encrypted too, and require a
> user-supplied key upon restarting.  If its implemented by the hardware, I
> guess there isn't much you can do.  Just have the kernel do the
> hibernation into an encrypted loopdev and halt the machine.

This one...

Though part of it has to do with large systems and crash. What is done
on some of these systems is to periodically checkpoint batch jobs. If the
kernel crashes, the job has a physical memory failure, a cpu dies (one out
of many...) the system resumes processing (after reboot, or removing the
memory page from the valid list ... whatever recovery method) to then
reload/resume the processes.

If the random key is lost due to a crash, then reload/resume fails.
