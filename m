Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVKDHAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVKDHAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVKDHAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:00:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30390 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751399AbVKDHAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:00:07 -0500
Message-ID: <436B06F3.80209@pobox.com>
Date: Fri, 04 Nov 2005 02:00:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Parallel ATA with libata status with the patches I'm working
 on
References: <1131029686.18848.48.camel@localhost.localdomain> <1131086585.4680.235.camel@gaston>
In-Reply-To: <1131086585.4680.235.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>- HPA
>>- IRQ mask
> 
> 
> Why do we need the above at all ? It always looked to me like a gross
> hack but then, I don't fully understand what the problem was on those
> old x86 that needed it :)


Not sure about IRQ mask.

For host-protected area (HPA), I've been thinking about a dm-hpa driver, 
which libata causes to auto-attach to the libata-discovered disks during 
probe.

That gives people full access to the disk (and to the HPA), while 
ensuring that there are no partition mismatch issues.

Not sure how well it will work out in practice, but it's worth thinking 
about.

If auto-attach/etc. doesn't work, I lean towards defaulting libata to 
enable access to the HPA, under the philosophy "export 100% of the 
hardware".  Then an interested party could create an optional dm-hpa 
piece, to split 100%-of-the-hardware into two pieces, one a 
partitionable device, and the other, the HPA.

	Jeff


