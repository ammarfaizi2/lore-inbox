Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWGSPhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWGSPhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWGSPhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:37:23 -0400
Received: from kurby.webscope.com ([204.141.84.54]:61358 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1030186AbWGSPhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:37:23 -0400
Message-ID: <44BE5162.40701@linuxtv.org>
Date: Wed, 19 Jul 2006 11:36:02 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Trent Piepho <xyzzy@speakeasy.org>, Robert Fitzsimons <robfitz@273k.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       76306.1226@compuserve.com, fork0@t-online.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       shemminger@osdl.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device	corruption
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>	 <20060713050541.GA31257@kroah.com>	 <20060712222407.d737129c.rdunlap@xenotime.net>	 <20060712224453.5faeea4a.akpm@osdl.org> <20060715230849.GA3385@localhost>	 <1153013464.4755.35.camel@praia>	 <Pine.LNX.4.58.0607171650510.18488@shell3.speakeasy.net> <1153310092.27276.9.camel@praia>
In-Reply-To: <1153310092.27276.9.camel@praia>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:
> Em Seg, 2006-07-17 às 17:25 -0700, Trent Piepho escreveu:
>> On Sat, 15 Jul 2006, Mauro Carvalho Chehab wrote:
>>> Em Sb, 2006-07-15 s 23:08 +0000, Robert Fitzsimons escreveu:
>>>> The layout of struct video_device would change depending on whether
>>>> videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
>>>> the structure to get corrupted.
>>> Hmm... good point! However, I the proper solution would be to trust on
>>> CONFIG_VIDEO_V4L1_COMPAT or CONFIG_VIDEO_V4L1 instead. it makes no sense
>>> to keep a pointer to an unsupported callback, when V4L1 is not selected.
>> It's not so clear that the problem is with v4l2-dev.h, because if you look
>> that file:
>>
>> #ifdef CONFIG_VIDEO_V4L1
>> #include <linux/videodev.h>
>> #else
>> #include <linux/videodev2.h>
>> #endif
> That's true. I think the OOPS is related to this -git patch:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6ab3d5624e172c553004ecc862bfeac16d9d68b7
> 
> It removed config.h from bttv-cards (and other places), but we need
> CONFIG_* symbols before including v4l2-dev.h. Maybe the right solution
> would be to include autoconf.h or config.h at the top of v4l2-dev.h.

No, that is a red herring.

The #include <linux/config.h> has been removed in favor of command-line
-iMACRO inclusion...

In other words, config.h is still being included, but the explicit
#include language is no longer needed.
-- 
Michael Krufky

