Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTA1I7g>; Tue, 28 Jan 2003 03:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTA1I7g>; Tue, 28 Jan 2003 03:59:36 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57565 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261302AbTA1I7g>; Tue, 28 Jan 2003 03:59:36 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301280908.h0S98rT26148@devserv.devel.redhat.com>
Subject: Re: 2.4.21-pre3 kernel crash
To: jgarzik@pobox.com (Jeff Garzik)
Date: Tue, 28 Jan 2003 04:08:53 -0500 (EST)
Cc: ed@efix.biz (Edward Tandi),
       linux-kernel@vger.kernel.org (Kernel mailing list), alan@redhat.com
In-Reply-To: <20030127205719.GB20873@gtf.org> from "Jeff Garzik" at Jan 27, 2003 03:57:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > certain applications (gaim, macromedia flash player 6 for example), esd
> > gets itself into some kind of hung/blocked state. When this happens, I
> > need to kill esd and re-start it. Games and xmms work however. The
> > reason I ask about this is that the downloaded driver from the viaarena
> > works on a stock kernel without this glitch. Is this a known problem?
> > 
> > The chip is a VT8235 and I'm happy that it mostly works in pre3 too. The
> > alsa driver reportedly works OK.
> 
> hmmm, not a known problem to me.  Alan?

I have an idea actually, and if so a quickfix for Arjan. What happens is

	app -> open /dev/audio	(gets the 6 channel audio)
	app2 (esd) -> open /dev/audio1 (gets the secondary dsp)

or app2 opens /dev/audio and we have a close v open wakeup bug. 

I will investigate both paths
