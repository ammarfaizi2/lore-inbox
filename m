Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVAPWSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVAPWSo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVAPWSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:18:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:44421 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262628AbVAPWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:22 -0500
Subject: Re: [PATCH 3/13] ftape: remove cli()/sti() in
	drivers/char/ftape/lowlevel/ftape-format.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Nelson <james4765@cwazy.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, akpm@osdl.org
In-Reply-To: <20050116135244.30109.69180.33718@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
	 <20050116135244.30109.69180.33718@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105908296.12196.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 21:10:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 13:52, James Nelson wrote:
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-format.c linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-format.c
> --- linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-format.c	2004-12-24 16:34:45.000000000 -0500
> +++ linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-format.c	2005-01-16 07:32:19.293557207 -0500
> @@ -132,7 +132,7 @@
>  	TRACE_CATCH(ftape_seek_head_to_track(track),);
>  	TRACE_CATCH(ftape_command(QIC_LOGICAL_FORWARD),);
>  	spin_lock_irqsave(&ftape_format_lock, flags);
> -	TRACE_CATCH(fdc_setup_formatting(head), restore_flags(flags));
> +	TRACE_CATCH(fdc_setup_formatting(head),);
>  	spin_unlock_irqrestore(&ftape_format_lock, flags);

This is wrong (the original is too). TRACE_CATCH expands into code
including a return so you need to replace the retore_flags(flags) with a
copy of the spin_unlock_irqrestore line below

