Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWESPtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWESPtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWESPty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:49:54 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:16617 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932406AbWESPtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:49:03 -0400
Message-ID: <446DE8CF.7050603@myri.com>
Date: Fri, 19 May 2006 17:48:31 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, gallatin@myri.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com> <446D2CA7.2070009@myri.com> <200605191200.47132.arnd@arndb.de> <200605191309.30992.ak@suse.de>
In-Reply-To: <200605191309.30992.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 19 May 2006 12:00, Arnd Bergmann wrote:
>   
>> On Friday 19 May 2006 04:25, Brice Goglin wrote:
>>     
>>> dev_mc_upload() from net/core/dev_mcast.c does
>>>
>>> spin_lock_bh(&dev->xmit_lock);
>>> __dev_mc_upload(dev);
>>>
>>> which calls dev->set_multicast_list(), which is
>>> myri10ge_set_multicast_list()
>>>
>>> which calls myri10ge_change_promisc
>>>
>>> which calls myri10ge_send_cmd
>>>       
>> Hmm, if that is the only path where you call it, it may be
>> helpful to change myri10ge_change_promisc to call a special
>> atomic version of myri10ge_send_cmd then, while all others
>> use the regular version, which you can then convert to
>> do msleep as well.
>>     
>
> Or just drop the xmit lock while you do that. As long as you
> handle races with ->start_xmit yourself it's ok
>   

Looks like we can do that.
Thanks,
Brice

