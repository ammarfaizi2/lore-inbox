Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUCVLUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUCVLUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:20:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29568 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261874AbUCVLUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:20:34 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <Pine.LNX.4.44.0403212109020.826-100000@bigblue.dev.mdolabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Mar 2004 04:20:31 -0700
In-Reply-To: <Pine.LNX.4.44.0403212109020.826-100000@bigblue.dev.mdolabs.com>
Message-ID: <m1ekrldt6o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On 21 Mar 2004, Eric W. Biederman wrote:
> 
> > Davide Libenzi <davidel@xmailserver.org> writes:
> > 
> > > > Actually there is...  You don't do the copy until an actual write occurs.
> > > > Some files are opened read/write when there is simply the chance they
> might
> 
> > > > be written to so delaying the copy is generally a win.
> > > 
> > > What about open+mmap?
> > 
> > The case is nothing really different from having a hole in your file.
> > 
> > There are two pieces to implementing this.  First you create separate
> > page cache  entries for the cow file and it's original, so the
> > laziness of mmapped file writes will not bite you..  Second you make
> > aops -> writepage trigger the actual copy of the file, and have it
> > return -ENOSPC if you can't do the copy.
> 
> There has been a misunderstanding. I thought you were talking about a 
> userspace solution ala fl-cow. Of course if you are inside the kernel you 
> can catch both explicit writes and page syncs.

Right.  Although there is nothing prevent the copy to be in user space
even with the trigger hooks down in the write path.

The nice features of having the hook at that point in the kernel are:
1) No new failure modes for user space to worry about.
2) With cow directory support instant fs level check pointing is achieved.

Eric
