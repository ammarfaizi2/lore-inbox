Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966805AbWKTVgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966805AbWKTVgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966807AbWKTVgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:36:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:24489 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966805AbWKTVgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:36:54 -0500
Message-ID: <45621FEB.204@garzik.org>
Date: Mon, 20 Nov 2006 16:36:43 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Arnd Bergmann <arnd@arndb.de>, Chris Snook <csnook@redhat.com>,
       Jay Cliburn <jacliburn@bellsouth.net>, romieu@fr.zoreil.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
References: <20061119203050.GD29736@osprey.hogchain.net>	<200611200057.45274.arnd@arndb.de>	<45614769.4020005@redhat.com>	<200611201322.00495.arnd@arndb.de>	<20061120100202.6a79e382@freekitty>	<4562036E.3020409@garzik.org> <20061120121524.68cf39d8@freekitty>
In-Reply-To: <20061120121524.68cf39d8@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Mon, 20 Nov 2006 14:35:10 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Stephen Hemminger wrote:
>>> Using common MII code is good, but one problem with the existing MII code is that
>>> it doesn't work when device is down. This makes it impossible to set speed/duplex
>>> before device comes up.
>>
>> That's not true at all.  drivers/net/mii.c uses caller-provided locking 
>> in all cases, and there is nothing that prevents the common code from 
>> being called when the interface is down.
>>
>> You are probably thinking about all the netif_running() checks found in 
>> the drivers, particularly in the ->begin() hook.
>>
>> 	Jeff
>>
>>
> 
> Yeah it is a driver specific thing. All users of mii seem to block changes so
> I thought it was in base code.

Yeah.  As a bit of history, a lot of drivers would power down the phy 
when the interface was down, and so MII would need to be inaccessible. 
But that's really a driver policy thing.  If the driver provides a 
"don't power down phy, when interface is downed" knob, maybe it would 
want to support MII operations when !netif_running().

	Jeff



