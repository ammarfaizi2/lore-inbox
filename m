Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVHJQW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVHJQW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVHJQW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:22:57 -0400
Received: from pop.gmx.de ([213.165.64.20]:34967 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965173AbVHJQW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:22:56 -0400
Date: Wed, 10 Aug 2005 18:22:54 +0200 (MEST)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Chris Wright <chrisw@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org, Robert Wilkens <robw@optonline.net>
MIME-Version: 1.0
References: <11855.1123690475@www37.gmx.net>
Subject: =?ISO-8859-1?Q?Re:_Signal_handling_possibly_wrong?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <23304.1123690974@www36.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > Where, sa_mask is _ignored_ if NODEFER is set. (I now have woken up!).
> > The attached program shows that the sa_mask is indeed ignored when
> > SA_NODEFER is set.
> > 
> > Now the real question is... Is this a bug?
> 
> That's not correct w.r.t. SUSv3.  sa_mask should be always used and
> SA_NODEFER is just whether or not to add that signal in.

Yes.

> SA_NODEFER
>     [XSI] If set and sig is caught, sig shall not be added to the 
>     thread's
>     signal mask on entry to the signal handler unless it is included in
>     sa_mask. Otherwise, sig shall always be added to the thread's signal
>     mask on entry to the signal handler.

It's amazing that this non-conformance was never spotted before.
It seems to go all the way back to kernel 1.0 (when the flag
was known as SA_NOMASK).

I'll get something into the manual pages under BUGS.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  Grab the latest
tarball at ftp://ftp.win.tue.nl/pub/linux-local/manpages/
and grep the source files for 'FIXME'.
