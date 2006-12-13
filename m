Return-Path: <linux-kernel-owner+w=401wt.eu-S964968AbWLMNkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWLMNkf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWLMNke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:40:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2530 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964968AbWLMNkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:40:33 -0500
Date: Wed, 13 Dec 2006 14:40:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Miller <davem@davemloft.net>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213134042.GI3851@stusta.de>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212.171756.85408589.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 05:17:56PM -0800, David Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Tue, 12 Dec 2006 17:24:35 +0100
> 
> > This patch converts drivers/net/loopback.c to using module_init().
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I'm not %100 sure of this one, let's look at the comment you
> are deleting:
> 
> > -/*
> > - *	The loopback device is global so it can be directly referenced
> > - *	by the network code. Also, it must be first on device list.
> > - */
> > -extern int loopback_init(void);
> > -
> 
> in particular notice the part that says "it must be first on the
> device list".
> 
> I'm not sure whether that is important any longer.  It probably isn't,
> but we should verify it before applying such a patch.
> 
> Since module_init() effectively == device_initcall() for statically
> built objects, which loopback always is, the Makefile ordering does
> not seem to indicate to me that there is anything guarenteeing
> this "first on the list" invariant.  At least not via object
> file ordering.
> 
> So this gives some support to the idea that loopback_dev's position
> on the device list no longer matters.

That far I already was.

Additionally:
- it works for me (but my e100 is always initialized before loop)
- I didn't spot any obvious interdependency with the other Space.c
  drivers

It could be I missed anything, but I don't see any better way to verify 
this than getting the patch into the next -mm and wait whether someone 
will scream...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

