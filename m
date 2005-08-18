Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVHRH0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVHRH0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVHRH0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:26:36 -0400
Received: from [85.8.12.41] ([85.8.12.41]:50579 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750848AbVHRH0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:26:36 -0400
Message-ID: <4304380B.5070406@drzeus.cx>
Date: Thu, 18 Aug 2005 09:26:03 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk>
In-Reply-To: <20050818073824.C2365@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>
>I'd rather not.  The problem is that we have a host (thanks Intel)
>which is unable to report how many bytes were transferred before an
>error occurs.  My fear is that doing anything other than sector by
>sector write will lead to corruption should an error occur.
>
>However, I've no way to induce such an error, so I can only base
>this on theory.
>
>It may work perfectly for the case when everything's operating
>correctly, but I suspect if you're going to do multi-sector writes,
>it'll all fall apart on the first error, especially on this host.
>
>  
>

We had this discussion on LKML and Alan Cox' comment on it was that a
solution like this would be acceptable, where we try and shove
everything out first and then fall back on sector-by-sector to determine
where an error occurs. This will only break if the problematic sector
keeps shifting around, but at that point the card is probably toast
anyway (if the thing keeps moving how can you bad block it?).

Rgds
Pierre

