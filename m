Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266554AbUGQGYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUGQGYN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 02:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUGQGYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 02:24:13 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:47376 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266554AbUGQGYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 02:24:11 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 17 Jul 2004 15:23:27 +0900
In-Reply-To: <20040716201523.GC5518@pclin040.win.tue.nl>
Message-ID: <871xjbkv8g.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> On Sat, Jul 17, 2004 at 01:35:59AM +0900, OGAWA Hirofumi wrote:
> 
> :: KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
> :: key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
> :: 
> :: 	key_map[0] = U(K_ALLOCATED);
> :: 	for (j = 1; j < NR_KEYS; j++)
> :: 		key_map[j] = U(K_HOLE);
> 
> I think the code has no opinion. It was 128 in 2.4.
> I am not aware of assumptions on NR_KEYS.
> So, do not think this is an off-by-one error.

My point is that key_map is 0-254 array. But KDGKBENT uses 255

	case KDGKBENT:
		key_map = key_maps[s];
		if (key_map) {
		    val = U(key_map[i]);
		    if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
			val = K_HOLE;
		} else
		    val = (i ? K_HOLE : K_NOSUCHMAP);
		return put_user(val, &user_kbe->kb_value);

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
