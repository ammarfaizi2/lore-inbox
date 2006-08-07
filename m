Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWHGONh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWHGONh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWHGONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:13:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29970 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932110AbWHGONg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:13:36 -0400
Date: Mon, 7 Aug 2006 13:55:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/12] hdaps: Use thinkpad_ec instead of direct port access
Message-ID: <20060807135551.GF4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492333054-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492333054-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yes, this looks badly needed.

> As you can see from the comments at the beginning of the patch, the old
> driver got some stuff wrong about the meaning of EC readouts. This patch
> preserves the old broken behavior; it will be fixed in a later patch.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Signed-off-by: Pavel Machek <pavel@suse.cz>

> @@ -209,77 +131,79 @@ static int hdaps_read_pair(unsigned int 
>   * hdaps_device_init - initialize the accelerometer.  Returns zero on success
>   * and negative error code on failure.  Can sleep.
>   */
> +#define ABORT_INIT(msg) { printk(KERN_ERR "hdaps init: %s\n", msg); goto bad; }

No.. macro with embedded goto is *evil*.

> +	if (thinkpad_ec_read_row(&args, &data))
> +		ABORT_INIT("read1");
> +	if (data.val[0xF]!=0x00)
> +		ABORT_INIT("check1");

!=0 in if is evil...

> +	mode = data.val[0x1];
> +		
> +	printk(KERN_DEBUG "hdaps: initial mode latch is 0x%02x\n", mode);
> +	if (mode==0x00)

if !mode ?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
