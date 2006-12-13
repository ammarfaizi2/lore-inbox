Return-Path: <linux-kernel-owner+w=401wt.eu-S932677AbWLMTgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWLMTgQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWLMTgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:36:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1917 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932672AbWLMTgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:36:14 -0500
Date: Wed, 13 Dec 2006 20:36:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Miller <davem@davemloft.net>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213193623.GA3629@stusta.de>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net> <20061213110801.1dd849ec@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213110801.1dd849ec@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 11:08:01AM -0800, Stephen Hemminger wrote:
> On Tue, 12 Dec 2006 17:17:56 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Adrian Bunk <bunk@stusta.de>
> > Date: Tue, 12 Dec 2006 17:24:35 +0100
> > 
> > > This patch converts drivers/net/loopback.c to using module_init().
> > > 
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > I'm not %100 sure of this one, let's look at the comment you
> > are deleting:
> > 
> > > -/*
> > > - *	The loopback device is global so it can be directly referenced
> > > - *	by the network code. Also, it must be first on device list.
> > > - */
> > > -extern int loopback_init(void);
> > > -
> > 
> > in particular notice the part that says "it must be first on the
> > device list".
> > 
> > I'm not sure whether that is important any longer.  It probably isn't,
> > but we should verify it before applying such a patch.
> > 
> > Since module_init() effectively == device_initcall() for statically
> > built objects, which loopback always is, the Makefile ordering does
> > not seem to indicate to me that there is anything guarenteeing
> > this "first on the list" invariant.  At least not via object
> > file ordering.
> > 
> > So this gives some support to the idea that loopback_dev's position
> > on the device list no longer matters.
> 
> The dst code makes assumptions that loopback is ifindex 1 as well.
>...

But that assumption is already false for drivers not handled by Space.c:

E.g. on my computer [1], eth0 [2] has ifindex 1 and lo has ifindex 2.

cu
Adrian

[1] plain 2.6.16.36
[2] built-in e100 driver

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

