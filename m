Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbVBDN4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVBDN4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbVBDNxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:53:20 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:49806
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S264431AbVBDNvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:51:53 -0500
Message-ID: <42037DAA.6030007@microgate.com>
Date: Fri, 04 Feb 2005 07:50:34 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Martin_K=F6gler?= <e9925248@student.tuwien.ac.at>
CC: Andrew Morton <akpm@osdl.org>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Deadlock in serial driver 2.6.x
References: <20050126132047.GA2713@stud4.tuwien.ac.at> <20050126231329.440fbcd8.akpm@osdl.org> <1106844084.14782.45.camel@localhost.localdomain> <20050130164840.D25000@flint.arm.linux.org.uk> <1107157019.14847.64.camel@localhost.localdomain> <20050131004857.07f5e2c4.akpm@osdl.org> <1107332396.14847.112.camel@localhost.localdomain> <20050203102112.06c06fe7.akpm@osdl.org> <20050204110725.GA16534@stud4.tuwien.ac.at>
In-Reply-To: <20050204110725.GA16534@stud4.tuwien.ac.at>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Kögler wrote:
> As a temporary workaround, dropping the lock should also work:

This looks good to me, and seems much more reasonable
that changing driver interfaces.

Treat tty_flip_buffer_push(tty) as something that
can call back into your driver (which *is* the case for low_latency),
so don't do anything that can cause a deadlock
when you call it.

-- 
Paul Fulghum
Microgate Systems, Ltd.
