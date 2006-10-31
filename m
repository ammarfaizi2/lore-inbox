Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423099AbWJaKvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423099AbWJaKvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423102AbWJaKvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:51:36 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:21184 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1423099AbWJaKvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:51:35 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
Date: Tue, 31 Oct 2006 11:51:32 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>
References: <1162199005.24143.169.camel@taijtu> <4546FA81.1020804@cosmosbay.com> <45471A05.20205@yahoo.com.au>
In-Reply-To: <45471A05.20205@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311151.33104.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 10:40, Nick Piggin wrote:

> Uh, there is nothing that says mutex_unlock or any unlock
> functions contain an implicit smp_mb(). What is given is that the
> lock and unlock obey aquire and release memory ordering,
> respectively.
>
> a = x;
> xxx_unlock
> b = y;
>
> In this situation, the load of y can be executed before that of x.
> And some architectures will even do so (i386 can, because the
> unlock is an unprefixed store; ia64 can, because it uses a release
> barrier in the unlock).

Hum... it seems your mutex_unlock() i386/x86_64 copy is not same as mine :)

Maybe we could document the fact that mutex_{lock|unlock}() has or has not an 
implicit smp_mb().

If not, delete smp_mb() calls from include/asm-generic/mutex-dec.h 

Ingo ?

Eric
