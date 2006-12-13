Return-Path: <linux-kernel-owner+w=401wt.eu-S965091AbWLMTTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWLMTTo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbWLMTTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:19:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60815 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965091AbWLMTTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:19:43 -0500
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 14:19:42 EST
Date: Wed, 13 Dec 2006 11:08:01 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213110801.1dd849ec@dxpl.pdx.osdl.net>
In-Reply-To: <20061212.171756.85408589.davem@davemloft.net>
References: <20061212162435.GW28443@stusta.de>
	<20061212.171756.85408589.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 17:17:56 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

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

The dst code makes assumptions that loopback is ifindex 1 as well.
NAK on Adrian's change, it doesn't buy anything
