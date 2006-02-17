Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWBQUNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWBQUNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWBQUNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:13:09 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:9926 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1751672AbWBQUNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:13:07 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYz/oqKOArFDPMYTCGixpL8V1Z8QA==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F62E44.2090109@bfh.ch>
Date: Fri, 17 Feb 2006 21:12:52 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Don Fry" <brazilnut@us.ibm.com>
Cc: <tsbogend@alpha.franken.de>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] pcnet32: Introduce basic AT 2700/01 FTX support
References: <43F5F66F.6040608@bfh.ch> <20060217182104.GA19257@us.ibm.com>
In-Reply-To: <20060217182104.GA19257@us.ibm.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 20:12:56.0213 (UTC) FILETIME=[8A545450:01C633FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Don Fry wrote:
> Philippe,
> 
> On a purely mechanical note, the patches do not apply cleanly because
> of whitespace changes.  Possibly your mailer changed tabs to spaces,
> which causes the patch not to apply, and also causes your patch to have
> different spacing than the rest of the file.  The driver does not
> conform to the 8-space indentation guideline/rule, but it is consistent
> in 4-space indentation.
uhhh.... did i forget to run Lindent..? Or was it that i just
selected-middle clicked them into thunderbird?
what's the recommended procedure oh how to append patches to
mails? (Documentation just says included not attached...)
> 
> I am looking over this change and the following one, to try and
> understand what and why you made your changes.
> 
> The change made by Thomas Bogendoerfer and modified by myself is much
> more flexible than your changes, in that they are not specific just to
> the Allied Telesyn boards with multiple Phys.
I'm not sure what you are talking about. I didn't see any PHY switching
code in the driver... And the specs specifically say that when more than
one PHY is connected control should revert to software.

> They also allow dynamic
> changing of cabling without requiring the driver to be removed/installed
> or the card power cycled.  I also see little value in the module
> parameters, when it can be determined dynamically. Also, maxphy might be
> thought to the the maximum number of phys, rather than the maximum phy
> number supported.  If static selection of the phy to use is passed in as
> a module parameter, why also include a maxphy?
maxphy is supposed to be how many PHYs are actually connected to the chip.
I didn't want to introduce a generic PHY scanner (which is possible)
because that would have haa impact on all cards not only cards that actually
have more than one phy.

I really tried to put this into pcnet32_open. But i just didn't work...

> 
> As I review your patches I will follow up to the mailing list.
> 
> On Fri, Feb 17, 2006 at 05:14:39PM +0100, Seewer Philippe wrote:
> 
>>This patch extends Don Fry's last patch for AT 2700/01 FX to set the
>>speed/fdx options for the FTX variants of these cards as well.
>>
>>Additionally the option override has been moved from pcnet32_open to
>>pcnet32_probe1 because it's only necessary to override the options once.
>>
>>Tested and works.
>>
>>Patch applies to 2.6.16-rc3
>>
> 
> Don Fry
> brazilnut@us.ibm.com
