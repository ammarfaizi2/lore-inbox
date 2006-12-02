Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423715AbWLBLvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423715AbWLBLvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162970AbWLBLvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:51:37 -0500
Received: from 1wt.eu ([62.212.114.60]:16901 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1162969AbWLBLvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:51:36 -0500
Date: Sat, 2 Dec 2006 12:51:30 +0100
From: Willy Tarreau <w@1wt.eu>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] missing parenthesis
Message-ID: <20061202115130.GA24090@1wt.eu>
References: <200612011510.58990.m.kozlowski@tuxland.pl> <20061201174035.GA18203@1wt.eu> <200612021200.24989.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612021200.24989.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mariusz,

On Sat, Dec 02, 2006 at 12:00:24PM +0100, Mariusz Kozlowski wrote:
> Hi Willy, 
> 
> > Thanks for your work at fixing all this code. I'm wondering though,
> > given the type of errors, this code should never have been able to
> > build at all, so that means that it might not be used at all.
> 
> Either not used or #ifdef'ed so much that it is rarely build.

OK.

> > As a general rule of thumb, keep in mind that we're not much tempted
> > to fix known unused code, especially if it's unmaintained. The reason
> 
> Maybe dumb question but ... how do I know which parts of code are unused

- #if 0 (or equivalent), except #if DEBUG.
- obviously broken code which is included in files which compile and work
  for you

> and/or unmaintained?

just as I do : check for the maintainer in the files themselves, or in
the MAINTAINERS file. As a rule of thumb, if a file has not changed in
the last 3 years and its maintainer is not one of the active ones you
regularly see posting on LKML, then there are great chances that the
file is unmaintained. In this case, you might find the new maintainer
in the 2.6 port of the same file/driver. Same if the maintainer's
address bounces.

> > is simple : when some code does not work, people who need it often
> > maintain patches in their tree to make it work. When we start changing
> > things there, their patches often apply with rejects. Anyway, *I* am
> > still for a clean kernel because I know that there's nothing more
> > annoying than spending days chasing a bug which we discover was known
> > for years.
> > 
> > So what I can propose you is that we :
> >   - postpone those patches for 2.4.35-pre
> 
> Ok.
> 
> >   - ask maintainers of each of these files if he accepts to fix the
> >     file, because some of them are totally against any such change.
> 
> Ok. Couple of questions:
> 
> - how do we do that?

generally, the core subsystems (network, filesystems, archs, ...) are
still well maintained by people who *really want* to validate the
patches before forwarding them upstream.

> - do I resend each patch to proper maintainer?

Yes, when you can identify them without too much difficulty. For all
network drivers, please send to Jeff Garzik and netdev@vger.kernel.org.
For the rest of the network stuff, use Davem and netdev. Send to Al Viro
for FS. Davem for arch/sparc*, Russell King for arch/arm, Ralf Baechle
for arch/mips*, Paul Mackerras for arch/ppc*, etc... If you find a list
address in the MAINTAINERS file, please CC it too. They're all busy,
so make the question simple enough so that they can quickly reply with
ACK/NACK/QUEUED. Keep me CCed so that you don't have to forward me the
response. Generally, they will reply within one week.

It might seem a bit complicated and heavy, but it's the only way to
get a continued quality support on the whole code.

> - if there is no maintainer then what? (btw. is there any other
> more accurate source of MAINTAINERS for each file in the kernel tree?)

If there's no easily identifiable maintainer anymore, or if some
maintainers don't reply, then it becomes my job.

> - do I have to resend them once more to LKML?

No, not at all. We're not doing administrative and repetitive tasks,
and we can still dig through the list archives for a missing patch :-)
Don't waste your time doing this.

Thanks,
Willy

