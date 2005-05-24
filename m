Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVEXJZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVEXJZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVEXJXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:23:19 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:21188 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261993AbVEXJSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:18:53 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091852.43480FA5B@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:18:52 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 84712FB78

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:48 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261301AbVEXB43 (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 21:56:29 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVEXB43

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 21:56:29 -0400

Received: from mail.dvmed.net ([216.237.124.58]:59595 "EHLO mail.dvmed.net")

	by vger.kernel.org with ESMTP id S261300AbVEXB41 (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 21:56:27 -0400

Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])

	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))

	id 1DaOee-00018N-Sq; Tue, 24 May 2005 01:56:25 +0000

Message-ID: <429289C6.9080707@pobox.com>

Date:	Mon, 23 May 2005 21:56:22 -0400

From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5

X-Accept-Language: en-us, en

MIME-Version: 1.0

To: Brent Casavant <bcasavan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ioc4: Driver rework

References: <20050523192157.V75588@chenjesu.americas.sgi.com>

In-Reply-To: <20050523192157.V75588@chenjesu.americas.sgi.com>

Content-Type: text/plain; charset=us-ascii; format=flowed

Content-Transfer-Encoding: 7bit

X-Spam-Score: 0.0 (/)

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Brent Casavant wrote:
> - The IOC4 chip implements multiple functions (serial, IDE, others not
>   yet implemented in the mainline kernel) but is not a multifunction
>   PCI device.  In order to properly handle device addition and removal
>   as well as module insertion and deletion, an intermediary IOC4-specific
>   driver layer is needed to handle these operations cleanly.

I disagree that a layer is needed.

Just write a PCI driver that does the following in probe:

	register IDE
	register serial
	...

and undoes all that in remove.

Device addition and removal work just fine with that scheme.

	Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

