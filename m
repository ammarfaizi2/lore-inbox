Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264527AbRFOVfj>; Fri, 15 Jun 2001 17:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264528AbRFOVfa>; Fri, 15 Jun 2001 17:35:30 -0400
Received: from ss02.nc.us.ibm.com ([32.97.136.232]:36842 "EHLO
	ddstreet.raleigh.ibm.com") by vger.kernel.org with ESMTP
	id <S264527AbRFOVfI>; Fri, 15 Jun 2001 17:35:08 -0400
Date: Fri, 15 Jun 2001 17:30:03 -0400 (EDT)
From: Dan Streetman <ddstreet@us.ibm.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ps2 keyboard filter hook
In-Reply-To: <OF6CD0EC09.7E779796-ON85256A6C.007426B5@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.10.10106151704170.27777-100000@ddstreet.raleigh.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>X11 likes to talk direct to the PS/2 port.  I actually think you should
>instead
>talk to Vojtech for the mainstream kernel about the input device work. It
>sounds much cleaner and more close to what you need

Ah, I didn't realize the input layer was handling PS/2 stuff...?  Although I am
not sure it would work; the special needs of these keyboards requires the driver
to do some bizarre things, such as:

- change scancodes.  I was and still am shocked by this.  I will say that it is
  a 'legacy feature' that I'm told is due having to deal with Windoze...
- consume scancodes.  The keyboard uses normal scancodes for the extra hardware
  as well as normal keys, so if the driver can't filter them out large amounts
  of strange characters will appear when (e.g.) a credit card is swiped.
- send large amounts of bytes (multi-KB) to the PS/2 port (I think this
  may be possible).

The filtering needs to be done fairly early (I think), or the keyboard state may
get corrupted by seemingly random 'normal' scancodes coming in (for non-raw
modes)...

Vojtech, could you comment on if the above is possible using the input layer?

-- 
Dan Streetman
ddstreet@us.ibm.com
--------------------------------------------------
186,282 miles per second:
It isn't just a good idea, it's the law!

