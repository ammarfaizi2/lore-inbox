Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUHXIGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUHXIGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 04:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHXIGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 04:06:51 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:12761 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267248AbUHXIGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 04:06:19 -0400
Date: Tue, 24 Aug 2004 17:06:13 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [RFC&PATCH 1/2] PCI Error Recovery (readX_check)
In-reply-to: <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <412AF6F5.6020806@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
References: <412AD123.8050605@jp.fujitsu.com>
 <Pine.LNX.4.58.0408232231070.17766@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I'd suggest changing the locking a bit.
> 
> Just make "clear_pci_errors()" take a spinlock on the bridge, and 
> "read_pci_errors()" unlock it. We need to make sure that if multiple 
> devices on the same bridge try to be careful, they can do so without 
> seeing each others errors.

... Why spinlock?
Are rwlocks not smart way to decrease the impact on I/O performance?

> I'd also suggest that you make "clear_pci_errors()" return a cookie for 
> read_pci_errors() to use. 

What I can only imagine is... passing somthing like a identifier of
looking bridge to driver as cookie, functionally, it's sounds good.
... Are there any other useful usages of the cookie?

> Also, I assume that the thing would support (and please make the
> documentation clear on it) multiple IO operations between a
> "clear_pci_errors()" and it's ending "read_pci_errors()" pair.

Sure.
So taking a spinlock between this pair clearly means long time locking on
I/O, this will block all other I/O under same bridge, I think this isn't
good situation.  Still do we take a spinlock?


Thanks,
H.Seto
