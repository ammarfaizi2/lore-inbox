Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTJAWwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTJAWwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:52:51 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:45767 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262598AbTJAWwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:52:49 -0400
Date: Thu, 2 Oct 2003 00:52:48 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Chris Wright <chrisw@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, torvalds@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, vserver@solucorp.qc.ca
Subject: Re: [vserver] Re: sys_vserver
Message-ID: <20031001225247.GA26496@DUK2.13thfloor.at>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Rik van Riel <riel@redhat.com>, torvalds@osdl.org, greg@kroah.com,
	linux-kernel@vger.kernel.org, vserver@solucorp.qc.ca
References: <20031001115127.A14425@osdlab.pdx.osdl.net> <Pine.LNX.4.44.0310011454530.19538-100000@chimarrao.boston.redhat.com> <20031001121536.J14398@osdlab.pdx.osdl.net> <20031001194747.GA24632@DUK2.13thfloor.at> <20031001141654.N14398@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001141654.N14398@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 02:16:54PM -0700, Chris Wright wrote:
> * Herbert Poetzl (herbert@13thfloor.at) wrote:
> > 
> > one of the advantages the current _and_ future vserver project
> > has over 'changing/setting some features for a process' is the
> > concept of a context layer, residing between kernel and processes
> > _belonging_ to a context ...
> 
> Yes, I agree, this is a useful abstraction.
> 
> > you could, for example set up a context which allows a maximum
> > of 10 processes, limited to one ethernet interface, using it's
> > own root/user quota, start some 'virtual' server in this context
> > doing all this init stuff, and then visit this context from
> > outside, via a simple 'context' change ... if you've got the
> > right capabilities/permissions ...
> > 
> > I can not imagine how you would do that with the /proc/<pid>/attr/
> > interface, but I'm sure you can explain it to me ...
> 
> Put it this way, typical security modules have a notion of a
> context, and the ability to grant/deny actions base on the context.
> The /proc/<pid>/attr interface is how you can set/retrieve the context
> per process, and subsequent fork/exec's can chose how to propagate
> that context.  I believe a reasonable portion of vserver can become a
> security module, but there would clearly remain a need for some of the
> virtualization (e.g. hostname, etc.).

hmm, okay I see it now clearly, we should take
the approach which was so successful for scsi ...

echo "vserver add-new-vserver 100 0 1 192 0 0 1" >/proc/1/attr/new

and of course to 'change' the context, a simple

echo "vserver change-to-old-context 100" >/proc/self/attr/migrate
(and it was never seen again, because it vanished in context 100)

will be sufficient ...

seriously I am completely on your side if we talk about
limiting a process or changing it's environment, even
if we talk about setting a class assignment, but I just 
don't believe it's the perfect solution for everything ...

best,
Herbert

> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
