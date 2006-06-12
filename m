Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWFLRXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWFLRXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFLRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:23:04 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:12675
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751267AbWFLRXB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:23:01 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fix for the PPTP hangs that have been reported
Date: Mon, 12 Jun 2006 19:22:22 +0200
User-Agent: KMail/1.9.1
References: <17548.52858.22555.610055@cargo.ozlabs.ibm.com>
In-Reply-To: <17548.52858.22555.610055@cargo.ozlabs.ibm.com>
Cc: akpm@osdl.org, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, xxebxebx@gmail.com,
       Greg KH <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121922.23431.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 04:16, Paul Mackerras wrote:
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Linus & Andrew, I think this one is a 2.6.17 candidate.

What about 2.6.16-stable?
I just applied that patch to my server running 2.6.16.20.
Seems to be ok, but I did not stresstest it.

> It's a small 
> and harmless patch and it fixes a bug that has been annoying quite a
> few people, if the bugzilla reports are anything to go by.  I think it
> should solve bugzilla 6402 as well.
> 
> diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
> index ede365d..b9371d5 100644
> --- a/drivers/char/n_tty.c
> +++ b/drivers/char/n_tty.c
> @@ -1384,8 +1384,10 @@ do_it_again:
>  		 * longer than TTY_THRESHOLD_UNTHROTTLE in canonical mode,
>  		 * we won't get any more characters.
>  		 */
> -		if (n_tty_chars_in_buffer(tty) <= TTY_THRESHOLD_UNTHROTTLE)
> +		if (n_tty_chars_in_buffer(tty) <= TTY_THRESHOLD_UNTHROTTLE) {
> +			n_tty_set_room(tty);
>  			check_unthrottle(tty);
> +		}
>  
>  		if (b - buf >= minimum)
>  			break;

-- 
Greetings Michael.
