Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTIPNnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTIPNnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:43:16 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:13831 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261862AbTIPNnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:43:10 -0400
Date: Tue, 16 Sep 2003 15:43:05 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030916154305.A1583@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Sep 14, 2003 at 08:21:30PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 08:21:30PM +0900, Norman Diamond wrote:

[three separate postings]

The content of the first posting is

> +keycode 183 = backslash bar

The content of the second posting is

> +keycode 181 = backslash        underscore
> + control keycode 181 = Control_backslash
> + alt     keycode 181 = Meta_backslash
> +keycode 183 = backslash        bar
> + control keycode 183 = Control_backslash
> + alt     keycode 183 = Meta_backslash

The third posting was almost empty, but reminded me of

> > OGAWA Hirofumi posted a patch for the yen-sign pipe key on 2003.07.23
> > for test1 but his patch still didn't get into test3.

I do not think his patch is needed.

So the question arises: do we need a kernel patch, and if so, what patch?
The program loadkeys exists to load the kernel keymap with the map the user
desires. So, if you need some particular map the obvious answer is:
"use loadkeys".

There is a small snag - until 2.4 the value of NR_KEYS was 128,
while 2.6 uses 256. Moreover, the keys you want to change are above 128.
So, your old precompiled loadkeys will not do - you must recompile the
kbd package against 2.6 kernel headers, or just edit loadkeys.y and dumpkeys.c
inserting

#undef NR_KEYS
#define NR_KEYS 256

after all includes, and then compile on any Linux machine.

There is no need to have knowledge of the Japanese keymap in the kernel,
just as there is no knowledge of the German or French keymap. That
knowledge belongs in the keymap that one loads.

Andries

