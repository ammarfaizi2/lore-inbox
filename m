Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272148AbTGYP1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272151AbTGYP1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:27:24 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:46602 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272148AbTGYP1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:27:23 -0400
Date: Fri, 25 Jul 2003 17:42:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: "Clemens Schwaighofer" <cs@tequila.co.jp>, <linux-kernel@vger.kernel.org>
Subject: Re: Japanese keyboards broken in 2.6
Message-ID: <20030725154228.GC606@win.tue.nl>
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60> <3F20E0ED.6010800@tequila.co.jp> <0e0101c35297$cb1890f0$4fee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0101c35297$cb1890f0$4fee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 07:30:04PM +0900, Norman Diamond wrote:

> > setkeycodes 0x6a 124 1>&2 in your rc.local, local.start or whatever.
> > works fine for me for alle 2.5x kernels
> 
> There must be a ton of odd stuff going on.  "showkey" used to say that the
> scan code is 0x7d not 0x6a, but now it displays weird stuff.  As previously
> mentioned, "getkeycodes" displays a table which seems far removed from
> reality.  But the patch from junkio@cox.net worked (but "showkey" and
> "getkeycodes" still produce weird output).

Yes.

I am a little bit unhappy with the state of the kbd code
(but have not yet decided whether I want to attempt to fix something).

One aspect of the matter is that raw mode no longer is raw.
The keyboard sends codes and the input layer translates that into
the codes the input layer thinks the keyboard should have sent.
Then, when one wants the raw codes, a reverse translation is used,
but since the mapping is not one-to-one the reverse translation
does not produce what the keyboard sent to start with.

In particular this means that showkey is no longer useful under 2.5
if one wants to investigate the scancodes a keyboard sends.

Andries


[PS - Some ioctls are broken. Recompiling kernel and loadkeys/dumpkeys
with larger structures works for private use, but the kernel ABI must
not change, so for actual kernel patches one needs new ioctl numbers.]

