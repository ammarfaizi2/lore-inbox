Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTLVP12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTLVP12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:27:28 -0500
Received: from stinkfoot.org ([65.75.25.34]:42146 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S264353AbTLVP11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:27:27 -0500
Message-ID: <3FE70D42.9070500@stinkfoot.org>
Date: Mon, 22 Dec 2003 10:26:58 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org
Subject: Re: minor e1000 bug
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD71@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD71@orsmsx402.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
>>--- linux-2.4.20/drivers/net/e1000/e1000_main.c~    
>>2003-08-03 00:40:21.000000000 +0200
>>+++ linux-2.4.20/drivers/net/e1000/e1000_main.c 2003-08-08 
>>+++ 13:20:06.000000000 +0200
>>@@ -1390,7 +1390,7 @@
>>        netif_stop_queue(netdev);
>> 
>>    /* Reset the timer */
>>-   mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
>>+   mod_timer(&adapter->watchdog_timer, jiffies + HZ);
>> }
> 
> 
> That should be OK if you're not linked at half duplex or using a 82541/7
> Ethernet controller.  e1000_smartspeed() and e1000_adaptive_ifs() are
> sensitive to the watchdog interval, so we'll need to make sure those are
> OK before adjusting the timer from 2 to 1 seconds.  This issue is
> tracker here: http://bugme.osdl.org/show_bug.cgi?id=1192.

This modification appears to somewhat remedy the problem, however, 
bandwidth measurement seems to be much more accurate with many other 
cards.  By what method does, say, the 3c59x card export its statistics 
to /proc/net/dev that makes it easier to measure?

Ethan

