Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266328AbUANXR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUANXQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:16:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:48622 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266328AbUANXQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:16:33 -0500
Message-ID: <4005C361.8050006@mvista.com>
Date: Wed, 14 Jan 2004 14:32:01 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net, discuss@x86-64.org,
       ak@suse.de, shivaram.upadhyayula@wipro.com,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401122020.08578.amitkale@emsyssoft.com> <40046296.1050702@mvista.com> <200401141854.23423.amitkale@emsyssoft.com>
In-Reply-To: <200401141854.23423.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Wednesday 14 Jan 2004 2:56 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>
>>>8250.patch changes generic 8250/16550 driver behavior only in following
>>>ways 1. It adds a function serial8250_release_irq to release those serial
>>>ports which share an irq with kgdb irq.
>>>2. There are checks so that a serial port that uses an irq used by an
>>>initialized kgdb can't be initialized or started.
>>>
>>>File kgdb_8250.c is independent of 8250.c kgdb_8250.c depends on
>>>KGDB_8250 and 8250.c depends on SERIAL_8250 which can be independently
>>>configured. kgdb_8250.c can be compiled even if 8250.c is not included.
>>>kgdb_8250.c does only the _minimum_ set of initializations required by
>>>hardware.
>>
>>Ok.
>>
>>
>>>Serial interface should be configurable independent of kgdb and may not
>>>be configured if ethernet interface is configured.  Serial interface is
>>>far simpler hence superior for debugging purposes. If it's available,
>>>using ethernet interface is out of question. Ethernet interface can be
>>>used when serial hardware isn't present or is being used for some other
>>>purposes.
>>
>>I rather think that the serial inteface should be the fall back unless the
>>user has told us at configure time that it is not available.  I am not
>>prepared to make a statment that it is better than eth.  The eth intface
>>should be much faster, but it has its fingers into a large part of the
>>kernel that MAY be the subject of the current session.  Thus, I think that
>>eth may be better, IF one is clearly not involved in debugging those areas
>>of the kernel.  (Which, by the way, we need to enumerate at some point.)
> 
> 
> Ethernet interface spans a large part of the kernel, so is going to be limited 
> in near future. When it becomes as minimal as the serial interface, both may 
> be given equal priority.
> 
> At 115kbps, serial interface is usable even when doing a thread list of 200 
> threads.

Only 200? :)

Yes, I agree, but the thing I see about the eth interface is that it allows much 
more remote debugging, like accrost the country, and it is every so much easier 
to set up.  I don't know about you, but my experience with rs232, which after 
all, can only be wired one of two ways, it that the probability of getting it 
wrong is about 90%.

-g
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

