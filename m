Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWESJck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWESJck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWESJck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:32:40 -0400
Received: from webapps.arcom.com ([194.200.159.168]:11533 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751317AbWESJcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:32:39 -0400
Message-ID: <446D90B5.2090802@arcom.com>
Date: Fri, 19 May 2006 10:32:37 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jonathan McDowell <noodles@earth.li>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
References: <20060518160940.GS7570@earth.li>	<20060518165728.GA26113@wohnheim.fh-wedel.de> <20060519090142.GB7570@earth.li>
In-Reply-To: <20060519090142.GB7570@earth.li>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 May 2006 09:32:37.0355 (UTC) FILETIME=[2A7F13B0:01C67B27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan McDowell wrote:
> On Thu, May 18, 2006 at 06:57:28PM +0200, Jörn Engel wrote:
>> On Thu, 18 May 2006 17:09:41 +0100, Jonathan McDowell wrote:
>>> +	omap_writew(0, (OMAP_MPUIO_BASE + OMAP_MPUIO_IO_CNTL));
>>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Could that be done in a macro?
> 
> Is there any benefit to doing so?
> 
>>> +	udelay(0.04);
>> Floating point in the kernel?
> 
> Not quite. udelay is a macro on ARM so this ends up as an integer before
> it ever hits a function call. In an ideal world I'd use "ndelay(40);"
> but that would result in a delay of over 1µs as ARM doesn't have ndelay
> defined so we hit the generic fallback.

Use instead:

/* delay for at least 40 ns */
udelay(1);

Or better yet provide an ndelay implementation for ARM.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
