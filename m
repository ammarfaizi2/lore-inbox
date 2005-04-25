Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVDYU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVDYU25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVDYU2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:28:53 -0400
Received: from mail.dif.dk ([193.138.115.101]:11670 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261159AbVDYU0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:26:03 -0400
Date: Mon, 25 Apr 2005 22:29:21 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Colin Leroy <colin@colino.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
In-Reply-To: <20050425220345.6b2ed6d5@jack.colino.net>
Message-ID: <Pine.LNX.4.62.0504252226370.2941@dragon.hyggekrogen.localhost>
References: <20050425211915.126ddab5@jack.colino.net>
 <Pine.LNX.4.61.0504252145220.25129@scrub.home> <20050425220345.6b2ed6d5@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, Colin Leroy wrote:

> On 25 Apr 2005 at 21h04, Roman Zippel wrote:
> 
> Hi, 
> 
> > Actually it looks like we are always leaking it, so actually 
> > hfsplus_put_super() needs fixing, could you add the check and kfree 
> > there and do the same fix for hfs?
> 
> Mmh, right. Here's an updated version that fixes it too.
> 
> Signed-off-by: Colin Leroy <colin@colino.net>
> --- a/fs/hfsplus/super.c	2005-04-25 21:56:56.000000000 +0200
> +++ b/fs/hfsplus/super.c	2005-04-25 21:58:39.000000000 +0200
> @@ -226,6 +226,9 @@
>  	brelse(HFSPLUS_SB(sb).s_vhbh);
>  	if (HFSPLUS_SB(sb).nls)
>  		unload_nls(HFSPLUS_SB(sb).nls);
> +
> +	kfree((struct hfsplus_sb_info *)sb->s_fs_info);

kfree() takes a  void *  argument, that cast is not needed.


-- 
Jesper Juhl


