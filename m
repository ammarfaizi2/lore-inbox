Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263392AbUJ2PiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbUJ2PiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUJ2PhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:37:10 -0400
Received: from witte.sonytel.be ([80.88.33.193]:17798 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263414AbUJ2PC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:02:59 -0400
Date: Fri, 29 Oct 2004 16:54:42 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Bill Davidsen <davidsen@tmr.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       "H. Peter Anvin" <hpa@zytor.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
In-Reply-To: <20041029145111.GO6677@stusta.de>
Message-ID: <Pine.GSO.4.61.0410291653170.23014@waterleaf.sonytel.be>
References: <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
 <417FF43C.5050208@tmr.com> <20041029145111.GO6677@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Adrian Bunk wrote:
> On Wed, Oct 27, 2004 at 03:17:16PM -0400, Bill Davidsen wrote:
> > Denis Vlasenko wrote:
> > >Why there is any distinction between, say, gcc and X?
> > >KDE and Midnight Commander? etc... Why some of them go
> > >to /opt while others are spread across dozen of dirs?
> > >This seems to be inconsistent to me.
> > 
> > At one time Sun had the convention that things in /usr could be mounted 
> > ro on multiple machines. That worked, it predates Linux so Linux was the 
> > o/s which chose to go another way, and it covered the base things in a 
> > system.
> > 
> > That actually seems like a good way to split a networked environment, 
> > with /bin and /sbin having just enough to get the system up and mount 
> > /usr. I can't speak to why that is being done differently now.
> > 
> > I guess someone was nervous about mounting a local /usr/local on a 
> > (possibly) network mounted /usr and theu /opt, but that's a guess on my 
> > part as well.
> 
> Read-only /usr is required according to the FHS, and at least on Debian 
> a read-only /usr works without problems.

Indeed. And that's what I use. In /etc/apt/apt.conf I have:

    DPkg {
        // Auto re-mounting of a readonly /usr
	Pre-Invoke {"mount -o remount,rw /usr";};
	Post-Invoke {"mount -o remount,ro /usr";};
    }

> A bigger problem might be to properly support it in the package manager.

Yep. Apt knows about it, but dpkg doesn't. And remounting /usr read-only
fails if files are in use.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
