Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTHCTtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 15:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbTHCTtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 15:49:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269191AbTHCTtL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 15:49:11 -0400
Message-ID: <3F2D6727.8070203@pobox.com>
Date: Sun, 03 Aug 2003 15:48:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Abraham van der Merwe <abz@frogfoot.net>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: Re: sleeping in dev->tx_timeout?
References: <20030803183707.GA13728@oasis.frogfoot.net> <Pine.LNX.4.53.0308031505390.3473@montezuma.mastecende.com> <20030803193708.GA13992@oasis.frogfoot.net>
In-Reply-To: <20030803193708.GA13992@oasis.frogfoot.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham van der Merwe wrote:
> Hi Zwane                                         >@2003.08.03_21:10:56_+0200
> 
> 
>>>Is it safe to sleep in tx_timeout (in the networking code), i.e. to call
>>>schedule_timeout and friends from that routine?
>>
>>No it's called from softirq context and with the dev->xmit_lock held in 
>>places.
> 
> 
> That's what I thought. How are you supposed to wait for long periods from
> tx_timeout? My problem is that I have a chip reset which takes around 10ms
> (i.e. too long to use mdelay())

Simple answer, don't wait in tx_timeout :)

These days drivers often need quite a while for hardware reset.  I am 
pushing to move this code, long term, into process context.  So, in 
tx_timeout:
* disable NIC and interrupts as best you can, quickly
* schedule_task/schedule_work to schedule the full hardware reset

	Jeff




