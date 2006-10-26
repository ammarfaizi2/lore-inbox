Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423645AbWJZRXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423645AbWJZRXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423646AbWJZRXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:23:03 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37251 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1423645AbWJZRXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:23:00 -0400
Date: Thu, 26 Oct 2006 19:22:27 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jim Houston <jim.houston@comcast.net>
cc: John Stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux@horizon.com
Subject: Re: [PATCH] time_adjust cleared before use
In-Reply-To: <1161876597.7885.9.camel@x2.site>
Message-ID: <Pine.LNX.4.64.0610261919400.6761@scrub.home>
References: <1161876597.7885.9.camel@x2.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, Jim Houston wrote:

> Hi
> 
> I notice that the code which implements adjtime clears
> the time_adjust value before using it.  The attached 
> patch makes the obvious fix.
> 
> Jim Houston - Concurrent Computer Corp.
> 
> --
> 
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 47195fa..3afeaa3 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -161,9 +161,9 @@ void second_overflow(void)
>  			time_adjust += MAX_TICKADJ;
>  			tick_length -= MAX_TICKADJ_SCALED;
>  		} else {
> -			time_adjust = 0;
>  			tick_length += (s64)(time_adjust * NSEC_PER_USEC /
>  					     HZ) << TICK_LENGTH_SHIFT;
> +			time_adjust = 0;
>  		}
>  	}
>  }

Acked-by: Roman Zippel <zippel@linux-m68k.org>

Thanks, that might also explain the other problem.
Could you please sign it off and then it should go into 2.6.19.

bye, Roman
