Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWHANKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWHANKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWHANKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:10:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2019 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751242AbWHANKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:10:39 -0400
Subject: Re: [HW_RNG] How to use generic rng in kernel space
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: mb@bu3sch.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060801120937.69641.qmail@web25813.mail.ukl.yahoo.com>
References: <20060801120937.69641.qmail@web25813.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 14:29:54 +0100
Message-Id: <1154438995.15540.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-01 am 12:09 +0000, ysgrifennodd moreau francis:
> Another question about the implementation. If O_NONBLOCK
> flag is passed when opening /dev/hw_random, how does the
> read method ensure that the caller won't sleep since it calls
> mutex_lock_interruptible() function unconditiannaly ? I must
> miss something but don't know what...

O_NONBLOCK doesn't necessarily imply "never sleep", it implies "don't
sleep waiting for an event/long time". So where the mutex is just
serializing access to hardware that will be very brief it is fine not to
check O_NONBLOCK/FNDELAY.


