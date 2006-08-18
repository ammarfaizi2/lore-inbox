Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWHRRln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWHRRln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWHRRlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:41:42 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33999 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751435AbWHRRll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:41:41 -0400
In-Reply-To: <20060817230213.GA18786@elf.ucw.cz>
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
To: Pavel Machek <pavel@ucw.cz>
Cc: David Safford <safford@us.ibm.com>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org,
       Serge E Hallyn <sergeh@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OFA16BD859.1B593DA2-ON852571CE.005FA4FF-852571CE.004BD083@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Fri, 18 Aug 2006 13:41:37 -0400
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 08/18/2006 13:41:38
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek wrote on 08/17/2006 07:02:14 PM:

> Hi!
>
> > Documentation.
>
> No, I still do not understand how this is supposed to work.

Yes, the documentation definitely needs more work.

> > +In normal operation, the system seems to stabilize with a roughly
> > +equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most
>
> So you split processes to three classes (why three?), and
> automagically move them between classes based on some rules? (What
> rules?)
>
> Like if I'm UNTRUSTED process, I may not read ~/.ssh/private_key? So
> files get this kind of labels, too? And it is "mozilla starts as a
> USER, but when it accesses first web page it becomes UNTRUSTED"?

Processes are not moved from one integrity level to another, but are
demoted when they read from a lower integrity level object. By
definition sockets, are defined as UNTRUSTED, so reading from a
socket demotes the process to UNTRUSTED.  (Secrecy is a separate
attribute.) In the Mozilla example, /usr/bin/mozilla is defined as
SYSTEM, preventing any process with lesser integrity from modifying
it.  'level -s' displays the level of the current process or of a
given file.  For example,

[zohar@L3X098X ~]$ level -s /usr/bin/mozilla
/usr/bin/mozilla
        security.slim.level: SYSTEM PUBLIC

Both mozilla and firefox-bin are defined as SYSTEM, as soon as the
firefox-bin process opens a socket, the process is demoted to
UNTRUSTED.

I hope this answered some of your questions.  We're working on
more comprehensive documentation, which we'll post with the next
release.

Mimi Zohar

