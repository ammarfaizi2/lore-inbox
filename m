Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWBCW0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWBCW0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWBCW0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:26:46 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:60288 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030206AbWBCW0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:26:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TR+Ad6xlfZpSaxGhm4gxIwkxKAMW/n5SkPOp1DB30qxbbeU+S/8Z9gGFBnYDLKDuqUGYtildW75wA324C10CU5hJBKM/FLfjl2s/lzH5opbsPk1vXDlF8hdmm0JIntUM/ikzC7nnuOHyLd3daPYwNR0a9v0zGCmtwke2mmiSFmM=
Date: Sat, 4 Feb 2006 01:44:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Re [2]: [PATCH] Mark CONFIG_UFS_FS_WRITE as BROKEN
Message-ID: <20060203224457.GA7784@mipter.zuzino.mipt.ru>
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru> <20060201200410.GA11747@rain.homenetwork> <20060203174613.GA7823@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203174613.GA7823@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:46:13PM +0300, Alexey Dobriyan wrote:
> 2. Second patch indeed makes hangs disaapear. However, data corruption
>    is still in place:
> 
> Try
> 
> 	for i in $(seq 1 10000); do echo $i; done >10000-linux.txt
> 	cp 10000-linux.txt >/mnt/openbsd/10000-openbsd.txt

Aha! Cutoff is 2048 bytes. This and less is fine. 2049 and more is not.

00000000  0a 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000800  00                                                |.|
00000801

