Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275513AbTHNUbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275514AbTHNUbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:31:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40711 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S275513AbTHNUbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:31:51 -0400
Date: Thu, 14 Aug 2003 22:31:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Jeff Garzik <jgarzik@pobox.com>,
       Matthew Wilcox <willy@debian.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030814203143.GA607@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, Jeff Garzik <jgarzik@pobox.com>,
	Matthew Wilcox <willy@debian.org>,
	Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
	davej@redhat.com, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com> <20030813195412.GE10015@parcelfarce.linux.theplanet.co.uk> <3F3A9FA1.8000708@pobox.com> <20030813210531.GA15148@mars.ravnborg.org> <Pine.LNX.4.44.0308140018170.24676-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308140018170.24676-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 12:24:28AM +0200, Roman Zippel wrote:
> Something I really want to avoid is Makefile specific syntax in Kconfig.
I do not see the point in this.
Kconfig should treat this as a block of text - like the help section.
Only action to take is to:
1: Find all symbols enclosed in $()
	a: Check that it exists
	b: Append CONFIG_

Then Kconfig in each directory should generate a Kconfig.make file,
that will be included when kbuild reaches that directory.

> IMO it should somehow like this:
> 
> module maxtorsata MAXTOR_SATA
> 	{tristate|prompt} "SATA for Maxtor IDE"
> 	depends on LIB_SATA
> 	source smaxtor.c
> 	source maxtorlog.c if MAXTOR_VERBOSE

If using the above syntax - where do you see the rules being translated
to makefile syntax?
kbuild could do this - yes. But I do not see the point in having
the extra abstraction layer. Maybe you have something in mind I have
not envisioned?

	Sam
