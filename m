Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbTJCHhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 03:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTJCHhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 03:37:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21823 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263588AbTJCHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 03:37:12 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andries.Brouwer@cwi.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
	<m17k3nhfex.fsf@ebiederm.dsl.xmission.com>
	<20031002153301.GA2033@win.tue.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Oct 2003 01:36:19 -0600
In-Reply-To: <20031002153301.GA2033@win.tue.nl>
Message-ID: <m13ceahix8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> On Thu, Oct 02, 2003 at 08:39:50AM -0600, Eric W. Biederman wrote:
> 
> > This is a 2.7 project.
> 
> I disagree. This is unrelated to kernel development, just like working
> on sparse is unrelated to kernel development. 

Granted.  The major point is that it requires a development cycle
before it is ready.  Only if this is to be maintained as part of
the kernel is it needed to be 2.7 work.

> > Doing this right requires a lot more
> > than what you are doing here.
> 
> Possibly. So we need discussion.
> 
> I have registered comment #1: Al prefers the enum style.
> A possibility.
> 
> Now you come with comment #2: write LINUX_MS_RDONLY instead of
> MS_RDONLY. You have not convinced me.

My point is that we need to cleanly handle the fact that glibc
defines it's own abi that is not equivalent to the kernel abi.
A linux specific namespace does that.  After libc is done with
the definitions users will still use MS_RDONLY.

Using defines unconditionally in a private namespace is cumbersome.
A better way to go is probably:

linuxabi/features.h
....
#ifdef __USE_LINUX_NS
# define LINUX_NS(X) LINUX_##
#else
# define LINUX_NS(X) X
#endif

.....
linuxabi/mountflags.h
#include <linuxabi/features.h>
enum {
        LINUX_NS(MS_RDONLY) = 1,
	LINUX_NS(MS_NOSUID) = 2,
};

The result being that defines are placed in their own namespace
if necessary to avoid libc/kernel abi differences.

Eric
