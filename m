Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTJATrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJATrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:47:53 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:35527 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262529AbTJATru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:47:50 -0400
Date: Wed, 1 Oct 2003 21:47:47 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Chris Wright <chrisw@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, torvalds@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, vserver@solucorp.qc.ca
Subject: Re: sys_vserver
Message-ID: <20031001194747.GA24632@DUK2.13thfloor.at>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Rik van Riel <riel@redhat.com>, torvalds@osdl.org, greg@kroah.com,
	linux-kernel@vger.kernel.org, vserver@solucorp.qc.ca
References: <20031001115127.A14425@osdlab.pdx.osdl.net> <Pine.LNX.4.44.0310011454530.19538-100000@chimarrao.boston.redhat.com> <20031001121536.J14398@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001121536.J14398@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 12:15:36PM -0700, Chris Wright wrote:
> * Rik van Riel (riel@redhat.com) wrote:
> > On Wed, 1 Oct 2003, Chris Wright wrote:
> > 
> > > Multiplexing, future functionality, etc...this reasoning was shot down
> > > before. The preferred method was to have well-typed interfaces that 
> > > are simple and not overloaded.  Any chance some of these needs could be
> > > met with existing infrastructure in 2.6?  For example, similar to the
> > > sys_new_s_context issue was resolved for LSM with the /proc/pid/attr/
> > > interface, could this be reused?
> > 
> > OK, a few comments here:
> > 
> > 1) the vserver functionality definately is not "future functionality",
> >    people have been using it in production for a few years already
> 
> Sorry, I don't mean to imply core vserver is all new, just reacting to
> one of the justifciations being "people are planning future
> functionality."
> 
> > 2) currently vserver only runs on 2.4 (and I think 2.2), it hasn't
> >    been ported to 2.6 yet and I definately plan to port it in such
> >    a way that we will be reusing other infrastructure whereever
> >    possible ... it's just that vserver needs some infrastructure
> >    that is not possible inside LSM
> > 
> > 3) the needs that can be met with existing infrastructure, like
> >    CLONE_NEWNS or LSM should definately move out of the vserver
> >    patch in the port to 2.6
> 
> Glad to hear it.  I haven't looked closely at vserver since about 2.4.14,
> but I had hoped to find ways to minimize the vserver patch by reusing
> some of the LSM infrastructure.  The biggest issue was the ability to
> virtualize the results of something like the hostname to be ctx
> specific, which was deemed too much to do for the LSM interfaces.
> 
> > 4) I'm all for generalising the interface, how about sys_virtual_context ?
> 
> I _think_ this can be done with /proc/[pid]/attr/.  This allows you to
> set the security attributes of a process.  IIRC, the sys_s_new_context
> was something helpers would run before execve'ing a process into the new
> context (sorry if my details are off).  Same can be acheived with
> /proc/[pid]/attr/exec, but writing the new context to that file, then
> execve'ing.  Here's a link with more details on the API:

one of the advantages the current _and_ future vserver project
has over 'changing/setting some features for a process' is the
concept of a context layer, residing between kernel and processes
_belonging_ to a context ...

you could, for example set up a context which allows a maximum
of 10 processes, limited to one ethernet interface, using it's
own root/user quota, start some 'virtual' server in this context
doing all this init stuff, and then visit this context from
outside, via a simple 'context' change ... if you've got the
right capabilities/permissions ...

I can not imagine how you would do that with the /proc/<pid>/attr/
interface, but I'm sure you can explain it to me ...

best,
Herbert

> http://mail.wirex.com/pipermail/linux-security-module/2003-April/4264.html       
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
