Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWDYOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWDYOho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWDYOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:37:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932235AbWDYOhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:37:42 -0400
Message-ID: <444E3433.1040703@redhat.com>
Date: Tue, 25 Apr 2006 10:37:39 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about nfs_execute_read: why do we need to do lock_kernel?
References: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>	 <1145941743.8164.6.camel@lade.trondhjem.org> <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
In-Reply-To: <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:

>Thanks for your reply. So the only reason is for rpc auditing? If so,
>why not just lock the code that updating the audit information? Now
>the code is:
>
>lock_kernel()
>rpc_execute()
>unlock_kernel().
>
>That means the kernel will be blocked when rpc is executed, which
>could take long time. Even if rpc_execute() won't take very long, this
>implementation still looks inefficient. That's why I am a little
>confused on this point.
>
>Any further thought?
>

I would suggest looking at the semantics of the BKL.  They don't end up
implying what you are suggesting.  The kernel isn't really locked for
the duration of the over the wire RPC.

    Thanx...

       ps
