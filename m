Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVHDVvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVHDVvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVHDVr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:47:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29838 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262746AbVHDVrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:47:15 -0400
Date: Thu, 4 Aug 2005 23:45:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/23] reboot-fixes
Message-ID: <20050804214520.GF1780@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> <20050727025923.7baa38c9.akpm@osdl.org> <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> <20050727104123.7938477a.akpm@osdl.org> <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com> <20050727224711.GA6671@elf.ucw.cz> <20050727155118.6d67d48e.akpm@osdl.org> <20050727225442.GD6529@elf.ucw.cz> <1123125850.948.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123125850.948.9.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >  > Good question.  I'm not certain if Pavel intended to add
> > > >  > device_suspend(PMSG_FREEZE) to the reboot path.  It was
> > > >  > there in only one instance.  Pavel comments talk only about
> > > >  > the suspend path.
> > > > 
> > > >  Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
> > > 
> > > Why?
> > 
> > Many bioses are broken; if you leave hardware active during reboot,
> > they'll hang during reboot. It is so common problem that I think that
> > only sane solution is make hardware quiet before reboot.
> 
> Sorry for my slow reply.
> 
> If I remember correctly PMSG_FREEZE was intended solely for stopping
> activity when suspend to disk implementations are about to do their

Well, I think that PMSG_FREEZE can be handy when we want to stop
activity for other reasons, too...

> atomic copies. I thought that ide reacts to this message by putting a
> hold on queues, but doesn't otherwise do anything to prepare a drive for
> a restart. If that's true, using FREEZE here isn't going to stop drives
> from doing their emergency shutdown actions. Don't we need PMSG_SUSPEND
> instead?

Spinning disk down is not neccessary for reboot. Users will be angry
if we do it before reboot...
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
