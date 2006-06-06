Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751206AbWFFCBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWFFCBJ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFFCBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:01:09 -0400
Received: from xenotime.net ([66.160.160.81]:19412 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751206AbWFFCBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:01:08 -0400
Date: Mon, 5 Jun 2006 19:03:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605190355.c1be6d75.rdunlap@xenotime.net>
In-Reply-To: <4484E06B.9020609@microgate.com>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<4484E06B.9020609@microgate.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 20:54:51 -0500 Paul Fulghum wrote:

> Randy.Dunlap wrote:
> > Those Kconfig + Makefiles are quite ugly to me.  I would rather see
> > SYNCLINK depend on HDLC rather than using some tricks to SELECT HDLC.
> > And then it selects HDLC (and HDLC depends on WAN), but (in my case)
> > WAN was not enabled, and doing "SELECT HDLC" did not enable WAN.
> > 
> > Adding SELECT WAN and changing the hdlc (wan) Makefile to use
> > obj-m or obj-y (it was ONLY obj-y for hdlc) fixes^W makes it build
> > with no missing symbols.  However, I'll also see about a fix
> > that uses "depends on HDLC" instead of "selects HDLC".
> 
> Generic HDLC support in the synclink drivers is optional.
> Should the generic HDLC code be enabled even if it is not used?
> 
> Some of our customers would scream if we started forcing
> them to compile and load unused code.

OK, I'll try to allow for that.

> > Fix many missing hdlc_generic symbols when CONFIG_HDLC=m.
> > When Selecting HDLC, also Select WAN.
> > Fix Makefile to build for HDLC=y or HDLC=m.
> > 
> > +	select WAN if SYNCLINK_HDLC
> 
> If this is the accepted approach, then synclink_cs should be added also.
> (drivers/char/pcmcia)

It's not the desired approach AFAIK, but it may be the only
reasonable one.  I'm still testing alternatives, but you are welcome
to take over and fix it.  :)

> What about select WAN if HDLC instead?
> Or does kbuild not propogate the reverse dependency?
> (SYNCLINK_HDLC selects HDLC, HDLC selects WAN)

OK.

---
~Randy
