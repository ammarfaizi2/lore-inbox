Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSKXNae>; Sun, 24 Nov 2002 08:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSKXNae>; Sun, 24 Nov 2002 08:30:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261292AbSKXNad>; Sun, 24 Nov 2002 08:30:33 -0500
Date: Sun, 24 Nov 2002 13:37:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kconfig: Locate files relative to $srctree
Message-ID: <20021124133741.A29087@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20021123220747.GA10411@mars.ravnborg.org> <Pine.LNX.4.44.0211240250490.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211240250490.2113-100000@serv>; from zippel@linux-m68k.org on Sun, Nov 24, 2002 at 02:56:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 02:56:22AM +0100, Roman Zippel wrote:
> >  const char *conf_confnames[] = {
> >  	".config",
> >  	"/lib/modules/$UNAME_RELEASE/.config",
> >  	"/etc/kernel-config",
> >  	"/boot/config-$UNAME_RELEASE",
> > -	conf_defname,
> > +	"arch/$ARCH/defconfig",			/* index DEFNAME */
> > +	"$" SRCTREE "/arch/$ARCH/defconfig",	/* index DEFALTNAME */
> >  	NULL,
> >  };
> 
> This is not good. At some point I maybe want to make these configurable.
> I changed the patch to always use zconf_fopen(), which will try the 
> alternative prefix for relative paths.
> I couldn't test this very much as you forgot the kbuild script. :)
> Anyway, below is an alternative version.

One thing that does slightly annoy me with the new config tools is the
handling of the default configuration when you're cross-building.  In
this circumstance, looking for the running kernel configuration seems
wrong; it definitely isn't going to be the configuration you want to
start from.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

