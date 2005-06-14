Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVFNT3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFNT3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFNT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:29:17 -0400
Received: from mail.aknet.ru ([82.179.72.26]:30475 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261304AbVFNT3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:29:00 -0400
Message-ID: <42AF2FFC.8010601@aknet.ru>
Date: Tue, 14 Jun 2005 23:29:00 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] pcspeaker driver update
References: <42AF25C7.90109@aknet.ru> <20050614185535.GA4041@ucw.cz>
In-Reply-To: <20050614185535.GA4041@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Vojtech Pavlik wrote:
>> - changes the pcspeaker driver to
>> use the i8253_lock instead of i8253_beep_lock
> This doesn't seem right. The driver programs an independent part of the
> chip and I don't see a reason to cause the time code to wait because
> we're trying to do a beep.
Yes, you program 0x42 which is independant,
but, unless I am missing something, you also
touch 0x43 and 0x61, which are not, and so I
thought it would be better to just use the
i8253_lock alltogether. And it doesn't look
like the lock is held during the entire beep,
so it probably doesn't really make anything
to wait for too long. What am I missing?

> Can't you just use input_grab() for this?
I am not sure, I thought I can't. I looked at
the code and it seems input_event() would call
the dev->event() regardless, and only at the
bottom - dev->grab->handler->event().
While it seems like I want to prevent the
dev->event() from being called, at the first
place. And it doesn't look like the grab
functionality is described in
Documentation/input at all, and no examples
around the code that I could use. So I just
don't know what functionality is that...
Will try to play around it and maybe I'll
figure something out:)

> SND_SUSPEND really seems
> inappropriate, since it's not a sound event.
Is it just a problem of the name (i.e.
would the SND_STOP be better), or is it
conceptually wrong? (I guess for both:)

>> Can this please be applied?
> Not yet.
OK. I'll try to find the better solution.
Let's just apply the first patch then - it is a
cleanup, I don't think it could do any harm.

