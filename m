Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbUELUZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUELUZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbUELUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:25:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19081 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263698AbUELUZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:25:11 -0400
Message-ID: <40A28815.2020009@pobox.com>
Date: Wed, 12 May 2004 16:24:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, davidel@xmailserver.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <20040512020700.6f6aa61f.akpm@osdl.org>	<20040512181903.GG13421@kroah.com>	<40A26FFA.4030701@pobox.com>	<20040512193349.GA14936@elte.hu>	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>	<20040512200305.GA16078@elte.hu> <20040512132050.6eae6905.akpm@osdl.org>
In-Reply-To: <20040512132050.6eae6905.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Yes, that's a correct optimisation.  This is simply a namespace clash.

Agreed.


> How about we do:
> 
> #if HZ=1000
> #define	MSEC_TO_JIFFIES(msec) (msec)
> #define JIFFIES_TO_MESC(jiffies) (jiffies)
> #elif HZ=100
> #define	MSEC_TO_JIFFIES(msec) (msec * 10)
> #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
> #else
> #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
> #define	JIFFIES_TO_MSEC(jiffies) ...
> #endif
> 
> in some kernel-wide header then kill off all the private implementations?


include/linux/time.h.  One of the SCTP people already did this, but I 
suppose it's straightforward to reproduce.

	Jeff



