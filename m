Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVJDIMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVJDIMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 04:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVJDIMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 04:12:43 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:44662 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964785AbVJDIMm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 04:12:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gxKq7+X6V6JBQ000X+3Zz1NWi0aXt06tZ6MODHLAhstHMZ5GSmSG26XIYqQlE29QOJ3cCRZET2N5/t3B9rbyEJdpm3Tz+w13yN8jiGcP0lZ7IKrvUJyRZcuTw5E0vEyIC6sh3SBFSAo/uwks+UzzuYtf4PUsRiCflBBIv1tfxPo=
Message-ID: <2cd57c900510040112q10eb5cdbya2ef62689e8f90f2@mail.gmail.com>
Date: Tue, 4 Oct 2005 16:12:40 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: halt: init exits/panic
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051004073740.GA1498@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050709151227.GM1322@schottelius.org>
	 <2cd57c9005070910091f1051f7@mail.gmail.com>
	 <20051004073740.GA1498@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> Coywolf Qi Hunt [Sun, Jul 10, 2005 at 01:09:22AM +0800]:
> > On 7/9/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> > > Hello!
> > >
> > > What's the 'correct behaviour' of an init system, if someone wants
> > > to shutdown the system?
> > >
> > > I currently do:
> > >
> > > - call reboot(RB_POWER_OFF/RB_AUTOBOOT/RB_HALT_SYSTEM)
> > > - _exit(0)
> > >
> > > Is this exit() call wrong? If I do RB_HALT_SYSTEM and _exit(0) after,
> > > the kernel panics.
> >
> > What the panic shows?
>
> To be fully correct:
>
> "Kernel panic - not syncing: Attempted to kill init" (from the last time
> I tried, 2.6.13.2)
>
> Perhaps _exit(0) is not correct for an init system?
> This at least explains why it always looks like nothing is synced.

Right. init(8) should not call _exit() or exit(). Otherwise you'll get
that panic. It's OK for *another* process, reboot(8) to call reboot(2)
and then exit(). You should follow this way.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
