Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVCGNHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVCGNHC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVCGNHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:07:01 -0500
Received: from styx.suse.cz ([82.119.242.94]:47519 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261154AbVCGNGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:06:47 -0500
Date: Mon, 7 Mar 2005 14:10:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix NULL pointer deference in ALPS
Message-ID: <20050307131002.GA8025@ucw.cz>
References: <20050307122432.GG8138@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307122432.GG8138@ens-lyon.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 01:24:32PM +0100, Benoit Boissinot wrote:
> I get a NULL pointer deference in with alps while suspending.
> 
> The following patch fixes it: alps_get_model returns a pointer or
> NULL in case of errors, so we need to check for the results being NULL,
> not negative.
> 
> Since it is trivial, it is maybe a candidate for 2.6.11.2.
> 
> It does not apply to -mm since the last occurence of alps_get_model
> was corrected (but not the others), if needed i can send a patch for
> -mm as well.

I already fixed it in my tree, but feel free to push it for the sucker
tree.

> regards,
> 
> Benoit
> 
> Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
> 
> 
> --- linux-clean/drivers/input/mouse/alps.c	2005-03-07 12:45:46.000000000 +0100
> +++ linux-vanilla/drivers/input/mouse/alps.c	2005-03-07 12:50:12.000000000 +0100
> @@ -325,7 +325,7 @@ static int alps_reconnect(struct psmouse
>  	int model;
>  	unsigned char param[4];
>  
> -	if ((model = alps_get_model(psmouse)) < 0)
> +	if (!(model = alps_get_model(psmouse)))
>  		return -1;
>  
>  	if (model == ALPS_MODEL_DUALPOINT && alps_passthrough_mode(psmouse, 1))
> @@ -358,7 +358,7 @@ int alps_init(struct psmouse *psmouse)
>  	unsigned char param[4];
>  	int model;
>  
> -	if ((model = alps_get_model(psmouse)) < 0)
> +	if (!(model = alps_get_model(psmouse)))
>  		return -1;
>  
>  	printk(KERN_INFO "ALPS Touchpad (%s) detected\n",
> @@ -412,7 +412,7 @@ int alps_init(struct psmouse *psmouse)
>  
>  int alps_detect(struct psmouse *psmouse, int set_properties)
>  {
> -	if (alps_get_model(psmouse) < 0)
> +	if (!alps_get_model(psmouse))
>  		return -1;
>  
>  	if (set_properties) {
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
