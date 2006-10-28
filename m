Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJ1Erl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJ1Erl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWJ1Erl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:47:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750863AbWJ1Erk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:47:40 -0400
Date: Fri, 27 Oct 2006 21:47:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2 - process_session-helper breaks /sbin/killall5
Message-Id: <20061027214734.baf647cf.akpm@osdl.org>
In-Reply-To: <200610280318.k9S3Ie72012885@turing-police.cc.vt.edu>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<200610280318.k9S3Ie72012885@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 23:18:39 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Fri, 20 Oct 2006 01:56:41 PDT, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> 
> > +add-process_session-helper-routine.patch
> > +add-process_session-helper-routine-deprecate-old-field.patch
> > +add-process_session-helper-routine-deprecate-old-field-tidy.patch
> > +add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
> > +add-process_session-helper-routine-deprecate-old-field-fix-warnings-2.patch
> > +rename-struct-namespace-to-struct-mnt_namespace.patch
> > +add-an-identifier-to-nsproxy.patch
> > +rename-struct-pspace-to-struct-pid_namespace.patch
> > +add-pid_namespace-to-nsproxy.patch
> > +use-current-nsproxy-pid_ns.patch
> > +add-child-reaper-to-pid_namespace.patch
> > 
> >  Start work on virtualising process sessions.
> 
> Sorry for the delay in spotting this one sooner (and I'm surprised apparently
> nobody else has).  Was busy, didn't get a chance to bisect it at all till
> today, and I only got as far as "one of the above patches".
> 
> System works fine, except when you go to shutdown.  When it hits the /sbin/killall5
> call in /etc/init.d/halt, it kills *all* the processes, and we get a
> nice message 'INIT: no more processes in current runlevel', and we're dead in
> the water.  Checking with alt-sysrg-T shows that in fact, the only things
> left running are the various kernel threads.  As near as I can tell, killall5
> wasn't able to tell that its parent process was part of its process group,
> so didn't refrain from killing it.
> 
> Any ideas/clues?

did you apply the hotfixes?
