Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSICNFK>; Tue, 3 Sep 2002 09:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318770AbSICNFK>; Tue, 3 Sep 2002 09:05:10 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:63756 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S318768AbSICNFJ>;
	Tue, 3 Sep 2002 09:05:09 -0400
Date: Tue, 03 Sep 2002 22:03:02 +0900 (JST)
Message-Id: <20020903.220302.26270018.taka@valinux.co.jp>
To: kuznet@ms2.inr.ac.ru
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       davem@redhat.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200209031221.QAA01882@sex.inr.ac.ru>
References: <20020903.164243.21934772.taka@valinux.co.jp>
	<200209031221.QAA01882@sex.inr.ac.ru>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > I guess it may also depend on bad implementations of csum_partial().
> > It's wrong that some architecture assume every data in a skbuff are
> > aligned on a 2byte boundary so that it would access a byte next to
> > the the last byte where no pages might be there.
> 
> Access beyond end of skb is officially allowed, within 16 bytes
> in <= 2.2, withing 64 bytes in  >=2.4. Moreover, it is not only allowed
> but highly recommended, when this can ease coding.

Skb may have some pages in its skb_shared_info as frags, but each
page may not have extra space in it while csum_partial() is used
to compute checksum against each page.

We can see skb_checksum() calls csum_partial() againt each page in skb.
No one knows whether the next page exits or not as it may be mapped
in kmap space.

Hmmm...
Only the implematation for x86 may have the problem that csum_partial()
may access beyond end of the page.

> > It's time to fix csum_partial().
> 
> Well, not depending on wrong accent put by you, the change is not useless.
> 
> Alexey
> 
> PS Gentlemen, it is not so bad idea to change subject and to trim cc list.
> Thread is went to area straight orthogonal to TSO, csum_partial is not
> used with TSO at all. :-)

