Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTEGJG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbTEGJG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:06:59 -0400
Received: from mail.convergence.de ([212.84.236.4]:57507 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263012AbTEGJG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:06:58 -0400
Message-ID: <3EB8CFA2.5090405@convergence.de>
Date: Wed, 07 May 2003 11:19:30 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
References: <3EB7DCF0.2070207@convergence.de> <20030506214918.A18262@infradead.org>
In-Reply-To: <20030506214918.A18262@infradead.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

>>- partly reintroduced the DVB_DEVFS_ONLY switch, which was previously
>>wiped out by Alan Cox: if enabled, some really obscure code is not
>>compiled into the kernel that is necessary to xxx
> 
> 
> No, this is wrong.  I did remove it not Alan Cox and I removed it because
> kernel 2.5/2.6 should not behave differently whether devfs is used or
> not except nodes showing up in devfs.

The code does not behave differently. If DVB_DEVFS_ONLY is set, then the 
old chardev register interface is omitted.

We use the dvb subsystem on set-top-boxes where devfs is present only. 
The DVB_DEVFS_ONLY switch then lets us save some bytes and skips the 
"map-minor-to-actual-device" function stuff.

>>-	/* fixme: is this correct? */
>>-	try_module_get(THIS_MODULE);
>>+
> 
> 
> Just removing this makes the code even more incorrect.  You need to
> add a ->owner member and call try_module_get on it before calling into
> the module (and handle the return value..)

There is a functional dependency between the dvb-core and the actual dvb 
driver. So there is no need to increase the module count of the dvb-core 
if a new adapter is registered IMHO, because you cannot unload the 
dvb-core before the driver anyway.

>>-typedef struct dmxdev_dvr_s {
>>+typedef struct dmxdev_dvr {
>>         int state;
>>-        struct dmxdev_s *dev;
>>+        struct dmxdev *dev;
>>         dmxdev_buffer_t buffer;
>> } dmxdev_dvr_t;
> 
> 
> Once you rename everything you can nuke the typedef crap aswel..

Thanks, added to the TODO list.

CU
Michael.

