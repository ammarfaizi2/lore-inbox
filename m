Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270373AbTHLOjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270384AbTHLOjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:39:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:39952 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S270373AbTHLOjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:39:08 -0400
Date: Tue, 12 Aug 2003 16:39:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
Message-ID: <20030812143901.GA18522@alpha.home.local>
References: <m21xvrynnk.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21xvrynnk.wl%ysato@users.sourceforge.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:07:59PM +0900, Yoshinori Sato wrote:
> zero fill count is off-by-one error

I disagree here. With your code, if count becomes 0 within the first while(),
you set it to (unsigned)(-1) (because count is size_t), and the second loop
will add this number of zeroes after dest (4 billion on 32 bits archs).

The original code seems OK to me.

Cheers,
Willy

> --- lib/string.c~	2003-08-09 20:30:36.000000000 +0900
> +++ lib/string.c	2003-08-12 22:55:47.000000000 +0900
> @@ -89,7 +89,8 @@
>  
>  	while (count && (*dest++ = *src++) != '\0')
>  		count--;
> -	while (count) {
> +	count--;
> +	while (count > 0) {
>  		*dest++ = 0;
>  		count--;
>  	}
