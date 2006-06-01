Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbWFARes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbWFARes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWFARer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:34:47 -0400
Received: from rtr.ca ([64.26.128.89]:34254 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965239AbWFARer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:34:47 -0400
Message-ID: <447F2536.9030904@rtr.ca>
Date: Thu, 01 Jun 2006 13:34:46 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
References: <447EB0DC.4040203@cogweb.net> <20060601030140.172239b0.akpm@osdl.org>
In-Reply-To: <20060601030140.172239b0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 01 Jun 2006 02:18:20 -0700
> ..
>> This is generating a lot of grief and appears to be unnecessarily
>> strict. Common USB sticks with a MaxPower value just above 100mA, for
>> instance, typically work fine on unpowered hubs supplying 100mA.
>>
>> Is a more user-friendly solution possible? Could the shortfall
>> information be passed to udev, which would allow rules to be written per
>> device?
..
> Yes, it sounds like we're being non-real-worldly here.  This change
> apparently broke things.  Did it actually fix anything as well?

I think a far more sensible approach would be to just ensure that the
total current draw for the (unpowered) hub and all connected devices,
stays below the 500mA allowed.  So a 200mA device could coexist with
a 100mA device on a hub which itself steals 100mA.

Cheers
