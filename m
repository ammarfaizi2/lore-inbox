Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVCXSO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVCXSO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbVCXSO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:14:27 -0500
Received: from byterapers.com ([195.156.109.210]:6602 "EHLO byterapers.com")
	by vger.kernel.org with ESMTP id S263141AbVCXSOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:14:14 -0500
Date: Thu, 24 Mar 2005 20:13:59 +0200 (EET)
From: Jakemuksen spammiosote <jhroska@byterapers.com>
To: David Brownell <david-b@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbnet.c, buf.overrun crash-bugfix, Kernel 2.6.12-rc1
In-Reply-To: <200503240857.28594.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.61.0503242006160.767@byterapers.com>
References: <Pine.LNX.4.61.0503241722160.30661@byterapers.com>
 <200503240857.28594.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, David Brownell wrote:
> On Thursday 24 March 2005 8:05 am, Jakemuksen spammiosote wrote:
>> Atleast versions 2.6.5 - 2.6.12-rc1 crash if an USB device using usbnet
>> sends oversized packet. Such packets occur most likely with broken
> Care to mention what device(s) you saw this with?   And what HCD?

I can't tell about the device(NDA), and don't remember the HCD and I can 
check it only after holidays.

>> +       if (unlikely((skb->tail + urb->actual_length) > skb->end)) {
> This logic looks wrong.  If that ever happens, surely the problem is
> that the rx_submit() code submitted an urb with transfer_size that
> mismatched the SKB.  The host controller isn't allowed to overrun the

Sounds reasonable. So, I'll go thru the HCD code instead if the 
responsibility is there. Am i the first one to run into such crash 
situation? If so, perhaps it's not ever worthy to fix in mainstream 
kernel, as the device causes the crash under very specific - 
'abusing' one might say, situation only.

