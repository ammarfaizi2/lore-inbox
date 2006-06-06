Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWFFUnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWFFUnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWFFUnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:43:03 -0400
Received: from xenotime.net ([66.160.160.81]:37287 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750974AbWFFUnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:43:02 -0400
Date: Tue, 6 Jun 2006 13:45:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
Message-Id: <20060606134548.3087109c.rdunlap@xenotime.net>
In-Reply-To: <m3u06yc9mr.fsf@defiant.localdomain>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 22:27:40 +0200 Krzysztof Halasa wrote:

> Paul Fulghum <paulkf@microgate.com> writes:
> 
> > +++ b/drivers/net/wan/Makefile	2006-06-06 14:08:53.000000000 -0500
> > @@ -9,14 +9,18 @@ cyclomx-y                       := cycx_
> >  cyclomx-$(CONFIG_CYCLOMX_X25)	+= cycx_x25.o
> >  cyclomx-objs			:= $(cyclomx-y)  
> >  
> > -hdlc-y				:= hdlc_generic.o
> > +hdlc-$(CONFIG_HDLC)		:= hdlc_generic.o
> >  hdlc-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
> >  hdlc-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
> >  hdlc-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
> >  hdlc-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
> >  hdlc-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o
> >  hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
> > -hdlc-objs			:= $(hdlc-y)
> > +ifeq ($(CONFIG_HDLC),y)
> > +  hdlc-objs			:= $(hdlc-y)
> > +else
> > +  hdlc-objs			:= $(hdlc-m)
> > +endif
> 
> How could that work? If CONFIG_HDLC=m and CONFIG_HDLC_*=y it would read:
> 
> hdlc-m := hdlc_generic.o
> hdlc-y := hdlc_{raw,raw_eth,cisco,fr,ppp,x25}.o
> hdlc-objs := $(hdlc-m)
> 
> CONFIG_HDLC is 3-state and CONFIG_HDLC_* are simple bools, everything
> makes a single module.
> 
> Not sure what missing symbols do you experience (never had synclink
> adapter) but almost certainly it's when generic HDLC is not selected
> (or is 'm' while synclink is 'y') and it's not related to the Makefile
> (i.e., while I don't exactly like the rest of the patch as I think
> enabling gHDLC should enable hw drivers - like with other drivers -
> it would probably work).

True, I didn't test every possible config. :)
I'll test some other possibilities...

---
~Randy
