Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWIYO6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWIYO6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWIYO6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:58:41 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:33965 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750871AbWIYO6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:58:40 -0400
Date: Tue, 26 Sep 2006 00:58:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hvc_iseries.c: overwriting spin_lock_irqsave()
Message-Id: <20060926005838.d0cd5d7e.sfr@canb.auug.org.au>
In-Reply-To: <b6fcc0a0609250547p551f49bcgab46192e7fa55a39@mail.gmail.com>
References: <b6fcc0a0609250547p551f49bcgab46192e7fa55a39@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexy,

On Mon, 25 Sep 2006 16:47:08 +0400 "Alexey Dobriyan" <adobriyan@gmail.com> wrote:
>
> Stephen, -git4 contains the following code
> 
> drivers/char/hvc_iseries.c:
> 
> static int put_chars(uint32_t vtermno, const char *buf, int count)
> {
>             unsigned long flags;
> 
>             spin_lock_irqsave(&consolelock, flags);
>             if (viochar_is_console(pi) && !viopath_isactive(pi->lp)) {
>                           spin_lock_irqsave(&consoleloglock, flags);
> 
> So, old flags are lost.

Ooops!  Thanks for the heads up, I will send a fix patch tomorrow.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
