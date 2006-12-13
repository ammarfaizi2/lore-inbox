Return-Path: <linux-kernel-owner+w=401wt.eu-S1751694AbWLMXMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWLMXMM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWLMXMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:12:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2518 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751694AbWLMXML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:12:11 -0500
Date: Thu, 14 Dec 2006 00:12:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Thomas Graf <tgraf@suug.ch>, Al Viro <viro@ftp.linux.org.uk>,
       David Miller <davem@davemloft.net>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213231217.GB3629@stusta.de>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net> <20061213201213.GK4587@ftp.linux.org.uk> <20061213204933.GW8693@postel.suug.ch> <20061213150143.2672e0b1@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213150143.2672e0b1@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 03:01:43PM -0800, Stephen Hemminger wrote:
> On Wed, 13 Dec 2006 21:49:33 +0100
> Thomas Graf <tgraf@suug.ch> wrote:
> 
> > * Al Viro <viro@ftp.linux.org.uk> 2006-12-13 20:12
> > > On Tue, Dec 12, 2006 at 05:17:56PM -0800, David Miller wrote:
> > > > I'm not sure whether that is important any longer.  It probably isn't,
> > > > but we should verify it before applying such a patch.
> > > 
> > > There might be practical considerations along the lines of "we want
> > > lookups for loopback to be fast"...
> > 
> > What is this discussion actually about? Since we started registering
> > devices directly hooked into the init process before device_initcall()
> > the order is random. Even the bonding device is registered before the
> > loopback.
> 
> Loopback should be there before protocols are started. It makes sense
> to have a standard startup order.

This actually becomes easier after my patch:

Now that it's untangled from net_olddevs_init(), you can simply change 
the module_init(loopback_init) to a different initcall level.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

