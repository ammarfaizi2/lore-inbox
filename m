Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVCIHVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVCIHVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 02:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVCIHT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 02:19:59 -0500
Received: from isilmar.linta.de ([213.239.214.66]:55264 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262094AbVCIHTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 02:19:43 -0500
Date: Wed, 9 Mar 2005 08:19:42 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: PCMCIA product id strings -> hashes generation at compilation time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
Message-ID: <20050309071942.GA28231@isilmar.linta.de>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <20050308123426.249fa934.akpm@osdl.org> <20050227161308.GO7351@dominikbrodowski.de> <20050307225355.GB30371@bougret.hpl.hp.com> <20050307230102.GA29779@isilmar.linta.de> <20050307150957.0456dd75.akpm@osdl.org> <20050307232339.GA30057@isilmar.linta.de> <20050308191138.GA16169@isilmar.linta.de> <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org> <20050308231636.GA20658@isilmar.linta.de> <1110347109.32524.56.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110347109.32524.56.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 04:45:09PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-03-09 at 00:16 +0100, Dominik Brodowski wrote:
> > > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > > >
> > > > Most pcmcia devices are matched to drivers using "product ID strings"
> > > >  embedded in the devices' Card Information Structures, as "manufactor ID /
> > > >  card ID" matches are much less reliable. Unfortunately, these strings cannot
> > > >  be passed to userspace for easy userspace-based loading of appropriate
> > > >  modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
> > > >  of the strings in the MODULE_DEVICE_TABLEs, e.g.:
> > > > 
> > > >  PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),
> > > 
> > > What is the difficulty in passing these strings via /sbin/hotplug arguments?
> > 
> > The difficulty is that extracting and evaluating them breaks the wonderful 
> > bus-independent MODNAME implementation for hotplug suggested by Roman Kagan
> > ( http://article.gmane.org/gmane.linux.hotplug.devel/7039 ), and that these
> > strings may contain spaces and other "strange" characters. The latter may be 
> > worked around, but the former cannot. /etc/hotplug/pcmcia.agent looks really
> > clean because of this MODNAME implementation:
> 
> Same goes with Open Firmware match strings that we are about to pass
> down to userspace as well. Hotplug will have to learn to deal with
> those.

Hotplug isn't the tricky part. file2alias is. Any idea on how to do that?

	Dominik
