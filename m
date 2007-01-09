Return-Path: <linux-kernel-owner+w=401wt.eu-S932356AbXAISsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbXAISsk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXAISsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:48:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:19749 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356AbXAISsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:48:39 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,164,1167638400"; 
   d="scan'208"; a="183199984:sNHT20600986"
Message-ID: <45A3E380.2050709@intel.com>
Date: Tue, 09 Jan 2007 10:48:32 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.9 (X11/20061228)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH -MM] e1000: rewrite hardware initialization code
References: <45A3D29D.1000202@intel.com> <20070109103309.0b872a53@freekitty>
In-Reply-To: <20070109103309.0b872a53@freekitty>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2007 18:48:32.0947 (UTC) FILETIME=[C30DC030:01C7341E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Tue, 09 Jan 2007 09:36:29 -0800
> Auke Kok <auke-jan.h.kok@intel.com> wrote:
> 
>> Andrew, All,
>>
>> This patch contains a major rewrite to the e1000 driver that groups and separates e1000 
>> hardware by chipset family. It abstracts the hardware specific code into an API that 
>> will allow us to continue to maintain the complex e1000 driver and add new hardware 
>> support to it without touching code that affects older chipsets. 
> 
> Thats good. but:
> 
>>   drivers/net/e1000/Makefile            |   19
>>   drivers/net/e1000/e1000.h             |   95
>>   drivers/net/e1000/e1000_80003es2lan.c | 1330 +++++
>>   drivers/net/e1000/e1000_80003es2lan.h |   89
>>   drivers/net/e1000/e1000_82540.c       |  586 ++
>>   drivers/net/e1000/e1000_82541.c       | 1164 ++++
>>   drivers/net/e1000/e1000_82541.h       |   86
>>   drivers/net/e1000/e1000_82542.c       |  466 ++
>>   drivers/net/e1000/e1000_82543.c       | 1397 +++++
>>   drivers/net/e1000/e1000_82543.h       |   45
>>   drivers/net/e1000/e1000_82571.c       | 1132 ++++
>>   drivers/net/e1000/e1000_82571.h       |   42
>>   drivers/net/e1000/e1000_api.c         | 1077 ++++
>>   drivers/net/e1000/e1000_api.h         |  159 +
>>   drivers/net/e1000/e1000_defines.h     | 1289 +++++
>>   drivers/net/e1000/e1000_ethtool.c     |  470 +-
>>   drivers/net/e1000/e1000_hw.c          | 9038 ---------------------------------
>>   drivers/net/e1000/e1000_hw.h          | 3859 ++------------
>>   drivers/net/e1000/e1000_ich8lan.c     | 2353 +++++++++
>>   drivers/net/e1000/e1000_ich8lan.h     |  108
>>   drivers/net/e1000/e1000_mac.c         | 1921 +++++++
>>   drivers/net/e1000/e1000_mac.h         |   84
>>   drivers/net/e1000/e1000_main.c        | 1002 ++--
>>   drivers/net/e1000/e1000_manage.c      |  387 +
>>   drivers/net/e1000/e1000_manage.h      |   83
>>   drivers/net/e1000/e1000_nvm.c         |  860 +++
>>   drivers/net/e1000/e1000_nvm.h         |   61
>>   drivers/net/e1000/e1000_osdep.h       |   56
>>   drivers/net/e1000/e1000_param.c       |  115
>>   drivers/net/e1000/e1000_phy.c         | 1932 +++++++
>>   drivers/net/e1000/e1000_phy.h         |  157 +
>>   drivers/net/e1000/e1000_regs.h        |  236 +
>>   32 files changed, 18538 insertions(+), 13160 deletions(-)
> 
> Is lots of little files really progress?
> 

I can think of a few files that we could merge myself, but we really wanted to get away 
from the two large (e1000_hw) files that we had, which was far worse.

We're open to suggestions as to reduce the amount of files, but since e1000 has it's own 
subdirectory, and supports a large amount of files, I think we're in the right direction 
with the amount. We approached it this from a rather superfluous amount of files 
standpoint knowing we can merge some later anyway.

One thing we've contemplated ourselves was to merge the smaller .h files into the .c 
files where applicable, so your comment goes duly noted

Thanks,

Auke




