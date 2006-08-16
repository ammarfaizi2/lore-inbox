Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWHPQYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWHPQYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWHPQYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:24:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41650 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751139AbWHPQYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:24:23 -0400
Subject: Re: PATCH: Lock tty directly in acct layer
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155746201.24077.364.camel@localhost.localdomain>
References: <1155746201.24077.364.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 16 Aug 2006 18:24:20 +0200
Message-Id: <1155745460.3023.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 17:36 +0100, Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/kernel/acct.c linux-2.6.18-rc4-mm1/kernel/acct.c
> --- linux.vanilla-2.6.18-rc4-mm1/kernel/acct.c	2006-08-15 15:40:19.000000000 +0100
> +++ linux-2.6.18-rc4-mm1/kernel/acct.c	2006-08-15 16:03:18.000000000 +0100
> @@ -483,10 +484,10 @@
>  	ac.ac_ppid = current->parent->tgid;
>  #endif
>  
> -	read_lock(&tasklist_lock);	/* pin current->signal */
> +	mutex_lock(&tty_mutex);
>  	ac.ac_tty = current->signal->tty ?

but.. can't ->signal still change, even if signal->tty isn't ?



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

