Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290594AbSA3VEi>; Wed, 30 Jan 2002 16:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290597AbSA3VEf>; Wed, 30 Jan 2002 16:04:35 -0500
Received: from adsl-65-42-129-26.dsl.chcgil.ameritech.net ([65.42.129.26]:17499
	"EHLO localhost") by vger.kernel.org with ESMTP id <S290594AbSA3VEL>;
	Wed, 30 Jan 2002 16:04:11 -0500
Date: Wed, 30 Jan 2002 15:04:28 -0500
From: Mike Phillips <phillim2@home.com>
To: Kent E Yoder <yoder1@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
Message-ID: <20020130200428.GA7318@home.com>
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:27:29PM -0600 or sometime in the same epoch, Kent E Yoder scribbled:
>   I think the delays in the driver *were* just working around PCI posting 
> effects.  I tested by removing all the delays and instead putting 
> something like:
>         writew(val, addr);
>         (void) read(addr);

Yep, I has a similar problem when developing olympic, I would write
twice to the same location in very quick succession. This was using
one of the built in locations that the chipset would binary OR to the
current value. So theoretically the second write should have been
OR'ed with the first write, but the second write was being done before
the first write was committed across the pci bus, resulting in only
the second value being stored. 

In the end, I rewrote it to combine into a single write. 

-- 
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net
mailto: mikep@linuxtr.net

