Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUGZWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUGZWpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUGZWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 18:45:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:6856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266141AbUGZWpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 18:45:08 -0400
Date: Mon, 26 Jul 2004 15:43:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-Id: <20040726154327.107409fc.akpm@osdl.org>
In-Reply-To: <871xjbkv8g.fsf@devron.myhome.or.jp>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andries Brouwer <aebr@win.tue.nl> writes:
> 
> > On Sat, Jul 17, 2004 at 01:35:59AM +0900, OGAWA Hirofumi wrote:
> > 
> > :: KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
> > :: key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
> > :: 
> > :: 	key_map[0] = U(K_ALLOCATED);
> > :: 	for (j = 1; j < NR_KEYS; j++)
> > :: 		key_map[j] = U(K_HOLE);
> > 
> > I think the code has no opinion. It was 128 in 2.4.
> > I am not aware of assumptions on NR_KEYS.
> > So, do not think this is an off-by-one error.
> 
> My point is that key_map is 0-254 array. But KDGKBENT uses 255
> 
> 	case KDGKBENT:
> 		key_map = key_maps[s];
> 		if (key_map) {
> 		    val = U(key_map[i]);
> 		    if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
> 			val = K_HOLE;
> 		} else
> 		    val = (i ? K_HOLE : K_NOSUCHMAP);
> 		return put_user(val, &user_kbe->kb_value);
> 

This all seems a bit inconclusive.  Do we proceed with the original patch
or not?  If not, how do we fix the overflow which Hirofumi has identified?

