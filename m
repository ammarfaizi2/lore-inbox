Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWHWCqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWHWCqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 22:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWHWCqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 22:46:46 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:7574 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932315AbWHWCqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 22:46:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=e/aX+/qxI+hnFmd+joXcDqhFKK8XALKU+JCqxv9mAxsh2+hAJEq0e4Woq4Zky2jctRWlaz6Khm8g2HFHJ/SlC54y9MuuxW3Ssgo47A+OZwUWGQX8bFHY6VbCq/+B8AXUjvFlqsUD/VBLnweyD7qYSJRoOL8WoDp8YzsvTOtyIkU=
Date: Tue, 22 Aug 2006 19:46:34 -0700
From: Clay Barnes <clay.barnes@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Mahoney <jeffm@suse.com>, David Masover <ninja@slaphack.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap
	searching
Message-ID: <20060823024634.GK9112@HAL_5000D.tc.ph.cox.net>
References: <44EB1484.2040502@suse.com> <44EB23D9.9000508@slaphack.com>
	<44EB28EC.50802@suse.com> <44EB684C.2090206@slaphack.com>
	<44EB7518.5010204@suse.com> <20060822171133.72692542.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822171133.72692542.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:11 Tue 22 Aug     , Andrew Morton wrote:
> 
> I can see that the bigalloc code as-is is pretty sad, but this is a scary
> patch.  It has the potential to cause people significant performance
> problems way, way ahead in the future.
> 
> For example, suppose userspace is growing two files concurrently.  It could
> be that the bigalloc code would cause one file's allocation cursor to
> repeatedly jump far away from the second.  ie: a beneficial side-effect. 
> Without bigalloc that side-effect is lost and the two files blocks end up
> all intermingled.
Perhaps I mis-recall, but shouldn't delayed writes (or something along 
those lines) cause a case where two files are being incrementally
written rare?  It seems that this case would only occur if two processes
were writing two files in small chunks and calling fsync constantly
(*cough* evolution column resizing bug *cough*), PLUS the two would
have to have the same offset (or close) for the file writes.

It seems that the risk of fragmentation is a lesser danger than the full
system near lock-up caused by the old behavour.


--Clay
> 
> I don't know if that scenario is realistic, but I bet there are similar
> accidental oddities which can occur as a result of this change.
> 
> But what are they?
