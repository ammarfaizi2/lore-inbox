Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTIZLou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 07:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTIZLou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 07:44:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45324 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262060AbTIZLos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 07:44:48 -0400
Date: Fri, 26 Sep 2003 12:44:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030926124442.B23211@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20030914121655.GS27368@fs.tum.de> <20030914133349.A27870@flint.arm.linux.org.uk> <20030914132143.GT27368@fs.tum.de> <20030914155245.A675@flint.arm.linux.org.uk> <20030925143844.GY15696@fs.tum.de> <20030925181127.GB2089@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030925181127.GB2089@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Sep 25, 2003 at 08:11:27PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 08:11:27PM +0200, Sam Ravnborg wrote:
> On Thu, Sep 25, 2003 at 04:38:45PM +0200, Adrian Bunk wrote:
> > --- linux-2.6.0-test5-mm4/init/Kconfig.old	2003-09-25 14:38:18.000000000 +0200
> > +++ linux-2.6.0-test5-mm4/init/Kconfig	2003-09-25 14:47:12.000000000 +0200
> > @@ -65,6 +65,16 @@
> >  
> >  menu "General setup"
> >  
> > +config OPTIMIZE_FOR_SIZE
> > +	bool "Optimize for size" if EXPERIMENTAL
> > +	default y if ARM || H8300
> > +	default n
> > +	help
> > +	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> > +	  resulting in a smaller kernel.
> > +
> > +	  If unsure, say N.
> > +
> 
> This is a general file, and it is wrong to include architecture specific
> knowledge here.

In which case we need to replicate the option in each of the per-
architecture files.  That seems a bit wasteful though.

I don't think "select" will hack it in this case though.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
