Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSKLPHm>; Tue, 12 Nov 2002 10:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSKLPHm>; Tue, 12 Nov 2002 10:07:42 -0500
Received: from webmail.topspin.com ([12.162.17.3]:43028 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S261661AbSKLPHl>; Tue, 12 Nov 2002 10:07:41 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com>
	<52r8drn0jk.fsf_-_@topspin.com>
	<20021111.153845.69968013.davem@redhat.com>
	<1037060322.2887.76.camel@irongate.swansea.linux.org.uk>
	<52isz3mza0.fsf@topspin.com>
	<1037111029.8321.12.camel@irongate.swansea.linux.org.uk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Nov 2002 07:14:30 -0800
In-Reply-To: <1037111029.8321.12.camel@irongate.swansea.linux.org.uk>
Message-ID: <521y5qn7l5.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Nov 2002 15:14:26.0984 (UTC) FILETIME=[30C91A80:01C28A5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    Alan> AX.25 addresses are 7 bytes long at the physical layer, but
    Alan> because they including routing info up to about 60 bytes
    Alan> long elsewhere. Fortunately lengths are passed to all but
    Alan> the hw level SIOCSIF/SIOCGIF calls, and even those can be
    Alan> increased a little without harm as they use the struct
    Alan> sockaddr - in fact I think 14 bytes would be the limit.

    Alan> Seems trivial to do in 2.5 and quite doable in 2.4 if you
    Alan> actually have to worry about this at the
    Alan> SIOCSIFADDR/GIFHWADDR level.

Hmm... the problem I would like to solve is that IP-over-InfiniBand
has 20 byte hardware addresses.  One can implement a driver that lies
about its HW address len (you have an internal ARP cache and only
expose a hash value/cookie to the rest of the world).  In fact I've
done just that for IPoIB.

It works but it's ugly and overly complex.  I would like to find a
clean solution for 2.5/2.6, but it looks like it will require changes
to the net core.  I'd like to do those now so the IPoIB driver can
just drop in cleanly later.  (I want to be able to just add
drivers/infiniband during 2.6 without and invasive changes required)

To do that seems to require increasing MAX_ADDR_LEN -- otherwise I
don't see what the driver can put in addr_len/dev_addr.

Thanks,
  Roland
