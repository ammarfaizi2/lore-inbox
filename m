Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWKBAFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWKBAFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWKBAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:05:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:51297 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750835AbWKBAFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:05:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y3UGD9P/6nWRCNx8zvWRBtZqTqEKXiRiZdtUb7AP5k6Kd4osO2qbC6m+0KwG7eNhtF8JbFNPSDsSv7aUswoxrt9qRJKRxeo9XROcF9+Uhibm70eYFcPnUflmNIg3Lb1WSRHZFu6xsHHsC6mdmtF5TvFg6s7ZODAUpAmDmZLi5Yo=
Message-ID: <9a8748490611011605u55ccdcaeob99700d6e1a813a4@mail.gmail.com>
Date: Thu, 2 Nov 2006 01:05:49 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Neil Horman" <nhorman@tuxdriver.com>
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>, akpm@osdl.org,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061101135619.GA3459@hmsreliant.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <1161660875.10524.535.camel@localhost.localdomain>
	 <20061024125306.GA1608@hmsreliant.homelinux.net>
	 <1161729762.10524.660.camel@localhost.localdomain>
	 <20061101135619.GA3459@hmsreliant.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> Hey all-
>         Since Andrew hasn't incorporated this patch yet, and I had the time, I
> redid the patch taking Benjamin's INIT_LIST_HEAD and Joes mmtimer cleanup into
> account.  New patch attached, replacing the old one, everything except the
> aforementioned cleanups is identical.
>
> Thanks & Regards
> Neil
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
>
> +out4:
> +       for_each_online_node(node) {
> +               kfree(timers[node]);
> +       }
> +out3:
> +       misc_deregister(&mmtimer_miscdev);
> +out2:
> +       free_irq(SGI_MMTIMER_VECTOR, NULL);
> +out1:
> +       return -1;

Very nitpicky little thing, but shouldn't the labels start at column
1, not column 0 ?
I thought that was standard practice (apparently labels at column 0
can confuse 'patch').

Hmm, I guess that should be defined once and for all in
Documentation/CodingStyle

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
