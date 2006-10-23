Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWJWScM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWJWScM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWJWScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:32:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:1456 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965002AbWJWScK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:32:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SSOmbEgW2AcKyjRFWGf45bWNrs/XLFvM3DGJ1NwgUv7L4o9rOA+pnuMtmgluHMxszXEs+D0ow3d4TiceF8G+ae8XTwpUtdinIGhlwNHfQc+k21gjRxlwHaFZza34/Eis55FxrEMbMUbTMZZG7TASTmVSZXXN3znJt8X3qhj+X8Q=
Message-ID: <a63d67fe0610231132y3be74a77ha91a078f2b03bf62@mail.gmail.com>
Date: Mon, 23 Oct 2006 11:32:08 -0700
From: "Dan Carpenter" <error27@gmail.com>
To: "Neil Horman" <nhorman@tuxdriver.com>
Subject: Re: [KJ] [PATCH] Correct misc_register return code handling in several drivers
Cc: kernel-janitors@lists.osdl.org, akpm@osdl.org, maxk@qualcomm.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       kjhall@us.ibm.com
In-Reply-To: <20061023181329.GC23714@hmsreliant.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	 <a63d67fe0610231101v2f407e7dv46adaf8dbb0fb4e@mail.gmail.com>
	 <20061023181329.GC23714@hmsreliant.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> On Mon, Oct 23, 2006 at 11:01:36AM -0700, Dan Carpenter wrote:
> > On 10/23/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> > >+out3:
> > >+       for_each_online_node(node) {
> > >+               if(timers[node] != NULL)
> > >+                       kfree(timers[node]);
> > >+       }
> >
> > Tharindu is going to be unhappy out if he sees that.  There is a
> > possibility that timers[node] is uninitialized.  if node[0] is null
> > then node[1] is uninitialized and it's going to cause a crash.
> >
> > regards,
> > dan carpenter
>
>
> Theres a memset to ensure that all the timer pointers are initalized to NULL in
> the patch:
>
> @@ -709,16 +710,18 @@ static int __init mmtimer_init(void)
>         if (timers == NULL) {
>                 printk(KERN_ERR "%s: failed to allocate memory for device\n",
>                                 MMTIMER_NAME);
> -               return -1;
> +               goto out2;
>         }
>
> +       memset(timers,0,(sizeof(mmtimer_t *)*maxn));
> +
>
>

Ah.  Great.  Sorry, didn't notice that you'd taken care of that
already.  Looks good.

regards,
dan carpenter

> --
> /***************************************************
>  *Neil Horman
>  *Software Engineer
>  *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
>  ***************************************************/
>
