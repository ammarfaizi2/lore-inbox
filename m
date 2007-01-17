Return-Path: <linux-kernel-owner+w=401wt.eu-S1750976AbXAQOmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbXAQOmb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXAQOmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:42:31 -0500
Received: from fe02.tochka.ru ([62.5.255.22]:64138 "EHLO umail.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750976AbXAQOma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:42:30 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 09:42:29 EST
From: Alex Tomas <alex@clusterfs.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: O_DIRECT question
CC: linux-kernel@vger.kernel.org
Date: Wed, 17 Jan 2007 17:27:25 +0300
Message-ID: <m3k5zlu3si.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think one problem with mmap/msync is that they can't maintain
i_size atomically like regular write does. so, one needs to
implement own i_size management in userspace.

thanks, Alex

> Side note: the only reason O_DIRECT exists is because database people are 
> too used to it, because other OS's haven't had enough taste to tell them 
> to do it right, so they've historically hacked their OS to get out of the 
> way.

> As a result, our madvise and/or posix_fadvise interfaces may not be all 
> that strong, because people sadly don't use them that much. It's a sad 
> example of a totally broken interface (O_DIRECT) resulting in better 
> interfaces not getting used, and then not getting as much development 
> effort put into them.

> So O_DIRECT not only is a total disaster from a design standpoint (just 
> look at all the crap it results in), it also indirectly has hurt better 
> interfaces. For example, POSIX_FADV_NOREUSE (which _could_ be a useful and 
> clean interface to make sure we don't pollute memory unnecessarily with 
> cached pages after they are all done) ends up being a no-op ;/

> Sad. And it's one of those self-fulfilling prophecies. Still, I hope some 
> day we can just rip the damn disaster out.
