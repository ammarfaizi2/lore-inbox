Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267644AbUG3IGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267644AbUG3IGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbUG3IGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:06:14 -0400
Received: from styx.suse.cz ([82.119.242.94]:385 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S267644AbUG3IGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:06:08 -0400
Date: Fri, 30 Jul 2004 10:07:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Jackson <pj@sgi.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, akpm@osdl.org,
       aebr@win.tue.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040730080757.GA1068@ucw.cz>
References: <87fz7c9j0y.fsf@devron.myhome.or.jp> <20040728134202.5938b275.pj@sgi.com> <87llh3ihcn.fsf@ibmpc.myhome.or.jp> <20040728231548.4edebd5b.pj@sgi.com> <87oelzjhcx.fsf@ibmpc.myhome.or.jp> <20040729024931.4b4e78e6.pj@sgi.com> <20040729162423.7452e8f5.akpm@osdl.org> <20040729165152.492faced.pj@sgi.com> <87pt6e2sm3.fsf@devron.myhome.or.jp> <20040730002706.2330974d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730002706.2330974d.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Let me summarize.

In the past, the kernel had various different values of NR_KEYS, in this
order: 128, 512, 256, 255.

128 was not enough, 512 didn't fit in a byte (while allowed to address
all keycodes the input layer uses), 256 broke some apps that relied on
unsigned char counters, and thus we ended up with the maximum value that
kept all software happy.

Now somewhere in the process (I assume in the 512 stage, but could be
the 256 stage as well), the kernel produced warnings about impossible
comparisons.

Thus the comparison(s) were dropped, by Andrew.

Then we finalized on 255, and the comparison is needed again to prevent
overflowing the keymap arrays.

BUT some binaries are still compiled with 256 and try to set up a
mapping for keycode 255 (although there is _no_ such keycode), and
break. IMO it's a bug in the app.

Now I believe that simply adding the check back by reverting the old
Andrew's patch and recompiling/fixing what breaks is the right way to
go.

Any comments?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
