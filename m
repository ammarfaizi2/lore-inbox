Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUKVTn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUKVTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbUKVTlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:41:47 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:24218 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262364AbUKVTj7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:39:59 -0500
Date: Mon, 22 Nov 2004 20:40:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][RFC/v1][8/12] Add IPoIB (IP-over-InfiniBand) driver
Message-ID: <20041122194003.GC8150@mars.ravnborg.org>
Mail-Followup-To: Roland Dreier <roland@topspin.com>,
	linux-kernel@vger.kernel.org, openib-general@openib.org,
	netdev@oss.sgi.com
References: <20041122713.FnSlYodJYum7s82D@topspin.com> <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More nitpicking..

	Sam
	
> +++ linux-bk/drivers/infiniband/Makefile	2004-11-21 21:25:56.794775182 -0800
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_INFINIBAND)		+= core/
No reason to use $(CONFIG_INFINIBAND) here - it's already done in
drivers/infiniband/Makefile

> +EXTRA_CFLAGS += -Idrivers/infiniband/include
This will get killed if you move the include files...

 +
> +obj-$(CONFIG_INFINIBAND_IPOIB)			+= ib_ipoib.o
> +
> +ib_ipoib-y					:= ipoib_main.o \
> +						   ipoib_ib.o \
> +						   ipoib_multicast.o \
> +						   ipoib_verbs.o \
> +						   ipoib_vlan.o
One or two lines.

> +#include <asm/semaphore.h>
> +
> +#include "ipoib_proto.h"
Shoulb be included as the last file - since it's the most local one.
> +
> +#include <ib_verbs.h>
> +#include <ib_pack.h>
> +#include <ib_sa.h>
> 
