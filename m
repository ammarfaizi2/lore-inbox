Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265184AbUEYWQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265184AbUEYWQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbUEYWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:14:10 -0400
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265164AbUEYWID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:08:03 -0400
Date: Wed, 26 May 2004 00:08:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040525220826.GC1609@elf.ucw.cz>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405121139.58742.rob@landley.net> <20040520134955.GA5215@openzaurus.ucw.cz> <200405251655.43185.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405251655.43185.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > For years now I've wanted to use a sendfile variant to tell the system to
> > > connect two filehandles from userspace.  Not just web servers want to
> > > marshall data from one filehandle into another, things like netcat want
> > > to do it between a pipe and a network connection, and I've wrote a couple
> > > of data dispatcher daemons that wanted to do it between two network
> > > connections.
> > >
> > > Unfortunately, sendfile didn't work generically when I tried it (back
> > > under 2.4).  Would this infrastructure be a step in the right direction
> > > to eliminate gratuitous poll loops (where nobody but me EVER seems to get
> > > the "shutdown just one half of the connection" thing right.  My netcat
> > > can handle "echo 'GET /' | netcat www.slashdot.org 80".  The standard
> > > netcat can't. Yes, I plan to fix the one in busybox eventually...)
> >
> > Ugh. Yes, some syscalls like that were proposed... but to
> > make programming easier, you'd need asynchronous
> > sendfile to help you with programming, right?
> 
> Doesn't asynchronous sendfile has the little problem your process can exit 
> before the sendfile is complete?

Hmm, it has...

> I'm not sure how much of a help it really is, since fork() isn't brain surgery 
> if you want it to be asynchronous, and the lifetime rules are really explicit 
> then.  (With a ps that does thread grouping, this isn't too bad from a 
> clutter standpoint, even.  And you automatically get a SIGCHLD when the 
> sendfile is complete, too...)

Right.

> Of course if the syscall can make the sendfile outlive the process that fired 
> it off, then by all means it sounds good.  I dunno how much extra work that 
> is for the kernel, though.

Well, it would be "interesting" to stop that sendfile then. You could
not kill it etc.

I guess async sendfile is bad idea after all.
								Pavel
-- 
When do you have heart between your knees?
