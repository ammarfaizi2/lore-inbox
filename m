Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVBBW6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVBBW6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVBBW6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:58:33 -0500
Received: from av5-2-sn1.fre.skanova.net ([81.228.11.112]:64970 "EHLO
	av5-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262450AbVBBW6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:58:07 -0500
Date: Wed, 2 Feb 2005 23:58:05 +0100 (CET)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
In-Reply-To: <20050202141117.688c8dd3@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502022345320.18555@telia.com>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com>
 <20050201234148.4d5eac55@localhost.localdomain> <m3lla64r3w.fsf@telia.com>
 <20050202141117.688c8dd3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Pete Zaitcev wrote:

> On 02 Feb 2005 21:57:39 +0100, Peter Osterlund <petero2@telia.com> wrote:
>
> > Please try this patch instead. It works well with my alps touchpad. (I
> > don't have a synaptics touchpad.) It does the following:
> >
> > * Compensates for the lack of floating point arithmetic by keeping
> >   track of remainders from the integer divisions.
> > * Removes the xres/yres scaling so that you get the same speed in the
> >   X and Y directions even if your screen is not square.
> > * Sets scale factors so that the speed for synaptics and alps should
> >   be equal to each other and equal to the synaptics speed from 2.6.10.
>
> Thanks a lot, Peter. I think I like the result even better than the one
> after the simple-minded removal that I posted. It's possible that when
> I accepted the case of (pktcount == 1) it hurt smoothness.
>
> Do you think it makes sense to zero fractions when pktcount is dropped?

In practice I don't think it will make any significant difference. What
the code should do depends on what you want to happen if you move the
mouse pointer 1/2 pixel with one finger stroke, then move it another 1/2
pixel with a second stroke. The patch I posted will move the pointer one
pixel in this case and your code will move it 0 pixels. (The X driver does
not reset the fractions, but that doesn't of course mean that it's the
only right thing to do.)

> Also, I think the extra unary minus is uncoth.

The code was written like that to emphasize the fact that X and Y use the
same formula, with the only difference that the kernel Y axis is mirrored
compared to the touchpad Y axis.

It didn't make any difference for the generated assembly code though,
using gcc 3.4.2 from Fedora Core 3.

> +	enum {  FRACTION_DENOM = 100 };

The enum is much nicer than my #define.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
