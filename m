Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281422AbRKMBO3>; Mon, 12 Nov 2001 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281424AbRKMBOT>; Mon, 12 Nov 2001 20:14:19 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:57605 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S281422AbRKMBOK>; Mon, 12 Nov 2001 20:14:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: helgehaf@idb.hist.no, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives? 
In-Reply-To: Your message of "Mon, 12 Nov 2001 15:23:04 PDT."
             <20011112.152304.39155908.davem@redhat.com> 
Date: Tue, 13 Nov 2001 10:14:22 +1100
Message-Id: <E163QHW-0007gY-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20011112.152304.39155908.davem@redhat.com> you write:
>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Mon, 12 Nov 2001 20:59:05 +1100
> 
>    (atomic_inc & atomic_dec_and_test for every packet, anyone?).
> 
> We already do pay that price, in skb_release_data() :-)

Sorry, I wasn't clear!  skb_release_data() does an atomic ops on the
skb data region, which is almost certainly on the same CPU.  This is
an atomic op on a global counter for the module, which almost
certainly isn't.

For something which (statistically speaking) never happens (module
unload).

Ouch,
Rusty.
--
Premature optmztion is rt of all evl. --DK
