Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbSKLU3W>; Tue, 12 Nov 2002 15:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266931AbSKLU3W>; Tue, 12 Nov 2002 15:29:22 -0500
Received: from webmail.topspin.com ([12.162.17.3]:24705 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S266933AbSKLU3U>; Tue, 12 Nov 2002 15:29:20 -0500
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
	<521y5qn7l5.fsf@topspin.com>
	<1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Nov 2002 12:36:10 -0800
In-Reply-To: <1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
Message-ID: <52adkele4l.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-OriginalArrivalTime: 12 Nov 2002 20:36:06.0234 (UTC) FILETIME=[2008F3A0:01C28A8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    Alan> 1. Increase MAX_ADDR_LEN 2. Add some new address setting
    Alan> ioctls, and ensure the old ones keep the old address length
    Alan> limit. That is needed because the old caller wont have
    Alan> allocated enough address space for a 20 byte address return.

Thanks to YOSHIFUJI Hideaki / 吉藤英明, I had a look at rtnetlink.  It
seems like we would get the necessary address setting functionality if
I implemented the following:

  1. Add an RTM_SETLINK message type that handles at least the
     IFLA_ADDRESS attribute.  This would replace SIOCSIFHWADDR for
     interfaces with long hardware addresses.

  2. Add code to handle receiving RTM_NEWNEIGH and RTM_DELNEIGH
     messages from user space.  This would replace SIOCSARP and
     SIOCDARP for interfaces with long hardware addresses.

Dave, Alan, if I wrote a patch to do this would you accept it?  (And
following that increase MAX_ADDR_LEN?)

(By the way the original patch I posted added code to the
SIOCSIFHWADDR/SIOCGIFHWADDR handler to prevent a long hardware address
from overrunning the ifr_data member that user space passed in)

Thanks,
  Roland
