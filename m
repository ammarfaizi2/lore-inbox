Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFTNQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 09:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTFTNQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 09:16:10 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:12449 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261182AbTFTNQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 09:16:08 -0400
Message-ID: <3EF30C59.1070206@colorfullife.com>
Date: Fri, 20 Jun 2003 15:30:01 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Moore <neil@s-z.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unix code in Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil wrote:

>Is there any reason to replace this
>code? 
>
Yes, it's ugly as hell.
As far as I can see, the only user of ate_malloc are a few rmalloc 
calls. There is one rmalloc_align call, but afaics the function is not 
implemented.

The code is filled with #defines that rename linux functions - 
mutex_spinlock, spin_lock_destroy(), whatever.
There is so much renaming that they even create a prototype for a #define:

> arch/ia64/sn/io/sn1/pcibr.c
> L40: #define rmalloc atealloc
> L331: extern uint64_t rmalloc(struct map *mp, size_t size);

(it seems sn1 got killed recently, I searched in lxr.linux.no)

AFAICS ate_malloc should die, and the rmalloc callers should use 
request_resource & friends from <linux/ioport.h>.

--
    Manfred

