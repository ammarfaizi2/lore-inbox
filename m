Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265614AbTF2Jsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbTF2Jsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 05:48:38 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:37761 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265614AbTF2Jsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 05:48:37 -0400
Date: Sun, 29 Jun 2003 11:11:26 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Apart from the special case of converting from one major version of a
filesystem to another major version of the same filesystem, I think
the performance of an on-the-fly filesystem conversion utility is
going to be so much worse than just creating a new partition and
copying the data across, that the only reason to do it would be if you
could do it on a read-write filesystem without unmounting it.

What I'd like to see is union mounts which allowed you to mount a new
filesystem of a different type over the original one, and have all new
writes go to the new fileystem.  I.E. as files were modified, they
would be re-written to the new FS.  That would be one way of avoiding
the performance hit on a busy server.

John.
