Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVHYVQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVHYVQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVHYVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:16:19 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:25281 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751475AbVHYVQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:16:18 -0400
Date: Thu, 25 Aug 2005 14:16:17 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Christopher Friesen <cfriesen@nortel.com>
cc: linux-kernel@vger.kernel.org, tom.anderl@gmail.com
Subject: Re: [OT] volatile keyword
In-Reply-To: <430E30B2.1020700@nortel.com>
Message-ID: <Pine.LNX.4.58.0508251414350.19866@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
 <430E30B2.1020700@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Christopher Friesen wrote:

> Vadim Lobanov wrote:
>
> > I'm positive I'm doing something wrong here. In fact, I bet it's the
> > volatile cast within the loop that's wrong; but I'm not sure how to do
> > it correctly. Any help / pointers / discussion would be appreciated.
>
> You need to cast is as dereferencing a volatile pointer.
>
> Chris
>

I figured it was something along these lines. In that case, is the
following code (from kernel/posix-timers.c) really doing the right
thing?

do
    expires = timr->it_timer.expires;
while ((volatile long) (timr->it_timer.expires) != expires);

Seems it's casting the value, not the pointer.

-VadimL
