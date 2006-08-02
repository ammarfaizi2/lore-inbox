Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWHBBKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWHBBKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 21:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWHBBKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 21:10:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:63406 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750924AbWHBBKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 21:10:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ytXtoOAgH5l9DBCtpp8Vr7y3e5bzjKZz6UG1jRFFU8EfJdNKsDJ0koVNNm9Ns7rSs
	yxCU9cLH28ow4naWQxxsA==
Message-ID: <e561bacc0608011810r1313a361h28263b2fa0bf876e@mail.google.com>
Date: Tue, 1 Aug 2006 21:10:08 -0400
From: "Alex Polvi" <polvi@google.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] sunrpc/auth_gss: NULL pointer deref in gss_pipe_release()
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154378242.13744.14.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e561bacc0607310750p2cba1576m6564a356b94dd26c@mail.google.com>
	 <1154378242.13744.14.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Mon, 2006-07-31 at 10:50 -0400, Alex Polvi wrote:
> > Proposed (trivial) patch to fix a NULL pointer deref in
> > gss_pipe_release(). While this does seem to fix the problem, I'm not
> > entirely sure it is the correct place to handle the NULL pointer.
> >
> > Included below is the script I used to recreate the problem, the oops,
> > and the patch.
>
> Sorry, but that is not the correct fix. The problem here is rather that
> something is causing us to call rpc_close_pipes() on the file after the
> call to gss_destroy(). That is supposed to be illegal.

Would you be willing to explain what should happen? I.e. what is the
lifecycle of an RPC inode?

Thanks,

-Alex
