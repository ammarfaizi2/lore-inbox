Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUDVHhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUDVHhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263838AbUDVHgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:36:47 -0400
Received: from styx.suse.cz ([82.208.2.94]:4224 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263831AbUDVHbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:31:49 -0400
Date: Thu, 22 Apr 2004 09:32:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/15] New set of input patches: atkbd timeout complaints
Message-ID: <20040422073230.GE340@ucw.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210058.44629.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404210058.44629.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 12:58:42AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1910, 2004-04-20 22:32:46-05:00, dtor_core@ameritech.net
>   Input: Do not generate events from atkbd until keyboard is completely
>          initialized. It should suppress messages about suprious NAKs
>          when controller's timeout is longer than one in atkbd

We may need to protect ourselves against this - it may confuse the probe
in addition to just generating spurious messages.

> 
> 
>  atkbd.c |    6 ++++++
>  1 files changed, 6 insertions(+)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> --- a/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:09:40 2004
> +++ b/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:09:40 2004
> @@ -188,6 +188,7 @@
>  	unsigned int resend:1;
>  	unsigned int release:1;
>  	unsigned int bat_xl:1;
> +	unsigned int enabled:1;
>  
>  	unsigned int last;
>  	unsigned long time;
> @@ -248,6 +249,9 @@
>  		goto out;
>  	}
>  
> +	if (!atkbd->enabled)
> +		goto out;
> +
>  	if (atkbd->translated) {
>  
>  		if (atkbd->emul ||
> @@ -749,6 +753,8 @@
>  		atkbd->set = 2;
>  		atkbd->id = 0xab00;
>  	}
> +
> +	atkbd->enabled = 1;
>  
>  	if (atkbd->extra) {
>  		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
