Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUKUXfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUKUXfY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKUXfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:35:24 -0500
Received: from mail.dif.dk ([193.138.115.101]:25560 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261743AbUKUXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:35:12 -0500
Date: Mon, 22 Nov 2004 00:44:40 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Johan Myreen <jem@iki.fi>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove pointless <0 comparisons for unsigned vars, and
 avoid a few signed vs unsigned comparisons in drivers/char/keyboard.c
In-Reply-To: <Pine.LNX.4.61.0411220008030.3423@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0411220043300.3387@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411220008030.3423@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Jesper Juhl wrote:

> 
> Hi,
> 
> Sorry about the possibly irrelevant CC list, but I couldn't find a 
> maintainer for drivers/char/keyboard.c listed anywhere, so I ended up 
> sending to lkml and CC'ing a few people who has worked on the file, and 
> akpm as a fallback person due to his 2.6 maintainer role.
> 
> Here's a patch that removes a few pointless comparisons; "scancode" is 
> unsigned so it can never be <0 which makes the test pointless.
> Also, there are a few instances where signed and unsigned variables are 
> comared, and as far as I can tell they really should just all be unsigned.
> 
> Comments welcome (I must confess that I've only compile tested this so 
> far).
> 

Just boot tested it as well and things seem to be fine on my box.


> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-rc2-bk6-orig/drivers/char/keyboard.c linux-2.6.10-rc2-bk6/drivers/char/keyboard.c
> --- linux-2.6.10-rc2-bk6-orig/drivers/char/keyboard.c	2004-10-18 23:55:36.000000000 +0200
> +++ linux-2.6.10-rc2-bk6/drivers/char/keyboard.c	2004-11-22 00:05:45.000000000 +0100
> @@ -174,7 +174,7 @@ int getkeycode(unsigned int scancode)
>  	if (!dev)
>  		return -ENODEV;
>  
> -	if (scancode < 0 || scancode >= dev->keycodemax)
> +	if (scancode >= dev->keycodemax)
>  		return -EINVAL;
>  
>  	return INPUT_KEYCODE(dev, scancode);
> @@ -184,7 +184,7 @@ int setkeycode(unsigned int scancode, un
>  {
>  	struct list_head * node;
>  	struct input_dev *dev = NULL;
> -	int i, oldkey;
> +	unsigned int i, oldkey;
>  
>  	list_for_each(node,&kbd_handler.h_list) {
>  		struct input_handle *handle = to_handle_h(node);
> @@ -197,7 +197,7 @@ int setkeycode(unsigned int scancode, un
>  	if (!dev)
>  		return -ENODEV;
>  
> -	if (scancode < 0 || scancode >= dev->keycodemax)
> +	if (scancode >= dev->keycodemax)
>  		return -EINVAL;
>  
>  	oldkey = SET_INPUT_KEYCODE(dev, scancode, keycode);
> @@ -354,7 +354,7 @@ void to_utf8(struct vc_data *vc, ushort 
>   */
>  void compute_shiftstate(void)
>  {
> -	int i, j, k, sym, val;
> +	unsigned int i, j, k, sym, val;
>  
>  	shift_state = 0;
>  	memset(shift_down, 0, sizeof(shift_down));
> @@ -395,7 +395,7 @@ void compute_shiftstate(void)
>  unsigned char handle_diacr(struct vc_data *vc, unsigned char ch)
>  {
>  	int d = diacr;
> -	int i;
> +	unsigned int i;
>  
>  	diacr = 0;
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
