Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUJTKxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUJTKxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269864AbUJTKwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:52:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16031 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267683AbUJTKnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:43:43 -0400
Date: Wed, 20 Oct 2004 06:42:39 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH (updated)] Avoid annoying build warning on 32-bit platforms
Message-ID: <20041020104239.GT31909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200410200956.i9K9ujOu026178@harpo.it.uu.se> <20041020102343.GA6901@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020102343.GA6901@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 03:23:43AM -0700, Chris Wedgwood wrote:
> Avoid annoying gcc warning on 32-bit platforms.
> 
> Signed-off-by: cw@f00f.org
> 
> ===== drivers/char/random.c 1.57 vs edited =====
> --- 1.57/drivers/char/random.c	2004-10-05 14:21:53 -07:00
> +++ edited/drivers/char/random.c	2004-10-20 03:19:17 -07:00
> @@ -818,12 +818,10 @@ static void add_timer_randomness(struct 
>  	 * jiffies.
>  	 */
>  	time = get_cycles();
> -	if (time != 0) {
> -		if (sizeof(time) > 4)
> -			num ^= (u32)(time >> 32);
> -	} else {
> +	if (time)
> +		num ^= (u32)((time >> 32) >> 1);
				      ^^
				  32 + 1 != 32.

> +	else
>  		time = jiffies;
> -	}

	Jakub
