Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbVIBV4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbVIBV4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVIBV4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:56:14 -0400
Received: from hera.kernel.org ([209.128.68.125]:52383 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161073AbVIBV4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:56:13 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 21:55:54 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <dfahpa$an2$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902214231.GA10230@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1125698154 10979 127.0.0.1 (2 Sep 2005 21:55:54 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 2 Sep 2005 21:55:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050902214231.GA10230@ccure.user-mode-linux.org>
By author:    Jeff Dike <jdike@addtoit.com>
In newsgroup: linux.dev.kernel
> 
> UML really needs something like this, both 1 and 2.  See
> 	http://groups.google.com/group/fa.linux.kernel/browse_thread/thread/34d3c02372861a5c/71816a3c7863ea2b?lnk=st&q=%22jeff+dike%22&rnum=27&hl=en#71816a3c7863ea2b
> for my take on system.h and ptrace.h when a change in the host
> architecture broke the UML build.
> 
> UML takes most of its headers from the underlying arch.  It simplifies
> things since most of the definitions are usable in UML.  I don't have
> to clone and maintain my versions of all the other arch headers.
> 
> OTOH, there are things in those headers which UML can't use, and these
> are eliminated in various ways (undefining them after the include of
> the host arch header, redefining them before the include).  But this
> is a pain.
> 
> It has long been my opinion that splitting headers into userspace
> usable and userspace unusable pieces is the right thing for UML.  Less
> clear for the host arch.
> 
> Your post seems to indicate that there is a non-UML demand for exactly
> this.
> 

There definitely is.  The kernel needs to export its ABI in a way that
userspace (UML, various libcs, etc) can import in a sane manner.  In
addition, the Linux kernel contains a fair bit of
architecture-specific support which go well beyond what one can
typically find in userspace, and it would be nice to have those.

The current linux-libc-headers aren't it, because they have a fair bit
of glibc-centric assumptions in those headers.  That's part of why
klibc doesn't use them.

We should probably also consider the licensing of headers that are
meant to be included into userspace.  Userspace still includes a fair
bit of GPL headers, which is technically not kosher.

	-hpa
