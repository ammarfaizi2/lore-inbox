Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUHBSuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUHBSuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHBSuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:50:13 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:37265 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261500AbUHBSuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:50:00 -0400
Message-ID: <410E8CF1.6030905@colorfullife.com>
Date: Mon, 02 Aug 2004 20:50:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org, Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro wrote:

>How about this for comparison?  That's just a dumb "convert to rwlock"
>patch; we can be smarter in e.g. close_on_exec handling, but that's a
>separate story.
>  
>
That won't help:
The problem is the cache line trashing from fget() and fget_light() with 
multithreaded apps. A sequence lock might help, but an rw lock is not a 
solution.
Actually: 2.4 had an rwlock, it was converted to a spinlock because 
spinlocks are faster on i386:

    read_lock();
    short operation();
    read_unlock();

is a bit slower than

    spin_lock();
    short operation();
    spin_unlock();

because read_unlock() is a full memory barrier and spin_unlock is not a 
memory barrier (not necessary because writes are ordered)

--
    Manfred
