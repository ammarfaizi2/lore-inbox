Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVIGAHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVIGAHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 20:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVIGAHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 20:07:12 -0400
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:41869 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S1751154AbVIGAHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 20:07:10 -0400
Message-Id: <200509070006.j8706YlA003082@ms-smtp-02-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Herbert Xu'" <herbert@gondor.apana.org.au>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <netdev@vger.kernel.org>, <olel@ans.pl>,
       <bugme-daemon@kernel-bugs.osdl.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David S. Miller'" <davem@davemloft.net>
Subject: RE: Fw: [Bugme-new] [Bug 5194] New: IPSec related OOps in 2.6.13
Date: Tue, 6 Sep 2005 20:06:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWy3a4ySw2SY5qnTCCAcrDJL/ihDwAYgh6A
In-Reply-To: <20050906122029.GB4594@gondor.apana.org.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch worked like a charm here, no more kernel panics! Excellent work, many
thanks for the quick fix...more people should have such a work ethic.

Cheers,
Matt

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Herbert Xu
> Sent: Tuesday, September 06, 2005 8:20 AM
> To: Andrew Morton
> Cc: netdev@vger.kernel.org; olel@ans.pl; bugme-daemon@kernel-
> bugs.osdl.org; Matt LaPlante; Linux Kernel Mailing List; David S. Miller
> Subject: Re: Fw: [Bugme-new] [Bug 5194] New: IPSec related OOps in 2.6.13
> 
> On Tue, Sep 06, 2005 at 04:08:56AM -0700, Andrew Morton wrote:
> >
> > Problem Description:
> >
> > Oops: 0000 [#1]
> > PREEMPT
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c01f562c>]    Not tainted VLI
> > EFLAGS: 00010216   (2.6.13)
> > EIP is at sha1_update+0x7c/0x160
> 
> Thanks for the report.  Matt LaPlante had exactly the same problem
> a couple of days ago.  I've tracked down now to my broken crypto
> cipher wrapper functions which will step over a page boundary if
> it's not aligned correctly.
> 
> 
> [CRYPTO] Fix boundary check in standard multi-block cipher processors
> 
> The boundary check in the standard multi-block cipher processors are
> broken when nbytes is not a multiple of bsize.  In those cases it will
> always process an extra block.
> 
> This patch corrects the check so that it processes at most nbytes of data.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Cheers,
> --
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


