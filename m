Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUJYT22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUJYT22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUJYP7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:59:43 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:53710 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261988AbUJYPlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:41:20 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 25 Oct 2004 17:18:41 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bttv hang problem on 2.6.8
Message-ID: <20041025151841.GA10042@bytesex>
References: <20041025150349.GA22915@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025150349.GA22915@xi.wantstofly.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 05:03:49PM +0200, Lennert Buytenhek wrote:
> (please CC on replies, I'm not on the list)
> 
> Hi,
> 
> When there is a background thread doing VIDIOCSYNC in a loop, issuing
> VIDIOCSPICT in the current thread on the same file descriptor causes
> it to go into uninterruptable sleep and hang.  This is on kernel 2.6.8
> using the bttv driver, and appears easily reproducible.

Don't do that.  bttv serializes ioctls with a lock.  Well, not all of
them, but the ones which change the state of the filehandle, and both
VIDIOCSYNC + VIDIOCSPICT fall into that group.  You simply can't run
them in parallel on the same filehandle.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
