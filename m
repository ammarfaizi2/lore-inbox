Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVFWVhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVFWVhO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:34:34 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:32955 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262681AbVFWVd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:33:27 -0400
Message-ID: <42BB2AA1.9000507@ens-lyon.org>
Date: Thu, 23 Jun 2005 23:33:21 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org> <20050620081443.GA31831@isilmar.linta.de> <42B6831B.3040506@ens-lyon.org> <20050620085449.GA32330@isilmar.linta.de> <42B6C06F.4000704@ens-lyon.org> <20050622163427.A10079@unix-os.sc.intel.com> <42BA55D2.7020900@ens-lyon.org> <20050623100536.A21592@unix-os.sc.intel.com> <42BAFADF.2030804@ens-lyon.org> <20050623133238.A24026@unix-os.sc.intel.com> <42BB247A.50506@ens-lyon.org>
In-Reply-To: <42BB247A.50506@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23.06.2005 23:07, Brice Goglin a écrit :
> Le 23.06.2005 22:32, Rajesh Shah a écrit :
> 
>>The host bridge resources being reported were fine. I think this
>>failure is a yenta bug exposed by the combination of the host
>>bridge resource collection patch and the patch to improve the
>>handling for transparent bridges. I think the yenta code thinks
>>there's a resource conflict for the ranges being decoded by the
>>cardbus bridge when in fact there isn't any conflict in this case.
>>It then claims and reprograms the cardbus bridge to IO resources
>>that are already programmed into another device (winmodem in this
>>case), causing problems.
>>
>>Does the following patch to 2.6.12-mm1 fix the problem?
> 
> 
> No, sorry, doesn't change anything.
> I still get a few "Preassigned resource 0 busy, reconfiguring..."
> followed by "parent PCI bridge I/O window: 0x2000 - 0x2fff" and
> then the system hangs right after "cs: IO probe 0x2000-0x2ffff;".

In case this matters, the messages are a little bit different.

-mm1 says (see http://lkml.org/lkml/2005/6/20/28) :

yenta 0000:02:03.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:03.0: no resource of type 1200 available, trying to
continue...
yenta 0000:02:03.0: Preassigned resource 1 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 2 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 3 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 3 busy, reconfiguring...

With your patch :

yenta 0000:02:03.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 0 busy, reconfiguring...
yenta 0000:02:03.0: no resource of type 1200 available, trying to
continue...
yenta 0000:02:03.0: Preassigned resource 1 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 1 busy, reconfiguring...
yenta 0000:02:03.0: no resource of type 200 available, trying to continue...
yenta 0000:02:03.0: Preassigned resource 2 busy, reconfiguring...
yenta 0000:02:03.0: Preassigned resource 2 busy, reconfiguring...
yenta 0000:02:03.0: no resource of type 100 available, trying to continue...
yenta 0000:02:03.0: Preassigned resource 3 busy, reconfiguring...

Brice
