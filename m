Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbRECXuV>; Thu, 3 May 2001 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbRECXuL>; Thu, 3 May 2001 19:50:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36485 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135484AbRECXuC>;
	Thu, 3 May 2001 19:50:02 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15089.61095.23597.82875@pizda.ninka.net>
Date: Thu, 3 May 2001 16:49:59 -0700 (PDT)
To: mike_phillips@urscorp.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
In-Reply-To: <OFB60DB560.B716D10F-ON84256A41.007A7A73@urscorp.com>
In-Reply-To: <OFB60DB560.B716D10F-ON84256A41.007A7A73@urscorp.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mike_phillips@urscorp.com writes:
 > Any suggestions on heuristics for this ? 
 > Say maybe copy if skb->len <= eth_max_mtu, skb->len <= skb->truesize * .5, 
 > or just copy the packets no matter what size. 

Pick a percentage of "acceptable waste" (ie. ratio of truesize to
len).

We know that cutoff values ~200 work for ethernet, for example.

On the topic of these checks that drop the packets, just so there
there is no misunderstanding.  We can't remove them else users
could consume memory in a basically uncontrolled manner.

Later,
David S. Miller
davem@redhat.com
