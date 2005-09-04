Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVIDX42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVIDX42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVIDX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:56:27 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:36817 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932217AbVIDX40 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:56:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j06oJybcjBNUD6NDSB8tK3lbQVK1Quc8BOkniZbHOplF3gKpyV3fIHRvC5/cgXDDTpISE11n5CkdBldVocRSTTC9MaBd0VreikcGny0b2wka2Pt6Neg4dC18Y9aEGILSu1zLXs8uiPgfnDGTUpLZ2IjvW+Kiy1ZZ0DBFOsd93pU=
Message-ID: <29495f1d0509041656261f8a33@mail.gmail.com>
Date: Sun, 4 Sep 2005 16:56:25 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [DVB patch 14/54] frontend: s5h1420: fixes
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
In-Reply-To: <20050904232321.306762000@abc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232321.306762000@abc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> From: Andrew de Quincey <adq_dvb@lidskialf.net>
> 
> Misc. fixes.

<snip>

> --- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/s5h1420.c        2005-09-04 22:24:24.000000000 +0200
> +++ linux-2.6.13-git4/drivers/media/dvb/frontends/s5h1420.c     2005-09-04 22:28:04.000000000 +0200

@@ -138,16 +146,17 @@ static int s5h1420_send_master_cmd (stru

<snip>

>         /* wait for transmission to complete */
>         timeout = jiffies + ((100*HZ) / 1000);

<snip>

> @@ -236,7 +246,7 @@ static int s5h1420_send_burst (struct dv
>         s5h1420_writereg(state, 0x3b, s5h1420_readreg(state, 0x3b) | 0x08);
> 
>         /* wait for transmission to complete */
> -       timeout = jiffies + ((20*HZ) / 1000);
> +       timeout = jiffies + ((100*HZ) / 1000);

Should these be

timeout = jiffies + msecs_to_jiffies(100);

?

Thanks,
Nish
