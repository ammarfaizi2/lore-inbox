Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTEOGad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTEOGad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:30:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36292 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261201AbTEOGac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:30:32 -0400
Message-ID: <3EC336FE.1030805@pobox.com>
Date: Thu, 15 May 2003 02:43:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [PATCH] iphase fix.
References: <200305150417.h4F4HTRA025809@hera.kernel.org> <3EC3359D.5050207@pobox.com>
In-Reply-To: <3EC3359D.5050207@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>>          dev_kfree_skb(skb);
>> -    else
>> -        netif_wake_queue(dev);
>> +    netif_wake_queue(dev);
>>      LEAVE("iph5526_send_packet");
> 
> 
> 
> This appears to revert a fix.
> 
> You only want to wake the queue if you have room to queue another skb.


Actually, I'm wrong.

But it could still use some looking-at.  You don't want to stop_queue at 
the beginning of send_packet and wake_queue at the end.  Instead, the 
queue should be awakened in the Tx completion routine, and the 
stop_queue should be moved from the beginning to the end of the function.

	Jeff



