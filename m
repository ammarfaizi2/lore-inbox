Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWBKIjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWBKIjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 03:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBKIjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 03:39:45 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:28084 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932245AbWBKIjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 03:39:45 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43EDA2A5.6000901@s5r6.in-berlin.de>
Date: Sat, 11 Feb 2006 09:39:01 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at	drivers/ieee1394/ohci1394.c:235/get_phy_reg()
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>	 <20060210122131.4b98cfb4.akpm@osdl.org>	 <43ED3046.6020407@s5r6.in-berlin.de> <1139625039.19342.49.camel@mindpipe>
In-Reply-To: <1139625039.19342.49.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.519) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sat, 2006-02-11 at 01:31 +0100, Stefan Richter wrote:
>>Andrew Morton wrote:
>>>That's a -mm-only warning telling you that get_phy_reg() is doing a
>>>one-millisecond-or-more busywait while local interrupts are disabled.
>>
>>Same with set_phy_reg, ohci_soft_reset, ohci_hw_csr_reg.
[...]
> In fact I'm pretty sure we have seen reports on the linux-audio-user
> list of apps reporting underruns when a 1394 drive is accessed.

These might have different causes. The 1394 storage driver, sbp2, 
performs quite a lot of protocol handling in IRQ or soft IRQ context. I 
have been planning to move this off into process context -- not really 
because of potential latency issues but for sake of more reliable 
protocol handling. I hope I get to it RSN.

AFAICS the offending ohci1394 functions mentioned above are never called 
during normal access to an SBP-2 device. They only happen when a host 
adapter is initialized or shut down or whenever a 1394 device is plugged 
in or out (actually whenever self ID reception is completed).
-- 
Stefan Richter
-=====-=-==- --=- -=-==
http://arcgraph.de/sr/
