Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSKKXwO>; Mon, 11 Nov 2002 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264752AbSKKXwO>; Mon, 11 Nov 2002 18:52:14 -0500
Received: from webmail.topspin.com ([12.162.17.3]:15999 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S264749AbSKKXwK>; Mon, 11 Nov 2002 18:52:10 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com>
	<52r8drn0jk.fsf_-_@topspin.com>
	<20021111.153845.69968013.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Nov 2002 15:58:59 -0800
In-Reply-To: <20021111.153845.69968013.davem@redhat.com>
Message-ID: <52n0ofmzek.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Nov 2002 23:58:55.0515 (UTC) FILETIME=[4B141EB0:01C289DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    David> So how are apps able to specify such larger hw addresses to
    David> configure a driver if IFHWADDRLEN is still 6?

In the InfiniBand case, the device's hardware address comes from a
combination of the port GID (which is set by the InfiniBand subnet
manager through an IB-specific mechanism) and the queue pair number
that the driver gets when it initializes.  There definitely still are 
problems to solve, such as specifying static ARP entries.

    David> I'm not going to increase MAX_ADDR_LEN if there is no user
    David> ABI capable of configuring such larger addresses properly.

What would you consider a palatable ABI?  (I'm happy to implement it)
Enlarging sa_data in struct sockaddr doesn't seem feasible.  I guess
we could add a new socket ioctl() or extend SIOCGIFHWADDR/SIOCSIFHWADDR
somehow....

Thanks,
  Roland <roland@topspin.com>
