Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVBIHWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVBIHWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 02:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVBIHWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 02:22:46 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:23767 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261706AbVBIHWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 02:22:42 -0500
Date: Wed, 9 Feb 2005 08:23:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Joseph Pingenot <trelane@digitasaru.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Peter Osterlund <petero2@telia.com>
Subject: Re: [PATCH] Fix ALPS sync loss
Message-ID: <20050209072310.GA2282@ucw.cz>
References: <200502081840.12520.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502081840.12520.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 06:40:12PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Here is the promised patch. It turns out protocol validation code was
> a bit (or rather a byte ;) ) off.
> 
> Please let me know if it fixes your touchpad and I believe it would be
> nice to have it in 2.6.11.

Yes, I can't reproduce sync losses that were possible to create with
simultaneous use of the pad anf the touchpoint. Patch applied.

> 
> ===================================================================
> 
> 
> ChangeSet@1.2147, 2005-02-08 18:12:06-05:00, dtor_core@ameritech.net
>   Input: alps - fix protocol validation rules causing touchpad
>          to lose sync if an absolute packet is received after
>          a relative packet with negative Y displacement.
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>   
> 
> 
>  alps.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> --- a/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
> +++ b/drivers/input/mouse/alps.c	2005-02-08 18:16:27 -05:00
> @@ -198,8 +198,8 @@
>  		return PSMOUSE_BAD_DATA;
>  
>  	/* Bytes 2 - 6 should have 0 in the highest bit */
> -	if (psmouse->pktcnt > 1 && psmouse->pktcnt <= 6 &&
> -	    (psmouse->packet[psmouse->pktcnt] & 0x80))
> +	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
> +	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
>  		return PSMOUSE_BAD_DATA;
>  
>  	if (psmouse->pktcnt == 6) {
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
