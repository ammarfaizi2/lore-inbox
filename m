Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUFFNk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUFFNk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbUFFNk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:40:59 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:12700 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263626AbUFFNk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:40:58 -0400
Message-ID: <40C31ECD.9050304@colorfullife.com>
Date: Sun, 06 Jun 2004 15:40:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vincent van de Camp <vncnt@vzavenue.net>
CC: ktech@wanadoo.es, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <E1BWwTR-0003d0-I6@mb07.in.mad.eresmas.com> <40C313AE.10503@vzavenue.net>
In-Reply-To: <40C313AE.10503@vzavenue.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent van de Camp wrote:

> I do not use the forcedeth driver, but I do have IRQ 11 problems with 
> an nforce2 motherboard. I'm not entirely sure if this is the same 
> problem, but loading the ehci module (managed by hotplug) triggers the 
> kernel to disable IRQ 11. Dmesg with some stack traces:

It's the same bug:
something generates irq 11 events. We don't know who or why. This causes 
an irq storm as soon as the first user registeres a handler for irq 11  
and the system must shut off irq 11. Then all devices that are connected 
to irq 11 fail.

--
    Manfred

