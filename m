Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbVIHPdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbVIHPdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVIHPdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:33:15 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:45784
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932701AbVIHPdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:33:14 -0400
Message-ID: <432059A2.4030209@microgate.com>
Date: Thu, 08 Sep 2005 10:32:50 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] synclink.c compiler optimiation fix
References: <1126112543.3984.17.camel@deimos.microgate.com> <20050908135211.GB8676@infradead.org>
In-Reply-To: <20050908135211.GB8676@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> The structure is in ioremaped memory so you must
> use reads/writes to access them instead.

Yes, using read/write eliminates the compiler optimization
and makes the driver portable to other architectures.
That change is much more extensive, and it may be
a while before I can do a major rewrite of the driver.
The volatile change allows the existing driver to work.

 > volatile usage in drivers
> is never okay - if you are accessing I/O memory you need to use
> proper acessors, if it is normal memory and you want atomic sematics
> you need to use the atomic_t type and the operators defined on it.

This is not a matter of atomicity.
It is a matter of hardware DMA causing the
value to change without the compiler's knowledge.

If I have a DMA descriptor in normal memory (not the
case in the above driver, but it is the case in
another driver I maintain) that has fields that
do not conform to atomic_t, using volatile seems
a valid way of preventing the compiler from
optimizing access to the field out of a loop.

-- 
Paul Fulghum
Microgate Systems, Ltd.
