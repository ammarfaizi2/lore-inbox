Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWDYOIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWDYOIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDYOIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:08:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:14733 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932228AbWDYOIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:08:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S5ACAC3M9rMJA6vGO9jL7TbOQ+al7l3O1qJpu8D+WXYs/bu0fGQq5VZWH37jkESpwdgBaADmN12ciNk+4FKCRUbwmCrx9G8RvRxw9Y8kq+gmnwmhTqgwDGJm8vNkD322yUStQiy1RQsEr+7DTIBNtUrN0c1AIGu1e7foXW5khTU=
Message-ID: <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
Date: Tue, 25 Apr 2006 10:08:17 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: question about nfs_execute_read: why do we need to do lock_kernel?
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1145941743.8164.6.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
	 <1145941743.8164.6.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply. So the only reason is for rpc auditing? If so,
why not just lock the code that updating the audit information? Now
the code is:

lock_kernel()
rpc_execute()
unlock_kernel().

That means the kernel will be blocked when rpc is executed, which
could take long time. Even if rpc_execute() won't take very long, this
implementation still looks inefficient. That's why I am a little
confused on this point.

Any further thought?

Xin


On 4/25/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Tue, 2006-04-25 at 00:57 -0400, Xin Zhao wrote:
> > This question may be dumb. But I am curious why in nfs_execute_read()
> > function, rpc_execute  is bracketed with lock_kernel() and
> > unlock_kernel()?
>
> We're keeping the BKL for the moment simply because we are not done
> auditing all the RPC code for potential races. When that is done, we
> will be able to remove it.
>
> Cheers,
>   Trond
>
>
