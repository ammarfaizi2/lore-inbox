Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbSKLNwC>; Tue, 12 Nov 2002 08:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266581AbSKLNwC>; Tue, 12 Nov 2002 08:52:02 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:11686 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266565AbSKLNwC>; Tue, 12 Nov 2002 08:52:02 -0500
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <52isz3mza0.fsf@topspin.com>
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com> <52r8drn0jk.fsf_-_@topspin.com>
	<20021111.153845.69968013.davem@redhat.com>
	<1037060322.2887.76.camel@irongate.swansea.linux.org.uk> 
	<52isz3mza0.fsf@topspin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 14:23:49 +0000
Message-Id: <1037111029.8321.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 00:01, Roland Dreier wrote:
> What drivers in the kernel are there with address length more than
> MAX_ADDR_LEN?  What do they put dev->addr_len and dev->dev_addr?

AX.25 addresses are 7 bytes long at the physical layer, but because they
including routing info up to about 60 bytes long elsewhere. Fortunately
lengths are passed to all but the hw level SIOCSIF/SIOCGIF calls, and
even those can be increased a little without harm as they use the
struct sockaddr - in fact I think 14 bytes would be the limit.

Seems trivial to do in 2.5 and quite doable in 2.4 if you actually have
to worry about this at the SIOCSIFADDR/GIFHWADDR level.

Alan

