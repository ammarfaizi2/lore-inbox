Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVALBpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVALBpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVALBpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:45:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44259 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262994AbVALBp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:45:29 -0500
Date: Tue, 11 Jan 2005 20:36:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andries Brouwer <aebr@win.tue.nl>,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
Message-ID: <20050111223641.GA27100@logos.cnet>
References: <20050111235907.GG2760@pclin040.win.tue.nl> <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost> <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 05:18:16PM -0800, David Lang wrote:
> On Wed, 12 Jan 2005, Jesper Juhl wrote:
> 
> >On Wed, 12 Jan 2005, Andries Brouwer wrote:
> >
> >>On Tue, Jan 11, 2005 at 02:51:27PM -0800, Barry K. Nathan wrote:
> >>>On Sat, Jan 08, 2005 at 10:46:19AM -0800, Linus Torvalds wrote:
> >>>>Another issue is likely that we should make the whole "uselib()"
> >>>>interfaces configurable. I don't think modern binaries use it (where
> >>>>"modern" probably means "compiled within the last 8 years" ;).
> >>
> >>libc 5.4.46 is from 1998-06-21 or so, glibc 2.0.5 from 1997-08-25 or so.
> >>
> >>>+config SYS_USELIB
> >>>+	bool "sys_uselib syscall support (needed for old binaries)"
> >>>+	---help---
> >>>+	  Many old binaries (e.g. dynamically linked a.out binaries, and
> >>>+	  ELF binaries that are dynamically linked against libc5), require
> >>>+	  the sys_uselib syscall. However, on the typical Linux system, this
> >>>+	  code is just old cruft that no longer serves a purpose.
> >>>+
> >>>+	  If you are unsure, say "N" if you care more about security and
> >>>+	  trimming bloat, or say "Y" if you care more about compatibility
> >>>+	  with old software. (If you will answer "Y" or "M" to BINFMT_AOUT,
> >>>+	  below, you probably should answer "Y" here.)
> >>
> >>s/sys_uselib/uselib/
> >>The system call is uselib().
> >>
> >>Hmm - old cruft.. Why insult your users?
> >>I do not have source for Maple. And my xmaple binary works just fine.
> >>But it is a libc4 binary.
> >>
> >>You mean "on the typical recently installed Linux system, with nothing
> >>but the usual Linux utilities".
> >>
> >>People always claim that Linux is good in preserving binary compatibility.
> >>Don't know how true that was, but introducing such config options doesnt
> >>help.
> >>
> >>Let me also mutter about something else.
> >>In principle configuration options are evil. Nobody wants fifty thousand
> >>configuration options. But I see them multiply like ioctls.
> >>There should be a significant gain in having a config option.
> >>
> >I don't have much to say exceppt express my agreement. That is so very
> >true.
> >The less config options the user is presented with the better, and for
> >each config option there should be a very good reason. Very much agreed.
> >
> >
> >>Maybe some argue that there is a gain in security here. Perhaps.
> >>Or a gain in memory. It is negligible.
> >>I see mostly a loss.
> >>
> >>There are more ancient system calls, like old_stat and oldolduname.
> >>Do we want separate options for each system call that is obsoleted?
> >>
> >IMO, no, we do not.
> 
> how about something like the embedded, experimental, and broken options. 
> that way normal users can disable all of them at a stroke, people who need 
> them can add them in.

Thats just not an option - you would have zillions of config options. 

Moreover this is a system call, and the system call interface is one of the few 
supposed to be stable. You shouldnt simply assume that "no one will ever use sys_uselib()" - 
there might be programs out there who use it.

I agree with Andries.

