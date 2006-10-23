Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWJWSpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWJWSpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWJWSpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:45:41 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:42766 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965021AbWJWSpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:45:40 -0400
Date: Mon, 23 Oct 2006 14:44:43 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Dan Carpenter <error27@gmail.com>
Cc: kernel-janitors@lists.osdl.org, akpm@osdl.org, maxk@qualcomm.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       kjhall@us.ibm.com
Subject: Re: [KJ] [PATCH] Correct misc_register return code handling in several drivers
Message-ID: <20061023184443.GD23714@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <a63d67fe0610231101v2f407e7dv46adaf8dbb0fb4e@mail.gmail.com> <20061023181329.GC23714@hmsreliant.homelinux.net> <a63d67fe0610231132y3be74a77ha91a078f2b03bf62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63d67fe0610231132y3be74a77ha91a078f2b03bf62@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 11:32:08AM -0700, Dan Carpenter wrote:
> On 10/23/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> >On Mon, Oct 23, 2006 at 11:01:36AM -0700, Dan Carpenter wrote:
> >> On 10/23/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> >> >+out3:
> >> >+       for_each_online_node(node) {
> >> >+               if(timers[node] != NULL)
> >> >+                       kfree(timers[node]);
> >> >+       }
> >>
> >> Tharindu is going to be unhappy out if he sees that.  There is a
> >> possibility that timers[node] is uninitialized.  if node[0] is null
> >> then node[1] is uninitialized and it's going to cause a crash.
> >>
> >> regards,
> >> dan carpenter
> >
> >
> >Theres a memset to ensure that all the timer pointers are initalized to 
> >NULL in
> >the patch:
> >
> >@@ -709,16 +710,18 @@ static int __init mmtimer_init(void)
> >        if (timers == NULL) {
> >                printk(KERN_ERR "%s: failed to allocate memory for 
> >                device\n",
> >                                MMTIMER_NAME);
> >-               return -1;
> >+               goto out2;
> >        }
> >
> >+       memset(timers,0,(sizeof(mmtimer_t *)*maxn));
> >+
> >
> >
> 
> Ah.  Great.  Sorry, didn't notice that you'd taken care of that
> already.  Looks good.
> 
No worries.  Thanks for taking the time to look
Neil

> regards,
> dan carpenter
> 
> >--
> >/***************************************************
> > *Neil Horman
> > *Software Engineer
> > *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
> > ***************************************************/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
