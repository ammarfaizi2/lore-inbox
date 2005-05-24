Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVEXB43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVEXB43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 21:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVEXB43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 21:56:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59595 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261300AbVEXB41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 21:56:27 -0400
Message-ID: <429289C6.9080707@pobox.com>
Date: Mon, 23 May 2005 21:56:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brent Casavant <bcasavan@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ioc4: Driver rework
References: <20050523192157.V75588@chenjesu.americas.sgi.com>
In-Reply-To: <20050523192157.V75588@chenjesu.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


