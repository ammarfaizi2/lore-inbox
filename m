Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWHXNDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWHXNDw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHXNDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:03:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:63689 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751330AbWHXNDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:03:50 -0400
Date: Thu, 24 Aug 2006 08:03:40 -0500
From: "Serge E. Hallyn" <sergeh@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mimi Zohar <zohar@us.ibm.com>, David Safford <safford@us.ibm.com>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org,
       Serge E Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-ID: <20060824130340.GB15680@sergelap.austin.ibm.com>
References: <20060817230213.GA18786@elf.ucw.cz> <OFA16BD859.1B593DA2-ON852571CE.005FA4FF-852571CE.004BD083@us.ibm.com> <20060824054933.GA1952@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824054933.GA1952@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (pavel@ucw.cz):
> Hi!
> 
> > > > +In normal operation, the system seems to stabilize with a roughly
> > > > +equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most
> > >
> > > So you split processes to three classes (why three?), and
> > > automagically move them between classes based on some rules? (What
> > > rules?)
> > >
> > > Like if I'm UNTRUSTED process, I may not read ~/.ssh/private_key? So
> > > files get this kind of labels, too? And it is "mozilla starts as a
> > > USER, but when it accesses first web page it becomes UNTRUSTED"?
> > 
> > Processes are not moved from one integrity level to another, but are
> > demoted when they read from a lower integrity level object. By
> > definition sockets, are defined as UNTRUSTED, so reading from a
> > socket demotes the process to UNTRUSTED.  (Secrecy is a separate
> > attribute.) In the Mozilla example, /usr/bin/mozilla is defined as
> > SYSTEM, preventing any process with lesser integrity from modifying
> > it.  'level -s' displays the level of the current process or of a
> > given file.  For example,
> > 
> > [zohar@L3X098X ~]$ level -s /usr/bin/mozilla
> > /usr/bin/mozilla
> >         security.slim.level: SYSTEM PUBLIC
> > 
> > Both mozilla and firefox-bin are defined as SYSTEM, as soon as the
> > firefox-bin process opens a socket, the process is demoted to
> > UNTRUSTED.
> > 
> > I hope this answered some of your questions.  We're working on
> > more comprehensive documentation, which we'll post with the next
> > release.
> 
> Do you have examples where this security model stops an attack?
> 
> Both my mail client and my mozilla will be UNTRUSTED (because of
> network connections, right?) -- so mozilla exploit will still be able
> t osee my mail? Not good. And ssh connects to the net, too, so it will
> not even protect my ~/.ssh/private_key ?

I believe it will read your private_key while at a higher level, then
will be demoted when it access the net.

Is that right?

-serge
