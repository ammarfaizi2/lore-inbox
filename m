Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUG0NpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUG0NpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 09:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUG0NpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 09:45:13 -0400
Received: from styx.suse.cz ([82.119.242.94]:28548 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265517AbUG0NpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 09:45:07 -0400
Date: Tue, 27 Jul 2004 15:46:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, aebr@win.tue.nl,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040727134654.GB17362@ucw.cz>
References: <87llhjlxjk.fsf@devron.myhome.or.jp> <20040716164435.GA8078@ucw.cz> <20040716201523.GC5518@pclin040.win.tue.nl> <871xjbkv8g.fsf@devron.myhome.or.jp> <20040726154327.107409fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726154327.107409fc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 03:43:27PM -0700, Andrew Morton wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> > Andries Brouwer <aebr@win.tue.nl> writes:
> > 
> > > On Sat, Jul 17, 2004 at 01:35:59AM +0900, OGAWA Hirofumi wrote:
> > > 
> > > :: KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
> > > :: key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
> > > :: 
> > > :: 	key_map[0] = U(K_ALLOCATED);
> > > :: 	for (j = 1; j < NR_KEYS; j++)
> > > :: 		key_map[j] = U(K_HOLE);
> > > 
> > > I think the code has no opinion. It was 128 in 2.4.
> > > I am not aware of assumptions on NR_KEYS.
> > > So, do not think this is an off-by-one error.
> > 
> > My point is that key_map is 0-254 array. But KDGKBENT uses 255
> > 
> > 	case KDGKBENT:
> > 		key_map = key_maps[s];
> > 		if (key_map) {
> > 		    val = U(key_map[i]);
> > 		    if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= NR_TYPES)
> > 			val = K_HOLE;
> > 		} else
> > 		    val = (i ? K_HOLE : K_NOSUCHMAP);
> > 		return put_user(val, &user_kbe->kb_value);
> > 
> 
> This all seems a bit inconclusive.  Do we proceed with the original patch
> or not?  If not, how do we fix the overflow which Hirofumi has identified?

I think we should check the value in the ioctl, regardless of what's
NR_KEYS defined to.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
