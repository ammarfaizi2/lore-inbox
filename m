Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVDNRFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVDNRFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVDNRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:05:18 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:13273 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261559AbVDNREe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:04:34 -0400
Date: Thu, 14 Apr 2005 10:04:33 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Catalin Marinas <catalin.marinas@arm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Further copy_from_user() discussion.
In-Reply-To: <tnxzmw1d7io.fsf@arm.com>
Message-ID: <Pine.LNX.4.58.0504141001580.5403@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0504131342530.14888@shell4.speakeasy.net>
 <tnxzmw1d7io.fsf@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2005, Catalin Marinas wrote:

> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > 2. Would it be possible to eliminate the might_sleep() call in
> > copy_from_user()? It seems that, very soon after, the __copy_from_user()
> > macro does another might_sleep(), with very few instructions in between.
> > But there might be some trick here that I'm missing.
>
> might_sleep() is used for debugging the possible sleep while in an
> atomic operation. I think it is safe to check this for all the calls
> to copy_from_user(), no matter if the access is OK or not (memset
> being used in the latter case). The same is for
> __copy_from_user(). Anyway, if you don't enable
> CONFIG_DEBUG_SPINLOCK_SLEEP, the might_sleep() macro is empty.
>
> --
> Catalin
>

Thanks for the response.

I think I misspoke a bit in my email above. The intent was not to
eliminate all might_sleep() calls from the copy_from_user() code path;
but rather juggle the source around a bit so there is only one
might_sleep() call per each code path. Currently, in the default case,
it calls it twice.

By the way, is the following still true about might_sleep()?
http://kerneltrap.org/node/3440/10103

-Vadim Lobanov
