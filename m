Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272778AbTG3G2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272781AbTG3G2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:28:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55816 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272778AbTG3G2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:28:09 -0400
Date: Tue, 29 Jul 2003 19:49:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
Message-ID: <20030729174919.GC2601@openzaurus.ucw.cz>
References: <1059484419.8537.19.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059484419.8537.19.camel@gaston>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There is room for improvement, but this is a first step that makes
> suspend/resume work more reliably on pmacs. I'll send aty128fb and
> radeonfb bits using this framework once it's merged.

> @@ -199,7 +199,8 @@
>  	if (!info || (info->cursor.rop == ROP_COPY))
>  		return;
>  	info->cursor.enable ^= 1;
> -	info->fbops->fb_cursor(info, &info->cursor);
> +	if (!info->suspended)
> +		info->fbops->fb_cursor(info, &info->cursor);
>  }
>  
>  	y_break = p->vrows - p->yscroll;

Would not it be simpler to replace info->fbops with some dummy ones?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

