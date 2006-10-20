Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423240AbWJTVL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423240AbWJTVL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992720AbWJTVLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:11:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:9373 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1423236AbWJTVLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:11:23 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,336,1157353200"; 
   d="scan'208"; a="149688837:sNHT21422919"
Message-ID: <45393B0B.8090301@intel.com>
Date: Fri, 20 Oct 2006 14:09:31 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Auke Kok <auke-jan.h.kok@intel.com>
CC: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: [PATCH] e100_shutdown: netif_poll_disable hang
References: <20061020182820.978932000@mvista.com> <453936E0.1010204@intel.com>
In-Reply-To: <453936E0.1010204@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 21:11:22.0988 (UTC) FILETIME=[4BBC7AC0:01C6F48C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> Daniel Walker wrote:
>> My machine annoyingly hangs while rebooting. I tracked it down
>> to e100-fix-reboot-f-with-netconsole-enabled.patch in 2.6.18-rc2-mm2
>>
>> I review the changes and it seemed to be calling netif_poll_disable
>> one too many time. Once in e100_down(), and again in e100_shutdown().
>>
>> The second one in e100_shutdown() caused the hang. So this patch
>> removes it.

it doesn't even do harm to netif_poll_disable() twice as far as I can see, as it merely 
calls test_and_set_bit(), which will instantly succeed on the first attempt if the bit 
was already set.

did this change actually fix it for you? I'm wondering if the netif_carrier_off might 
not be the culprit here...

Auke
