Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSHXExw>; Sat, 24 Aug 2002 00:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSHXExw>; Sat, 24 Aug 2002 00:53:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21814 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315276AbSHXExv>; Sat, 24 Aug 2002 00:53:51 -0400
Date: Sat, 24 Aug 2002 00:57:56 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org
Subject: Re: Little console problem in 2.5.30
Message-ID: <20020824005756.A14783@devserv.devel.redhat.com>
References: <20020819023731.C316@devserv.devel.redhat.com> <Pine.GSO.4.21.0208191433430.23654-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0208191433430.23654-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Mon, Aug 19, 2002 at 02:36:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 19 Aug 2002 14:36:25 +0200 (MEST)
> From: Geert Uytterhoeven <geert@linux-m68k.org>

> > I would appreciate if someone would explain me if the attached patch
> > does the right thing. The problem is that I do not use the framebuffer,
> > and use a serial console. Whenever a legacy /sbin/init tries to
> > open /dev/tty0, the system oopses dereferencing conswitchp in
> > visual_init().

> >  int vc_allocate(unsigned int currcons)	/* return 0 on success */
> >  {
> > -	if (currcons >= MAX_NR_CONSOLES)
> > +	if (currcons >= MAX_NR_CONSOLES || conswitchp == NULL)
> 
> And this worked before?
> 
> conswitchp must never be NULL, say `conswitchp = &dummy_con;' in your setup.c
> if you have a serial console.
> 
> >From looking at arch/sparc/kernel/setup.c, perhaps you have
> CONFIG_DUMMY_CONSOLE=n?

This only works if CONFIG_FB is present, and I do not want to add
one more useless chunk of code to the build. All my boxes have
serial consoles (like I said, I would throw CONFIG_VT away if
only it was not welded into the rest of the code so well).

-- Pete
