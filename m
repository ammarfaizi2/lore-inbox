Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbTCTPMC>; Thu, 20 Mar 2003 10:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbTCTPLv>; Thu, 20 Mar 2003 10:11:51 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:38588 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S261538AbTCTPLo>; Thu, 20 Mar 2003 10:11:44 -0500
Message-ID: <3E79DE70.4050303@pacbell.net>
Date: Thu, 20 Mar 2003 07:29:52 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI MWI cacheline size fix
References: <20030320135950.A2333@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> This is rather conservative variant of previous patch:

Looks ok, and the previous patch behaved fine on the hardware
I could test it with.  The changes being: to set the cacheline
size only on the "prep_mwi" path (vs much earlier), and allow
cacheline size to be a multiple of the "real" one.


> - assume cacheline size of 32 bytes for all x86s except K7/K8 and P4.
>   Actually it's good for 386/486s as quite a few PCI devices do not support
>   smaller values.

Given the number of people that questioned that K7/K8/P4 logic,
I'd suggest putting that comment into the pcibios_init() code.


> If you all are fine with it, I can make a 2.4 counterpart.

Yes, having that avoid compile-time config is also important.

Thanks for updating this stuff -- it'll be good to know more
drivers can reduce their PCI/cache overheads.

- Dave

