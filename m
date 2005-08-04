Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVHDWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVHDWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDWQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:16:47 -0400
Received: from [203.171.93.254] ([203.171.93.254]:42134 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262774AbVHDWQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:16:33 -0400
Subject: Re: [PATCH 0/23] reboot-fixes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050804214520.GF1780@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	 <20050727025923.7baa38c9.akpm@osdl.org>
	 <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	 <20050727104123.7938477a.akpm@osdl.org>
	 <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
	 <20050727224711.GA6671@elf.ucw.cz> <20050727155118.6d67d48e.akpm@osdl.org>
	 <20050727225442.GD6529@elf.ucw.cz> <1123125850.948.9.camel@localhost>
	 <20050804214520.GF1780@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123193791.9025.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 05 Aug 2005 08:16:31 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-08-05 at 07:45, Pavel Machek wrote:
> Hi!
> 
> > > > >  > Good question.  I'm not certain if Pavel intended to add
> > > > >  > device_suspend(PMSG_FREEZE) to the reboot path.  It was
> > > > >  > there in only one instance.  Pavel comments talk only about
> > > > >  > the suspend path.
> > > > > 
> > > > >  Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
> > > > 
> > > > Why?
> > > 
> > > Many bioses are broken; if you leave hardware active during reboot,
> > > they'll hang during reboot. It is so common problem that I think that
> > > only sane solution is make hardware quiet before reboot.
> > 
> > Sorry for my slow reply.
> > 
> > If I remember correctly PMSG_FREEZE was intended solely for stopping
> > activity when suspend to disk implementations are about to do their
> 
> Well, I think that PMSG_FREEZE can be handy when we want to stop
> activity for other reasons, too...
> 
> > atomic copies. I thought that ide reacts to this message by putting a
> > hold on queues, but doesn't otherwise do anything to prepare a drive for
> > a restart. If that's true, using FREEZE here isn't going to stop drives
> > from doing their emergency shutdown actions. Don't we need PMSG_SUSPEND
> > instead?
> 
> Spinning disk down is not neccessary for reboot. Users will be angry
> if we do it before reboot...

Yes, but I understood (perhaps wrongly) that we were discussing the
shutdown path. Nevertheless, for rebooting, you don't want to simply
freeze the queue - you want to flush the queue and tell the drive to
flush too. For freeze, you may well flush the queue, but you might not
necessarily force the drive to flush its queue too.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

