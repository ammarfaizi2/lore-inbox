Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWFBXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWFBXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFBXXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:23:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:5084 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751039AbWFBXXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:23:07 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4480C7F4.907@s5r6.in-berlin.de>
Date: Sat, 03 Jun 2006 01:21:24 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Collins <bcollins@ubuntu.com>
CC: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: [PATCH 2.6.17-rc5-mm2 17/18] sbp2: provide helptext	for	CONFIG_IEEE1394_SBP2_PHYS_DMA
 and mark it experimental
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de> <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de> <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de> <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de> <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de> <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de> <tkrat.f35772c971022262@s5r6.in-berlin.de> <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de> <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de> <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de> <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de> <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de> <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de> <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de> <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de> <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de> <tkrat.96e1b392429fe277@s5r6.in-berlin.de> <tkrat.df90273c07dd7503@s5r6.in-berlin.de> <1149281162.4533.304.camel@grayson> <4480B45E.4060909@s5r6.in-berlin.de> <1149286809.4533.319.camel@grayson>
In-Reply-To: <1149286809.4533.319.camel@grayson>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.882) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> Rather it be in the config. Plus your suggestion still makes it
> unusable :)

Right. But only if ohci1394 is loaded with phys_dma=0 or a controller 
without phys DMA is used. Only these conditions let sbp2 run into the 
routine which currently uses bus_to_virt.

Right now, sbp2 is unusable _on all platforms_ if these conditions apply 
and if CONFIG_IEEE1394_SBP2_PHYS_DMA=N.

The previously sent "address range properties" patches would allow sbp2 
to check for phys DMA at runtime. If phys DMA is off, sbp2 may either 
proceed to use the old bus_to_virt mapping or say: "Sorry lad, I won't 
connect unless you get this phys DMA thing going." (Until sbp2 learns 
platform independent DMA mapping.) IOW we could get rid of the 
CONFIG_IEEE1394_SBP2_PHYS_DMA switch immediately.

But since the non-phys-DMA mode of sbp2 is currently prone to lock-ups, 
runtime detection of non-phys-DMA is of lower priority to me.

> I suggest instead doing '&& X86_32'. That should affect the least people
> and keep it where it's known to work.

Would '&& (X86_32 || PPC_32)' work too?
-- 
Stefan Richter
-=====-=-==- -==- ---==
http://arcgraph.de/sr/
