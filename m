Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933956AbWKTGHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933956AbWKTGHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933955AbWKTGHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:07:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11190 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933951AbWKTGHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:07:53 -0500
Message-ID: <456145DA.804@redhat.com>
Date: Mon, 20 Nov 2006 01:06:18 -0500
From: Chris Snook <csnook@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] atl1: Build files for Attansic L1 driver
References: <20061119202915.GB29736@osprey.hogchain.net> <20061119152432.a85d4166.randy.dunlap@oracle.com>
In-Reply-To: <20061119152432.a85d4166.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Sun, 19 Nov 2006 14:29:15 -0600 Jay Cliburn wrote:
> 
>> From: Jay Cliburn <jacliburn@bellsouth.net>
>>
>> This patch contains the build files for the Attansic L1 gigabit ethernet
>> adapter driver.
>>
>> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
>> ---
>>
>>  Kconfig       |   12 ++++++++++++
>>  Makefile      |    1 +
>>  atl1/Makefile |   30 ++++++++++++++++++++++++++++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 6e863aa..f503d10 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -2329,6 +2329,18 @@ config QLA3XXX
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called qla3xxx.
>>  
>> +config ATL1
>> +	tristate "Attansic(R) L1 Gigabit Ethernet support (EXPERIMENTAL)"
>> +	depends on NET_PCI && PCI && EXPERIMENTAL
>> +	select CRC32
>> +	select MII
>> +	---help---
>> +	  This driver supports Attansic L1 gigabit ethernet adapter.
>> +
>> +	  To compile this driver as a module, choose M here.  The module
>> +	  will be called atl1.
>> +
>> +
>>  endmenu
> 
> One problem here is that MII depends on NET_ETHERNET, which is
> 10/100 ethernet, which may not be enabled if someone has only
> gigabit ethernet.  :)

I'm actually quite inclined to rip out all MII support entirely. 
There's a lot of code in this driver that needs cleaning up 
cosmetically, and removing deprecated features would certainly speed 
things up.  What do you think?

	-- Chris
