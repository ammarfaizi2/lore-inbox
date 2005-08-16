Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVHPUVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVHPUVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 16:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVHPUVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 16:21:53 -0400
Received: from mail.aknet.ru ([82.179.72.26]:35087 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932698AbVHPUVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 16:21:52 -0400
Message-ID: <43024ADA.8030508@aknet.ru>
Date: Wed, 17 Aug 2005 00:21:46 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc][patch] API for timer hooks
References: <42FDF744.2070205@aknet.ru> <1124126354.8630.3.camel@cog.beaverton.ibm.com>
In-Reply-To: <1124126354.8630.3.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

john stultz wrote:
> Interesting. Could you explain why the soft-timer interface doesn't<>
> suffice?
I'll try to explain why *I think*
it doesn't suffice, please correct
me if my assumptions are wrong.

There are two (bad) things about the
PC-Speaker driver:
1. It needs the higher interrupt frequency.
Since there seem to be no API to change
the timer frequency at runtime, the driver
does this itself. Now I have googled out
the thread
[PATCH] i386: Selectable Frequency of the Timer Interrupt
but it doesn't look like it ended up
with some patch applied, or where is it?
2. It needs its handler to be executed
first in the chain. Otherwise the quality
is poor because of the latency.

My approach solves both problems by
introducing the grabbing ability.
This is a rather simple patch, and since
it allows to do some cleanup, I though
it could be usefull not only for the
speaker driver.
But if you can tell me how to achieve
at least the point 1 (that is, speed up the
timer at run-time quite arbitrary) without
the kernel mods, then it would be a real
salvation.

Any hints/pointers are appreciated.

