Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSGTXMR>; Sat, 20 Jul 2002 19:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317587AbSGTXMR>; Sat, 20 Jul 2002 19:12:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38130 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317586AbSGTXMQ>; Sat, 20 Jul 2002 19:12:16 -0400
Subject: Re: [PATCH] generalized spin_lock_bit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rml@tech9.net, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@conectiva.com.br,
       wli@holomorphy.com
In-Reply-To: <20020720.152703.102669295.davem@redhat.com>
References: <1027196511.1555.767.camel@sinai> 
	<20020720.152703.102669295.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 01:26:25 +0100
Message-Id: <1027211185.17234.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 23:27, David S. Miller wrote:
> Why not just use the existing bitops implementation?  The code is
> going to be mostly identical, ala:
> 
> 	while (test_and_set_bit(ptr, nr)) {
> 		while (test_bit(ptr, nr))
> 			barrier();
> 	}

Firstly your code is wrong for Intel already

Secondly many platforms want to implement their locks in other ways.
Atomic bitops are an x86 luxury so your proposal simply generates
hideously inefficient code compared to arch specific sanity


