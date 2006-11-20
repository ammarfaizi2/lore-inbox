Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933952AbWKTGCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933952AbWKTGCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933951AbWKTGCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:02:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933938AbWKTGC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:02:29 -0500
Message-ID: <456144C1.8040809@redhat.com>
Date: Mon, 20 Nov 2006 01:01:37 -0500
From: Chris Snook <csnook@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, romieu@fr.zoreil.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
References: <20061119203006.GC29736@osprey.hogchain.net> <Pine.LNX.4.61.0611192233270.6324@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0611192233270.6324@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Nov 19 2006 14:30, Jay Cliburn wrote:
>> +
>> +#define	LBYTESWAP( a )  ( ( ( (a) & 0x00ff00ff ) << 8 ) | ( ( (a) & 0xff00ff00 ) >> 8 ) )
>> +#define	LONGSWAP( a )	( ( LBYTESWAP( a ) << 16 ) | ( LBYTESWAP( a ) >> 16 ) )
>> +#define	SHORTSWAP( a )	( ( (a) << 8 ) | ( (a) >> 8 ) )
> 
> Please use swab16/swab32 for these.

Thanks for pointing this out.  There's a lot of self-rolled stuff in the 
vendor driver, and we haven't removed it all yet.  That one should be 
easy though.

>> +#define AT_DESC_UNUSED(R) \
>> +	((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
>> +	(R)->next_to_clean - (R)->next_to_use - 1)
>> +
>> +#define AT_DESC_USED(R) \
>> +	(((R)->next_to_clean > (R)->next_to_use) ?	\
>> +		((R)->count+(R)->next_to_use-(R)->next_to_clean+1) : \
>> +		((R)->next_to_use-(R)->next_to_clean+1))
> 
> These look like they are on the edge to be written as a static-inline function.
> What do others think?

I agree.  There's a lot of cosmetic work left to do on this driver, but 
we felt it was time to get more eyes on it.

>> +#define AT_WRITE_REG(a, reg, value) ( \
>> +	writel((value), ((a)->hw_addr + reg)))
>> +
>> +#define AT_READ_REG(a, reg) ( \
>> +	readl((a)->hw_addr + reg ))
>> +
>> +#define AT_WRITE_REGB(a, reg, value) (\
>> +	writeb((value), ((a)->hw_addr + reg)))
>> +
>> +#define AT_READ_REGB(a, reg) (\
>> +	readb((a)->hw_addr + reg))
>> +
>> +#define AT_WRITE_REGW(a, reg, value) (\
>> +	writew((value), ((a)->hw_addr + reg)))
>> +
>> +#define AT_READ_REGW(a, reg) (\
>> +	readw((a)->hw_addr + reg))
>> +
>> +#define AT_WRITE_REG_ARRAY(a, reg, offset, value) ( \
>> +	writel((value), (((a)->hw_addr + reg) + ((offset) << 2))))
>> +
>> +#define AT_READ_REG_ARRAY(a, reg, offset) ( \
>> +	readl(((a)->hw_addr + reg) + ((offset) << 2)))
> 
> Possibly similarly.

Yeah, we'll inline these as well.  Would you say that level of cosmetic 
cleanliness is required for merging, or should we focus solely on the 
functional issues for now?

	-- Chris
