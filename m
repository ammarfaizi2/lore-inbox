Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVCIAeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVCIAeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVCHXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:45:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:34694 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262250AbVCHXkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:40:16 -0500
Date: Tue, 8 Mar 2005 15:37:07 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       jt@hpl.hp.com, linux-pcmcia@lists.infradead.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA product id strings -> hashes generation at compilation time? [Was: Re: [patch 14/38] pcmcia: id_table for wavelan_cs]
Message-ID: <20050308233706.GA11454@kroah.com>
References: <20050308191138.GA16169@isilmar.linta.de> <20050308123426.249fa934.akpm@osdl.org> <20050227161308.GO7351@dominikbrodowski.de> <20050307225355.GB30371@bougret.hpl.hp.com> <20050307230102.GA29779@isilmar.linta.de> <20050307150957.0456dd75.akpm@osdl.org> <20050307232339.GA30057@isilmar.linta.de> <20050308191138.GA16169@isilmar.linta.de> <Pine.LNX.4.58.0503081438040.13251@ppc970.osdl.org> <20050308231636.GA20658@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308231636.GA20658@isilmar.linta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:16:36AM +0100, Dominik Brodowski wrote:
> > Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > >
> > > Most pcmcia devices are matched to drivers using "product ID strings"
> > >  embedded in the devices' Card Information Structures, as "manufactor ID /
> > >  card ID" matches are much less reliable. Unfortunately, these strings cannot
> > >  be passed to userspace for easy userspace-based loading of appropriate
> > >  modules (MODNAME -- hotplug), so my suggestion is to also store crc32 hashes
> > >  of the strings in the MODULE_DEVICE_TABLEs, e.g.:
> > > 
> > >  PCMCIA_DEVICE_PROD_ID12("LINKSYS", "E-CARD", 0xf7cb0b07, 0x6701da11),
> > 
> > What is the difficulty in passing these strings via /sbin/hotplug arguments?
> 
> The difficulty is that extracting and evaluating them breaks the wonderful 
> bus-independent MODNAME implementation for hotplug suggested by Roman Kagan
> ( http://article.gmane.org/gmane.linux.hotplug.devel/7039 ), and that these
> strings may contain spaces and other "strange" characters. The latter may be 
> worked around, but the former cannot. /etc/hotplug/pcmcia.agent looks really
> clean because of this MODNAME implementation:

I think that MODNAME should be replaced with MODALIAS, but that's a
different email thread...

Anyway, hashes are icky, I still don't see why using the string as
module aliases, and fixing up modprobe to handle spaces in module
aliases wouldn't work out easier.

thanks,

greg k-h
