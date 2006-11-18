Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754606AbWKRVoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbWKRVoU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbWKRVoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:44:19 -0500
Received: from raven.upol.cz ([158.194.120.4]:35284 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1754606AbWKRVoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:44:19 -0500
Date: Sat, 18 Nov 2006 21:51:17 +0000
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Folkert van Heusden <folkert@vanheusden.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Message-ID: <20061118215117.GA15686@flower.upol.cz>
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz> <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com> <20061118023832.GG13827@flower.upol.cz> <Pine.LNX.4.61.0611182029150.10940@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0611182029150.10940@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 08:30:02PM +0100, Jan Engelhardt wrote:
> 
> On Nov 18 2006 02:38, Oleg Verych wrote:
> >On Sat, Nov 18, 2006 at 03:04:13AM +0100, Folkert van Heusden wrote:
> >> > > > I found that sometimes processes disappear on some heavily used system
> >> > > > of mine without any logging. So I've written a patch against 2.6.18.2
> >> > > > which emits logging when a process emits a fatal signal.
> >> > > Why not to patch default signal handlers in glibc, to have not only
> >> > > stderr, but syslog, or /dev/kmsg copy of fatal messages?
> >> > Afaik when a proces gets shot because of a segfault, also the libraries
> >> > it used are shot so to say. iirc some of the more fatal signals are
> >> > handled directly by the kernel.
> >
> >Kernel sends signals, no doubt.
> >
> >Then, who you think prints that "Killed" or "Segmentation fault"
> >messages in *stderr*?
> >[Hint: libc's default signal handler (man 2 signal).]
> 
> 
> Please enlighten us on how you plan to catch the uncatchable SIGKILL.

Here's question of getting information. Collecting information is
possible by `waitpid()' from parent process as Miquel noted.

That man above, gave me impression, that SIG_DFL can not be changed in
case of KILL and STOP signals, what yields to "The signals SIGKILL and
SIGSTOP cannot be caught or ignored." Implementation of such no-action
can be different. In case if kernel just stops processing of task with
STOP, breaks with KILL, without giving a chance to flush any pending data
OK, if this is an assembler prorgam with just data segment and no
infrastructure at all. But i think (didn't read anything), it is bad, if
there's libc with standard stream I/O buffers and no callback is possible.

> 
> 	-`J'
> -- 
