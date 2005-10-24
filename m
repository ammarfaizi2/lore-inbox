Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVJXVgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVJXVgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVJXVgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:36:04 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:11751 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751308AbVJXVgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:36:02 -0400
Message-ID: <435D53AE.3020401@candelatech.com>
Date: Mon, 24 Oct 2005 14:35:42 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 2.6.13 0/5] normalize calculations of rx_dropped
References: <09122005104858.332@bilbo.tuxdriver.com> <4325CEAB.2050600@pobox.com> <20050912191419.GB19644@tuxdriver.com>
In-Reply-To: <20050912191419.GB19644@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Mon, Sep 12, 2005 at 02:53:31PM -0400, Jeff Garzik wrote:
> 
> 
>>For e.g. e1000, are we sure that packets dropped by hardware are 
>>accounted elsewhere?
> 
> 
> The e100 and tg3 patches move the count of those frames to
> rx_missed_errors.  e1000 and ixgb were already counting them there in
> addition to rx_discards, so they were simply removed from rx_discards.
> 3c59x was counting other errors in rx_discards, so they were removed
> from that count.

Whatever became of this discussion?  It seems that the e1000 driver
in 2.6.13.2 uses rx_errors as the total of all receive errors, while
the patch John was proposing broke them out into separate counters.

It doesn't matter too much to me either way, but I'd like for there to
be a precisely documented definition for the various net-stats so that
I can correctly show the values to user-space (I can certainly add rx_discards
to rx_errors for a 'total rx errors' value, but I need to know whether
rx_discards is already in rx_errors to keep from counting things twice.)

Jeff:  Could you lay down the law somewhere in the Documentation/
directory and then let us start fixing any driver that does it differently?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

