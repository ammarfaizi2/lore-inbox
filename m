Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUGaRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUGaRNr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUGaRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:13:47 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:50695 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266096AbUGaRNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:13:45 -0400
Date: Sat, 31 Jul 2004 19:05:51 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       alan@redhat.com, jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731170551.GA27559@alpha.home.local>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org> <410BD0E3.2090302@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410BD0E3.2090302@candelatech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Sat, Jul 31, 2004 at 10:03:31AM -0700, Ben Greear wrote:
 
> VLAN allows you to continue using the ethX interface as a regular
> ethernet interface, so you do not generally want it's MTU to be set
> to 1504 because then the other peer ethernet interfaces would also
> have to be set to 1504.  I believe it is much better to silently let
> the extra 4 bytes pass but NOT advertise this extra 4 bytes to
> anything that actually cares about MTU.

I 100% agree with you on this one, but I don't see how playing with
change_mtu() would change anything. Ideally, we would need to export
the level 2 limit (imposed by hardware and intermediate switches) to
other drivers such as 802_1q, and let only the IP stack rely on dev->mtu.

I've seen several drivers which silently add 4 bytes to the hardware
config when CONFIG_VLAN is set. I find it better than fooling the IP
stack into using 1504 bytes, which is a disaster on UDP !

Cheers,
Willy

