Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUALJqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUALJqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:46:40 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:2308 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S266091AbUALJqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:46:37 -0500
Date: Mon, 12 Jan 2004 20:46:25 +1100
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I810_AUDIO] 1/x: Fix wait queue race in drain_dac
Message-ID: <20040112094625.GA16686@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <4001B979.1080600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4001B979.1080600@pobox.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 04:00:41PM -0500, Jeff Garzik wrote:
> 
> Thanks much for these i810_audio patches.  I've been meaning to review 
> them in-depth for some time.

Thanks a lot for reviewing them.

> Could you be kind and "spell out" the patch-1 race for me?

Prior to the patch, if an interrupt occured between the count check
and the setting of the current state the wait will timeout instead
of waking up immediately.

> Also, it seems to me that you would want to check for signal_pending()
> (a) just after the schedule_timeout(), and
> (b) -after- testing the 'signals_allowed' variable  ;-)

schedule() already checks for signals.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
