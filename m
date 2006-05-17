Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWEQG72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWEQG72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 02:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEQG72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 02:59:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40108
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751267AbWEQG71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 02:59:27 -0400
Date: Tue, 16 May 2006 23:59:10 -0700 (PDT)
Message-Id: <20060516.235910.71774114.davem@davemloft.net>
To: kaber@trash.net
Cc: sfrost@snowman.net, azez@ufomechanic.net, willy@w.ods.org,
       gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <446AC1FB.5070406@trash.net>
References: <20060515204142.GO7774@kenobi.snowman.net>
	<20060515210342.GP7774@kenobi.snowman.net>
	<446AC1FB.5070406@trash.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 17 May 2006 08:26:03 +0200

> Stephen Frost wrote:
> > Looking at this again...  The ttl isn't copied into 'ttl' unless the
> > check_set has TTL turned on.  This means that the overwritting was fine,
> > if you accept that you can only ever match on TTL, or never match on it.
> > That doesn't seem right to me.  The TTL in the table should always be
> > kept up-to-date and the only question is if the current rule requires it
> > for a match or not.
> 
> 
> OK, updated patch attached. The TTL is now always kept up-to-date.

Looks nice.

Is there any reasonable reason to allow ip_pkt_list_tot to ever be
larger than say 255?  If we can accept that limit, we can shrink
the recent_entry considerably by packing the index and nstamps
into a single word next to ttl.
