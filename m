Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUCVFLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUCVFLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:11:51 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:65408 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261719AbUCVFLp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:11:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 21 Mar 2004 21:11:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
In-Reply-To: <m1ad298o6b.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.44.0403212109020.826-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2004, Eric W. Biederman wrote:

> Davide Libenzi <davidel@xmailserver.org> writes:
> 
> > > Actually there is...  You don't do the copy until an actual write occurs.
> > > Some files are opened read/write when there is simply the chance they might
> > > be written to so delaying the copy is generally a win.
> > 
> > What about open+mmap?
> 
> The case is nothing really different from having a hole in your file.
> 
> There are two pieces to implementing this.  First you create separate
> page cache  entries for the cow file and it's original, so the
> laziness of mmapped file writes will not bite you..  Second you make
> aops -> writepage trigger the actual copy of the file, and have it
> return -ENOSPC if you can't do the copy.

There has been a misunderstanding. I thought you were talking about a 
userspace solution ala fl-cow. Of course if you are inside the kernel you 
can catch both explicit writes and page syncs.



- Davide


