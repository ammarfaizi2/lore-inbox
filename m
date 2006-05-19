Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWESC0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWESC0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWESC0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:26:05 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:52914 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932164AbWESC0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:26:04 -0400
Message-ID: <446D2CA7.2070009@myri.com>
Date: Fri, 19 May 2006 04:25:43 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com> <200605180108.32949.arnd@arndb.de> <446D0994.8090103@myri.com> <200605190355.11230.arnd@arndb.de>
In-Reply-To: <200605190355.11230.arnd@arndb.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> Am Friday 19 May 2006 01:56 schrieb Brice Goglin:
>   
>> This place is actually the only one where we don't want to use msleep.
>> This function (myri10ge_send_cmd) might be called from various context
>> (spinlocked or not) and pass orders to the NIC whose processing time
>> depends a lot on the command. Of course, we don't have any place where a
>> long operation is passed from a spinlocked context :) But, we need the
>> tiny udelay granularity for the spinlocked case, and the long loop for
>> operations that are long to process in the NIC.
>>     
>
> I don't see any spinlocks in your code and the function does not
> seem to be called from the interrupt handler or the softirq either.
> Maybe I'm missed something, but where is this ever called in an
> atomic context?
>   

dev_mc_upload() from net/core/dev_mcast.c does

spin_lock_bh(&dev->xmit_lock);
__dev_mc_upload(dev);

which calls dev->set_multicast_list(), which is
myri10ge_set_multicast_list()

which calls myri10ge_change_promisc

which calls myri10ge_send_cmd



> Whenever you have a device associated with the message, it makes
> sense to use the dev_printk family of functions.
>   

Ok, thanks.

> My understanding is that vendor IDs should go to the common file
> because they are likely to be used by multiple drivers whereas
> device IDs only need to be present in the one device driver for
> that particular device.
>   

Make sense. I will change it.

Thanks again,
Brice

