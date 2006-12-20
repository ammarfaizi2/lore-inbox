Return-Path: <linux-kernel-owner+w=401wt.eu-S964869AbWLTD7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWLTD7s (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWLTD7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:59:48 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:26507 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964871AbWLTD7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:59:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=4UiSrwAOaE+ZZLp4w1Ijnd0W+AjZIPHnX9PDDNT3bgNdeXwGg/rOLgD6hMdWjVYDlOdBT6hWyDsmJfREcl2Z0uR1/2bZ4ILe8bfTanWdFEWXWc/H/i2Kic3cAbtifIpjCKyVc52CWJovm327PZ7mgWkaT/KiUmRpYI0/M2gVNXA=  ;
X-YMail-OSG: YgoX7p8VM1ktTj_F6SOjSWk.Y8.LbN2lPvZExJK70QzNNYttxNo58lav6o1ypEv.6FIPsMlgkzZd4PlxZlxT.zEhcMKwxtCW00o5OuYPT5g5j1EOG_zKkCZZVPY7WbcM1wNsNycajbrv_Y1h2I7cQjiHA1fk.nS_CbVoM82fFiiY2Bo.pRPTT2qgCrJbQSeDsbX0xUsr8NOSqdk-
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Changes to PM layer break userspace
Date: Tue, 19 Dec 2006 19:59:42 -0800
User-Agent: KMail/1.7.1
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612191334.49760.david-b@pacbell.net> <20061220002546.GA17378@srcf.ucam.org>
In-Reply-To: <20061220002546.GA17378@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612191959.43019.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 4:25 pm, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 01:34:49PM -0800, David Brownell wrote:
> 
> > Documentation/feature-removal-schedule.txt has warned about this since
> > August, and the PM list has discussed how broken that model is numerous
> > times over the past several years.  (I'm pretty sure that discussion has
> > leaked out to LKML on occasion.)  It shouldn't be news today.
> 
> 1) feature-removal-schedule.txt says that it'll be removed in July 2007. 
> This isn't July 2007.

Which is why the functionality is still there.


> 2) The functionality was disabled in 2.6.19. The addition to 
> feature-removal-schedule.txt was in, uh, 2.6.19.

Please respond to the technical explanation I provided, and stop
referring to the functionality ** which is still there and works **
as being disabled.

The fact that PCI exposes a mechanism that conflicts with that is
a separate issue.

Whining does not help.

I can't help it if that schedule.txt patch took until 2.6.19 to get
upstream; ISTR it was available before 2.6.18 shipped.  Maybe patches
to that file should be accelerated, even into the stable series.

 
> 3) "The whole _point_ of a kernel is to act as a abstraction layer and 
> resource management between user programs and hardware/outside world. 
> That's why kernels _exist_. Breaking user-land API's is thus by 
> definition something totally idiotic.
> 
> If you need to break something, you create a new interface, and try to 
> translate between the two, and maybe you deprecate the old one so that 
> it can be removed once it's not in use any more. If you can't see that 
> this is how a kernel should work, you're missing the point of having a 
> kernel in the first place."
> 
> Linus, http://lkml.org/lkml/2006/10/4/327

So I'm amused that the problem you refer to is the direct consequence
of Linus' patch to add the suspend_late()/resume_early() mechanism
into the PCI driver framework.  (Again, see the technical explanation;
and please try to have a technical discussion, not a flamefest.)


One of the missing steps in Linus' formulation there is that not all
interfaces are equivalent in terms of support guarantee.  Bugs are
interfaces, for example, and sometimes folk wrongly depend on them
when they persist for a long time (like, cough, this one).

His comment was specifically about breaking a widely used API that
many people have been relying on since, oh, about 1996, and had been
well proven in that time.  And the change was a "system doesn't work"
level change.

In contrast, the /sys/devices/.../power/state API has never had many
users beyond developers trying to test their drivers (without taking
the whole system into a low power state, which probably didn't work
in any case), and has *always* been problematic.  And the change you
object to doesn't "break" anything fundamental, either.  Everything
still works.

In terms of any reasonable expectations about support, those two
changes aren't comparable.

- Dave
