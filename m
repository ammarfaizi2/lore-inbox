Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWDHOKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWDHOKl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 10:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWDHOKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 10:10:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24409 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750901AbWDHOKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 10:10:40 -0400
Date: Sat, 08 Apr 2006 08:10:38 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-reply-to: <5Zd5E-3vi-7@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Neil Brown <neilb@suse.de>
Message-id: <4437C45E.8010503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Zd5E-3vi-7@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
>  However there is room for a race here.  If an event occurs between
>  the read and the write, then this will NOT de-assert the IRQ line.
>  It will remain asserted throughout.
> 
>  Now if the IRQ is handled as an edge-triggered line (which I believe
>  they are in Linux), then losing this race will mean that we don't see
>  any more interrupts on this line.

PCI interrupts should always be level triggered, not edge triggered 
(except maybe in a few special cases - non-native-mode PCI IDE maybe? 
and in those cases I don't think the interrupt is considered sharable). 
With a level triggered interrupt the ISR will simply be triggered again 
and the event handled in this case so there is no race. I think this 
patch is going to double interrupt overhead and only covers up some 
other problem.

I think that in cases where the interrupt is edge triggered and is 
shared (for example on ISA cards that support it) the kernel already has 
such logic as you describe.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

