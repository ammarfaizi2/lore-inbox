Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKAUg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKAUg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKAUg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:36:58 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20368 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751178AbVKAUg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:36:57 -0500
Date: Tue, 1 Nov 2005 12:36:48 -0800
From: Paul Jackson <pj@sgi.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpuset - question
Message-Id: <20051101123648.5743a5cf.pj@sgi.com>
In-Reply-To: <035101c5df17$223eccb0$0400a8c0@dcccs>
References: <035101c5df17$223eccb0$0400a8c0@dcccs>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JaniD++ wrote:
> [root@dy-xeon-1 cpus_0]# /bin/echo 1 > mems
> /bin/echo: write error: Numerical result out of range
> [root@dy-xeon-1 cpus_0]# echo 1 >mems
> [root@dy-xeon-1 cpus_0]# cat mems
> 
> [root@dy-xeon-1 cpus_0]# /bin/echo $$ > tasks
> /bin/echo: write error: No space left on device

I'm guessing you are on a multi-processor, with a single
memory node, not a NUMA system with multiple memory nodes.

Or, at least, your kernel was compiled for that (with the
CONFIG_NUMA option disabled).

The first echo above failed because you tried to set bit 1
in mems, but only bit 0 is valid (only one memory node).

The second echo failed too, but your shells (like most
shells) builtin echo didn't display the error.

The 'cat mems' command showed that mems was not yet set,
which is indeed the case.

The third and final echo above, into 'tasks' failed because
you can't attach a task to a cpuset that has no memory specified.

If you had done '/bin/echo 0 > mems', it would have worked
much better.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
