Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVKBNR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVKBNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVKBNR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:17:59 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:2980 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932704AbVKBNR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:17:58 -0500
Date: Wed, 02 Nov 2005 22:08:39 +0900 (JST)
Message-Id: <20051102.220839.00469746.taka@valinux.co.jp>
To: clameter@engr.sgi.com
Cc: rob@landley.net, akpm@osdl.org, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20051102.212651.25143264.taka@valinux.co.jp>
References: <20051102.143047.35521963.taka@valinux.co.jp>
	<Pine.LNX.4.62.0511020030210.19157@schroedinger.engr.sgi.com>
	<20051102.212651.25143264.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

The page migration code is waiting for something appearing to
use it but memory hotremove. I thought it would be memory
defragmentation or process migration.

> >> > > > Do you think the features which these patches add should be Kconfigurable?
> >> 
> >> This code looks no help for hot-remove. It seems able to handle only
> >> pages easily to migrate, while hot-remove has to guarantee all pages
> >> can be migrated.
> >
> >Right.
> >
> >> Hi Christoph, sorry I've been off from lhms for long time.
> >> 
> >> Shall I port the generic memory migration code for hot-remove to -mm tree
> >> directly, and add some new interface like migrate_page_to(struct page *from,
> >> struct page *to) so this may probably fit for your purpose.
> >> 
> >> The code is still in Dave's mhp1 tree waiting for being merged to -mm tree.
> >> The port will be easy because the migration code is independent to the
> >> memory hotplug code. The core code isn't so big.
> >
> >Please follow the discussion on lhms-devel. I am trying to bring these two 
> >things together.
> 
> I've read the archive of lhms-devel.
> You're going to take in most of the original migration code
> except for some tricks to migrate pages which are hard to move.
> I think this is what you said the complexity, which you
> want to remove forever.

If you don't like the code is devided into a lot of small pieces,
I can merge their patches into several patches.

> I have to explain that this complexity came from making the code
> guarantee to be able to migrate any pages. So the code is designed:
>   - to migrate heavily accessed pages.
>   - to migrate pages without backing-store.
>   - to migrate pages without I/O's.
>   - to migrate pages of which status may be changed during the migration
>     correctly.
> 
> This have to be implemented if the hotplug memory use it.
> It seems to become a reinvention of the wheel to me.
> 
> It's easy to add a new interface to the code for memory policy aware
> migration. It will be wonderful doing process migration prior to
> planed hotremove momory. This decision should be done out of kernel.

If you really want to skip the complex part, I can easily add a non-wait
mode to the migration code. 

Thanks,
Hirokazu Takahashi.
