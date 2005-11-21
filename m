Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVKUTPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVKUTPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKUTPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:15:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:14796 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932458AbVKUTPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:15:37 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43821C47.6010702@s5r6.in-berlin.de>
Date: Mon, 21 Nov 2005 20:13:11 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Dave Jones <davej@redhat.com>, bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
References: <20051120232009.GH16060@stusta.de> <20051120234055.GF28918@redhat.com> <20051120235242.GR16060@stusta.de>
In-Reply-To: <20051120235242.GR16060@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.33) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
[...]
> There's no need to free cache at this point, and it's getting free'd 
> later.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old	2005-11-20 22:08:57.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c	2005-11-21 00:49:38.000000000 +0100
> @@ -2131,7 +2131,6 @@
>  			   req->req.length)) {
>  		csr1212_release_keyval(fi->csr1212_dirs[dr]);
>  		fi->csr1212_dirs[dr] = NULL;
> -		CSR1212_FREE(cache);
>  		ret = -EFAULT;
>  	} else {
>  		cache->len = req->req.length;

This looks OK to me. But there seems to be another bug. I think the line

	kfree(cache);

after the if and else blocks has to be replaced by

	CSR1212_FREE(cache);

-- 
Stefan Richter
-=====-=-=-= =-== =-=-=
http://arcgraph.de/sr/
