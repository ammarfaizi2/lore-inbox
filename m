Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUIEOcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUIEOcI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUIEOcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:32:08 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:31496 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S266745AbUIEOcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:32:02 -0400
Date: Sun, 5 Sep 2004 15:32:01 +0100
From: John Levon <levon@movementarian.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, phil.el@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix oprofile vfree warning on error
Message-ID: <20040905143201.GB79932@compsoc.man.ac.uk>
References: <20040904174403.GC7716@krispykreme> <20040904174642.GD7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904174642.GD7716@krispykreme>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1C3y3l-0009zB-GC*T4jxSwObddY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 03:46:42AM +1000, Anton Blanchard wrote:

> On error we can call __free_cpu_buffers with only some buffers
> allocated. I was getting a bunch of vfree warnings when I hit it, we
> should check before calling vfree.

Why does vfree() differ from free() / kfree() in not accepting NULL ?
This seems like an interface wart.

cheers
john

> -	for_each_online_cpu(i)
> -		vfree(cpu_buffer[i].buffer);
> +	for_each_online_cpu(i) {
> +		if (cpu_buffer[i].buffer)
> +			vfree(cpu_buffer[i].buffer);
> +	}
