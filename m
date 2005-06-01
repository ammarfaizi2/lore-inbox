Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFAIeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFAIeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFAIen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:34:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:59836 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261328AbVFAIel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:34:41 -0400
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601081336.GA6693@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
	 <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	 <20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston>
	 <20050601081336.GA6693@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 18:34:17 +1000
Message-Id: <1117614857.19020.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 10:13 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Why do you need it? Do you initiate suspend without userland asking
> > > you to?
> > 
> > Because there is an existing API, via /dev/apm_bios, and that's all X
> > understands ! And because I've always done that ;)
> 
> Try stopping doing that ;-).

Certainly not short-term. Again, it would be nice to have something
better, but heh, you need to go step by step. I have this big rework
where I re-implement most of the pmac suspend code on top of the generic
code (cleans up a lot of stuff) but I don't want to touch the userland
ABI for now, that would be too much of a chance. And /dev/apm_bios X
notofication stuff seems to actually fix problems for some users.

> [On i386, we do not emulate apm, and it still works. Reason is that we
> switch to other console before suspend, so X has to give up
> framebuffer control, anyway.]

Well, I sort-of work :) I have reported cases of X locking the machine
up under some circumstances. Note that historically, I was not switching
consoles in the pmac PM code, though I'm doing it nowadays.

There are other uses of those "events" in /dev/apm_bios. Some people run
scripts on resume triggered by these for example, etc...

I'd rather not break an existing and relied upon userland interface now,
at least not until we have a well accepted replacement that has been
around for some time.

I do agree however that it may be nice to make the APM emulation code
more generic & shared between architectures. That's something I intend
to look into next. But I would like my current stuff to get in after
2.6.12 is released.

Ben.


