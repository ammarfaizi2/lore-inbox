Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVCGHXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVCGHXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVCGHWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:22:52 -0500
Received: from iabervon.org ([66.92.72.58]:25093 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261666AbVCGHNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:13:07 -0500
Date: Mon, 7 Mar 2005 02:14:17 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Benoit Boissinot <bboissin@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: New ALPS code in -mm
In-Reply-To: <20050304211327.GA5636@ucw.cz>
Message-ID: <Pine.LNX.4.21.0503070204040.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Vojtech Pavlik wrote:

>  		/* Relative movement packet */
>   		if (z == 127) {
> -			input_report_rel(dev2, REL_X,  (x > 383 ? x : (x - 768)));
> -			input_report_rel(dev2, REL_Y, -(y > 255 ? y : (x - 512)));
> +			input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
> +			input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));

Not that I have any idea, but (y - 512) seems much more likely here.

> +	if ((priv->i->flags & ALPS_DUALPOINT) && z == 127) {
> +		input_report_key(dev2, BTN_LEFT,   left);    
> +		input_report_key(dev2, BTN_RIGHT,  right);
> +		input_report_key(dev2, BTN_MIDDLE, middle);
> +		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
> +		input_report_rel(dev2, REL_Y, -(y > 255 ? (x - 512) : y));

Also here.

	-Daniel
*This .sig left intentionally blank*

