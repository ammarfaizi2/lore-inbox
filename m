Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTF3MwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 08:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTF3MwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 08:52:04 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:47868 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262912AbTF3MwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 08:52:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: rmoser <mlmoser@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Date: Mon, 30 Jun 2003 08:05:59 -0500
X-Mailer: KMail [version 1.2]
References: <200306290257420680.0109B84A@smtp.comcast.net>
In-Reply-To: <200306290257420680.0109B84A@smtp.comcast.net>
MIME-Version: 1.0
Message-Id: <03063008055900.14007@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 June 2003 01:57, rmoser wrote:
> I know I spout a ... wtf?  HTML composing?  *attempts to eliminate*
>
> I know I spout a lot of crap, and wish I could just do it all (can we get
> a "Make a small device driver for virtual hardware in Linux 2.4 and 2.5"
> tutorial up on kernel.org?!), but I think I've got some good ideas.  At
> any rate, the good is kept and the bad is weeded out, right?
>
> Anyhow, I'm thinking still about when reiser4 comes out.  I want to
> convert to it from reiser3.6.  It came to my attention that a user-space
> tool to convert between filesystems is NOT the best way to deal with
> this. Seriously, you'd think it would be, right?  Wrong, IMHO.
>
> You have the filesystem code for every filesystem Linux supports.  It's
> there, in the kernel.  So why maintain a kludgy userspace tool that has
> to be rewritten to understand them all?  I have a better idea.
>
> How about a kernel syscall?  It's possible to do this on a running
> filesystem but it's far too difficult for a start, so let's start with
> unmounted filesystems mmkay?
>
> **** BEGIN WELL STRUCTURED MESSAGE ****
>
> I'm going to go over a method of building into the kernel a filesystem
> conversion suite.  I am first going to go over a brief overrun of the
> concept, then I will draw up a roadmap, and then I will explain why I
> believe this is the best way to solve this problem.
[snip]

Whats wrong with:

	mount old filesystem
	mkfs newfilesystem on different disk
	mount new filesystem
	cd old filesystem
	tar -cfp - . | (cd new_filesystem; tar -xfp -)

Which is what I do.

If I MUST do something more in-place replacement....

	1. backup to tape
	2. backup to tape (never hurts)
	3. verify tape
	4. umount old_filesystem
	5. mkfs new_filesystem (same disk)
	6. mount new_filesystem
	7. restore from tape

A lot longer. but there is no "kludgy userspace tool that has to be
rewritten to understand them all".
