Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVHDDYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVHDDYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 23:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVHDDYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 23:24:12 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:22919 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261748AbVHDDYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 23:24:11 -0400
Subject: Re: [PATCH 0/23] reboot-fixes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050727225442.GD6529@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	 <20050727025923.7baa38c9.akpm@osdl.org>
	 <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	 <20050727104123.7938477a.akpm@osdl.org>
	 <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	 <20050727224711.GA6671@elf.ucw.cz> <20050727155118.6d67d48e.akpm@osdl.org>
	 <20050727225442.GD6529@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123125850.948.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 04 Aug 2005 13:24:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-07-28 at 08:54, Pavel Machek wrote:
> Hi!
> 
> > >  > Good question.  I'm not certain if Pavel intended to add
> > >  > device_suspend(PMSG_FREEZE) to the reboot path.  It was
> > >  > there in only one instance.  Pavel comments talk only about
> > >  > the suspend path.
> > > 
> > >  Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
> > 
> > Why?
> 
> Many bioses are broken; if you leave hardware active during reboot,
> they'll hang during reboot. It is so common problem that I think that
> only sane solution is make hardware quiet before reboot.

Sorry for my slow reply.

If I remember correctly PMSG_FREEZE was intended solely for stopping
activity when suspend to disk implementations are about to do their
atomic copies. I thought that ide reacts to this message by putting a
hold on queues, but doesn't otherwise do anything to prepare a drive for
a restart. If that's true, using FREEZE here isn't going to stop drives
from doing their emergency shutdown actions. Don't we need PMSG_SUSPEND
instead?

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

