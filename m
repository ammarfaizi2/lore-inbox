Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTJATQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTJATQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:16:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:60291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261946AbTJATQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:16:04 -0400
Date: Wed, 1 Oct 2003 12:15:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: sys_vserver
Message-ID: <20031001121536.J14398@osdlab.pdx.osdl.net>
References: <20031001115127.A14425@osdlab.pdx.osdl.net> <Pine.LNX.4.44.0310011454530.19538-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0310011454530.19538-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Wed, Oct 01, 2003 at 02:58:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> On Wed, 1 Oct 2003, Chris Wright wrote:
> 
> > Multiplexing, future functionality, etc...this reasoning was shot down
> > before. The preferred method was to have well-typed interfaces that 
> > are simple and not overloaded.  Any chance some of these needs could be
> > met with existing infrastructure in 2.6?  For example, similar to the
> > sys_new_s_context issue was resolved for LSM with the /proc/pid/attr/
> > interface, could this be reused?
> 
> OK, a few comments here:
> 
> 1) the vserver functionality definately is not "future functionality",
>    people have been using it in production for a few years already

Sorry, I don't mean to imply core vserver is all new, just reacting to
one of the justifciations being "people are planning future
functionality."

> 2) currently vserver only runs on 2.4 (and I think 2.2), it hasn't
>    been ported to 2.6 yet and I definately plan to port it in such
>    a way that we will be reusing other infrastructure whereever
>    possible ... it's just that vserver needs some infrastructure
>    that is not possible inside LSM
> 
> 3) the needs that can be met with existing infrastructure, like
>    CLONE_NEWNS or LSM should definately move out of the vserver
>    patch in the port to 2.6

Glad to hear it.  I haven't looked closely at vserver since about 2.4.14,
but I had hoped to find ways to minimize the vserver patch by reusing
some of the LSM infrastructure.  The biggest issue was the ability to
virtualize the results of something like the hostname to be ctx
specific, which was deemed too much to do for the LSM interfaces.

> 4) I'm all for generalising the interface, how about sys_virtual_context ?

I _think_ this can be done with /proc/[pid]/attr/.  This allows you to
set the security attributes of a process.  IIRC, the sys_s_new_context
was something helpers would run before execve'ing a process into the new
context (sorry if my details are off).  Same can be acheived with
/proc/[pid]/attr/exec, but writing the new context to that file, then
execve'ing.  Here's a link with more details on the API:

http://mail.wirex.com/pipermail/linux-security-module/2003-April/4264.html       
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
