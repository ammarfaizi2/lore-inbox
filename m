Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTJDHhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTJDHhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:37:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:58597 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261936AbTJDHhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:37:20 -0400
Date: Sat, 4 Oct 2003 09:36:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] input: do not suppress 0 value relative events
Message-ID: <20031004073656.GA3756@ucw.cz>
References: <200310040223.01664.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310040223.01664.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 02:22:57AM -0500, Dmitry Torokhov wrote:
>   Input: input susbsystem should not drop 0 value relative events,
>          otherwise unsuspecting programs will loose transitions from
>          non-zero to 0 deltas. We should not require userland authors
>          to consult with kernel implementation details all the time,
>          but follow the principle of least surprise and report
>          everything.

Certain devices will then generate an endless stream of zero-movement
relative events, which is not good.

Because 'relative' means that there is no movement when there is no
event, where exactly lies the problem? What application has a problem
with this? Many mice don't ever report zero values, so that application
will probably not work even without the (value==0) check ...

>  input.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> ===================================================================
> 
> diff -Nru a/drivers/input/input.c b/drivers/input/input.c
> --- a/drivers/input/input.c	Sat Oct  4 02:20:18 2003
> +++ b/drivers/input/input.c	Sat Oct  4 02:20:18 2003
> @@ -134,7 +134,7 @@
>  
>  		case EV_REL:
>  
> -			if (code > REL_MAX || !test_bit(code, dev->relbit) || (value == 0))
> +			if (code > REL_MAX || !test_bit(code, dev->relbit))
>  				return;
>  
>  			break;

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
