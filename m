Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936037AbWK1TM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936037AbWK1TM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936038AbWK1TM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:12:56 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:61891
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S936037AbWK1TMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:12:55 -0500
Date: Tue, 28 Nov 2006 11:13:00 -0800 (PST)
Message-Id: <20061128.111300.105813754.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com, hch@infradead.org, chase.venters@clientec.com,
       johann.borck@densedata.com, linux-kernel@vger.kernel.org,
       jeff@garzik.org, aviro@redhat.com
Subject: Re: Kevent POSIX timers support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061128091602.GC15083@2ka.mipt.ru>
References: <456B3016.9020706@redhat.com>
	<20061127.104955.48519839.davem@davemloft.net>
	<20061128091602.GC15083@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Tue, 28 Nov 2006 12:16:02 +0300

> Although ukevent has pointer embedded, it is unioned with u64, so there
> should be no problems until 128 bit arch appeared, which likely will not
> happen soon. There is also unused in kevent posix timers patch
> 'u32 ret_val[2]' field, which can store segval's value too.
> 
> But the fact that ukevent does not and will not in any way have variable
> size is absolutely.

I believe that in order to be %100 safe you will need to use the
special aligned_u64 type, as that takes care of a crucial difference
between x86 and x86_64 API, namely that u64 needs 8-byte alignment on
x86_64 but not on x86.

You probably know this already :-)
