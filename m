Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273801AbRIXFpu>; Mon, 24 Sep 2001 01:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273802AbRIXFps>; Mon, 24 Sep 2001 01:45:48 -0400
Received: from sydney4.au.ibm.com ([202.135.142.205]:64526 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S273801AbRIXFp1>; Mon, 24 Sep 2001 01:45:27 -0400
Date: Mon, 24 Sep 2001 15:40:28 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5
Message-Id: <20010924154028.68601c0e.rusty@rustcorp.com.au>
In-Reply-To: <5847.1001307249@kao2.melbourne.sgi.com>
In-Reply-To: <E15lNTG-0000F2-00@wagner>
	<5847.1001307249@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001 14:54:09 +1000
Keith Owens <kaos@ocs.com.au> wrote:
>   rmmod
>     loses race
>     return OK
>     module is still in use, user is confused

Ah, I see... no, it's currently:

   rmmod
      loses race
      waits for module count to hit zero

This can be desirable behavior (rmmod -f).  It's not good if you wanted
auto-module-unloading, but then, we've never wanted to take the hit to have
a pagable kernel, and I don't think we should do so.

Cheers,
Rusty.

