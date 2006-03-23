Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWCWSVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWCWSVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbWCWSVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:21:34 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:42646 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1422644AbWCWSVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:21:34 -0500
Message-ID: <4422E670.1E88A0F8@tv-sign.ru>
Date: Thu, 23 Mar 2006 21:18:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single 
 threadedprocess at getrusage()
References: <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com> <20060106194623.GA4078@localhost.localdomain> <441EEEC8.D4D9C40A@tv-sign.ru> <20060322221844.GA3300@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
>
> __exit_signal
>         cleanup_sighand(tsk);
>                 kmem_cache_free(sighand)
>         spin_unlock(sighand->lock)
> 
> It looked suspicious to me until I realised sighand cache now had
> SLAB_DESTROY_BY_RCU. Can we please add comments (at cleanup_sighand or
> __exit_signal) to make it a bit clearer for people like me :)

Yes, this is really confusing, see also
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114089590923893
I'll send a cleanup patch soon.

> How is the following patch to avoid tasklist lock completely at getrusage?

I think this patch is correct, thanks.

Oleg.
