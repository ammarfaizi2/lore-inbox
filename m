Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTJ0S4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTJ0S4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:56:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:44718 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263424AbTJ0S4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:56:53 -0500
Date: Mon, 27 Oct 2003 10:56:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: vojtech@suse.cz, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PS/2 mouse rate setting
In-Reply-To: <20031027183856.GA1461@averell>
Message-ID: <Pine.LNX.4.44.0310271054120.1636-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Oct 2003, Andi Kleen wrote:
>  static void psmouse_set_rate(struct psmouse *psmouse)
>  {
> -	unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
> +	static unsigned char rates[] = { 200, 100, 80, 60, 40, 20, 10, 0 };
>  	int i = 0;
>  
> -	while (rates[i] > psmouse_rate) i++;
> +	if (!psmouse_rate)
> +		return; 
> +
> +	while (rates[i] >= psmouse_rate) i++;

Ok, explain that ">=" to me. It looked more right the way it used to be.

In particular, if you want a rate of 200, you will now make "i" be _1_, so 
we send a command to set the rate to 100.

Which makes no sense.

		Linus

