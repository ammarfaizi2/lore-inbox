Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUG1HsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUG1HsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUG1HqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:46:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:52106 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266812AbUG1HLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:51 -0400
Date: Wed, 28 Jul 2004 00:12:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hare@suse.de, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Message-Id: <20040728001207.19723e25.pj@sgi.com>
In-Reply-To: <20040727022826.2c95d8ff.akpm@osdl.org>
References: <40FD23A8.6090409@suse.de>
	<20040725182006.6c6a36df.akpm@osdl.org>
	<4104E421.8080700@suse.de>
	<20040726131807.47816576.akpm@osdl.org>
	<4105FE68.7040506@suse.de>
	<20040727002409.68d49d7c.akpm@osdl.org>
	<41060B62.1060806@suse.de>
	<20040727013427.52d3e5f5.akpm@osdl.org>
	<41061AC0.8000607@suse.de>
	<20040727022826.2c95d8ff.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> We'd allocate the same amount of memory if we were sending
> messages up a socket/pipe to userspace, which is what we should always have
> done, instead of the direct-exec - it's caused tons of trouble.

This touches on a question I have, off-topic to the discussion of
the patch proposed by Hannes.

Doesn't doing a direct-exec have one powerful advantage over sending
some message or kevent to userspace by socket/pipe/d-bus, in that
sending the message requires that there is some userspace code already
running that is competent to receive the message?

Doing the usermodehelper direct-exec _both_ provides the thread context
in which to execute, _and_ the code to be executed.  The alternative
seems to require long running threads, primed and ready to accept
particular events, cluttering up the system.

I will readily grant that this usermodehelper direct kernel exec thing
seems weird as all heck to me.  But I predict that in a couple of weeks
lkml will be seeing a patch from me (the next version of the 'cpuset'
patch I'm working with Simon and Sylvain of Bull) using it -- because
the alternative of a long running, rarely used, user thread just for one
obscure particular event that required user code sucked worse.

Am I missing something?  Are there _always_ better solutions than
usermodehelper's kernel direct-exec?

Or perhaps am I confusing what Andrew was referring to and the various
mechanisms available here in unfortunate ways?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
