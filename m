Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUG1PpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUG1PpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUG1PpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:45:03 -0400
Received: from hera.kernel.org ([63.209.29.2]:2495 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267248AbUG1PoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:44:06 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PATCH: fix some 32bit isms
Date: Wed, 28 Jul 2004 15:42:42 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ce8hhi$ogg$1@terminus.zytor.com>
References: <20040728135941.GA17409@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1091029363 25105 127.0.0.1 (28 Jul 2004 15:42:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 28 Jul 2004 15:42:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040728135941.GA17409@devserv.devel.redhat.com>
By author:    Alan Cox <alan@redhat.com>
In newsgroup: linux.dev.kernel
>
> Fairly self explanatory. int is not size_t.
>  
> Alan 
> 
> OSDL Developer Certificate of Origin 1.0 included herein by reference
> 
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc2/drivers/message/fusion/mptbase.c linux-2.6.8-rc2/drivers/message/fusion/mptbase.c
> --- linux.vanilla-2.6.8-rc2/drivers/message/fusion/mptbase.c	2004-07-27 19:22:42.000000000 +0100
> +++ linux-2.6.8-rc2/drivers/message/fusion/mptbase.c	2004-07-28 14:27:53.603586584 +0100
> @@ -2417,7 +2417,7 @@
>  	} else {
>  		printk(MYIOC_s_ERR_FMT 
>  		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
> -		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
> +		     ioc->name, facts->MsgLength, (int)(offsetof(IOCFactsReply_t,
>  		     RequestFrameSize)/sizeof(u32)));
>  		return -66;
>  	}


This is probably better fixed by changing %d to %zu.

	-hpa
