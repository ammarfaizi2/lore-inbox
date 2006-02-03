Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWBCKAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWBCKAt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBCKAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:00:49 -0500
Received: from science.horizon.com ([192.35.100.1]:56619 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932224AbWBCKAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:00:48 -0500
Date: 3 Feb 2006 05:00:47 -0500
Message-ID: <20060203100047.19337.qmail@science.horizon.com>
From: linux@horizon.com
To: rmk+lkml@arm.linux.org.uk
Subject: Re: 8250 serial console fixes -- issue
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  - 'r' option has insanely slow CTS timeout. So if a
>>    terminal server is inactive the kernel can take
>>    30 minutes to boot as each character write to the
>>    serial console requires a CTS timeout.
>
> You'd rather we threw away these messages?

It seems to me that The Right Thing to do is, once I've given up on
CTS showing up and just sent the byte anyway, is send all future bytes
without waiting for CTS until CTS shows up again.

In other words, one timeout per falling edge of CTS.

This may be implementable neatly by just saying "fuck it; pretend CTS
is asserted" in the timeout handler if the later real assertion won't
confuse it.
