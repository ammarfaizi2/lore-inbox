Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269724AbUJAHj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269724AbUJAHj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 03:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269723AbUJAHj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 03:39:57 -0400
Received: from peabody.ximian.com ([130.57.169.10]:27845 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269724AbUJAHjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 03:39:53 -0400
Subject: Re: [patch] inotify: make user visible types portable
From: Robert Love <rml@novell.com>
To: Paul Jackson <pj@sgi.com>
Cc: ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040930234436.097e6dfe.pj@sgi.com>
References: <1096410792.4365.3.camel@vertex>
	 <1096583108.4203.86.camel@betsy.boston.ximian.com>
	 <20040930155704.16d71cec.pj@sgi.com> <1096608925.4803.2.camel@localhost>
	 <20040930234436.097e6dfe.pj@sgi.com>
Content-Type: text/plain
Date: Fri, 01 Oct 2004 03:39:59 -0400
Message-Id: <1096616399.4803.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 23:44 -0700, Paul Jackson wrote:

> I've no doubt you're right here.  But I'm a little confused.
> 
> Are you saying to use __u32 so user code can compile with these kernel
> headers and see your new inotify symbols w/o polluting their name space
> with the non-underscored typedef symbols?

I am saying I have to use __u32, because they are user visible and u32
is not.  Also, the rule is to use __u32.

> I though such use of kernel headers in compiling user code was
> deprecated.  I'd have figured this meant while we might not go out of
> way to break someone already doing it, we wouldn't make any effort, or
> tolerate any ugly as sin __foo names, in order to add to the list of
> symbols so accessible.
> 
> If you have a few minutes more patience, perhaps you could explain
> where my understanding departed from reality.

How else is user-space to know about this structure?

It has always been a no-no for user-space to access __KERNEL__ wrapped
parts of headers, but sharing a header (or at least generating
user-space's version of the header from the kernel header) is the only
way to ensure that both kernel and user-space speak the same language.

And not just structures, but flags, ioctl commands, ...

	Robert Love


