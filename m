Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWDYPcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWDYPcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDYPcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:32:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:47621 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751307AbWDYPcI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:32:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tj+edv0dNiXZzXIBvbKT3XcuZpe9gmFmojDJTLrtTobD1QoCwQFHUMScj/RhNfePVNfOY8DJ+pxgwNLtk3IO7VMvLNPwUlftIOB6zS9lNCkocBLHyzOrbKefU2gX4+NqtGhKWPhIS9oJmRTSPvszfSgqxqdnsMoZi1xMwYOysfI=
Message-ID: <4ae3c140604250831v5a2f8714h7ab0beccba466da4@mail.gmail.com>
Date: Tue, 25 Apr 2006 11:31:57 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Peter Staubach" <staubach@redhat.com>
Subject: Re: question about nfs_execute_read: why do we need to do lock_kernel?
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <444E3433.1040703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
	 <1145941743.8164.6.camel@lade.trondhjem.org>
	 <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
	 <444E3433.1040703@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your guys' reply!

Peter, can you point me somewhere I can check the semantics of BKL? In
the past, I remembered BKL does block the kernel. So I am quite
confused now.

Also, I still don't understand why we use lock_kernel instead of some
finer granularity lock. Trond's answer gave me a feeling that this is
simply because the code is not carefully optimized.  :)

-x

On 4/25/06, Peter Staubach <staubach@redhat.com> wrote:
> Xin Zhao wrote:
>
> >Thanks for your reply. So the only reason is for rpc auditing? If so,
> >why not just lock the code that updating the audit information? Now
> >the code is:
> >
> >lock_kernel()
> >rpc_execute()
> >unlock_kernel().
> >
> >That means the kernel will be blocked when rpc is executed, which
> >could take long time. Even if rpc_execute() won't take very long, this
> >implementation still looks inefficient. That's why I am a little
> >confused on this point.
> >
> >Any further thought?
> >
>
> I would suggest looking at the semantics of the BKL.  They don't end up
> implying what you are suggesting.  The kernel isn't really locked for
> the duration of the over the wire RPC.
>
>     Thanx...
>
>        ps
>
