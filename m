Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267108AbSLDWBS>; Wed, 4 Dec 2002 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267109AbSLDWBS>; Wed, 4 Dec 2002 17:01:18 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:46062 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S267108AbSLDWBR>; Wed, 4 Dec 2002 17:01:17 -0500
Date: Wed, 4 Dec 2002 15:00:31 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [STATUS] fbdev api.
In-Reply-To: <1038972718.1086.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212041457580.1533-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you apply the following patch to include logo drawing support for all formats :-)?

Applied :-)

> It's not the switch back to text mode, that's very doable (see my other
> reply).  It's during give_up_console() at fbcon module exit.  At this
> point, the console suddenly disappears and freezes the system.  Maybe we
> can save the global "conswitchp" during fbcon module init, then
> something like this at fbcon module exit:
>
> void __exit fb_console_exit(void)
> {
> 	give_up_console(&fbcon);
> 	take_over_console(saved_conswitchp, ...);
> }
>
> Is this feasible?

I thought about it but the solution is not easy. Consider that we have
vgacon and mdacon. Then I load in hgafb. Here the goal is to take over
mdacon. So we have to prevent taking over vgacon. Since there is only on
conswitchp we are in trouble.

