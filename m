Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTF1Q7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbTF1Q7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:59:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60935 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265291AbTF1Q7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:59:14 -0400
Date: Sat, 28 Jun 2003 13:13:16 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Lou Langholtz <ldl@aros.net>
cc: Paul.Clements@steeleye.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
In-Reply-To: <3EFA1F7E.2080602@aros.net>
Message-ID: <Pine.LNX.4.10.10306261014360.412-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Lou Langholtz wrote:

> Reviewing the code some more, I'm not sure why I moved the tx_lock out 
> from nbd_send_req(). Some possible explanations are:
> 
>    2. keeps the locking at the same level as the spin_unlock_irq() which
>       makes lock analysis a little easier. it's also a more consistant
>       level to have at for consistantly locking accross all the ioctl
>       handling.

But, unless the locks are overlapping (which they did not used to be) there
really is nothing to analyze in the first place...it's just obviously
correct, right?


>    4. in order to have the locking inside nbd_send_req it would seem
>       it'd help to make nbd_send_req return a value that could be checked.

That's not an unreasonable thing to do...it'd be a much more minor change.
I guess I'm just having a hard time seeing the benefit of rearranging
all this code. Unless there's some substantial benefit, it seems wiser
to keep the changes as minimal as possible...after all, the current code
does work.


> week. In the meantime, the nbd-client tool currently can't correctly set 
> the size of the device and either that needs to be worked around in the 
> driver (I'd done that in the original jumbo patch), or the nbd-client 
> tool needs to be updated (the patch I'd mailed out for nbd-client works 
> around the sizing issue by re-opening the nbd). To be clear, that's not 
> something any of the changes that have gone in so far broke nor address. 

I'm in favor of doing the minor change in the driver to maintain
compatibility with existing userland tools. It's a pretty simple fix...

The patch will be coming shortly...

--
Paul

