Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269688AbSIRXFI>; Wed, 18 Sep 2002 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269690AbSIRXFI>; Wed, 18 Sep 2002 19:05:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50574 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269688AbSIRXFI>;
	Wed, 18 Sep 2002 19:05:08 -0400
Date: Wed, 18 Sep 2002 16:00:57 -0700 (PDT)
Message-Id: <20020918.160057.17194839.davem@redhat.com>
To: taka@valinux.co.jp
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020918.171431.24608688.taka@valinux.co.jp>
References: <20020918.171431.24608688.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Wed, 18 Sep 2002 17:14:31 +0900 (JST)
   
   
   1)
   ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va10-hwchecksum-2.5.36.patch
   This patch enables HW-checksum against outgoing packets including UDP frames.
   
Can you explain the TCP parts?  They look very wrong.

It was discussed long ago that csum_and_copy_from_user() performs
better than plain copy_from_user() on x86.  I do not remember all
details, but I do know that using copy_from_user() is not a real
improvement at least on x86 architecture.

The rest of the changes (ie. the getfrag() logic to set
skb->ip_summed) looks fine.

   3)
   ftp://ftp.valinux.co.jp/pub/people/taka/2.5.36/va-csumpartial-fix-2.5.36.patch
   This patch fixes the problem of x86 csum_partilal() routines which
   can't handle odd addressed buffers.
   
I've sent Linus this fix already.
