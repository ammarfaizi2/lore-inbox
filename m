Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTJPLlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTJPLlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:41:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262853AbTJPLlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:41:47 -0400
Message-ID: <3F8E83ED.9010608@pobox.com>
Date: Thu, 16 Oct 2003 07:41:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: wind@cocodriloo.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
References: <3F8E757A.5010008@pobox.com> <26145.1066303100@www7.gmx.net>
In-Reply-To: <26145.1066303100@www7.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman wrote:
> Yes, the 8139too driver is doing it's job correctly - I was just thinking

I didn't say this, because it is obviously not doing it job correctly.

It needs NAPI to do this.  For now, the driver _should_ stay up, even 
with these 'too much work...' messages.


> about the source of the starvation, ie the cause of the effect. I.e. the
> brokeness is elsewhere, in other drivers etc.

Quoting from my original reply:

	It's due to the 8139 hardware

Tons of tiny packets can be sent before RTL8139 will throttle, which can 
easily be far more than your system can handle at that particular time, 
especially if it's experiencing high load elsewhere.

You need either NAPI (perfect solution) or "cap interrupt work limit at 
X packets" (stopgap solution) to prevent your 8139 hardware from being 
DoS'd off the network.

	Jeff



