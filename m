Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbRB1CrG>; Tue, 27 Feb 2001 21:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130053AbRB1Cq6>; Tue, 27 Feb 2001 21:46:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40834 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130051AbRB1Cqs>;
	Tue, 27 Feb 2001 21:46:48 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15004.26126.381933.963074@pizda.ninka.net>
Date: Tue, 27 Feb 2001 18:44:30 -0800 (PST)
To: Jun Sun <jsun@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rx_copybreak value for non-i386 architectures
In-Reply-To: <3A9C6336.D2E086A6@mvista.com>
In-Reply-To: <3A9C6336.D2E086A6@mvista.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jun Sun writes:
 > I notice that many net drivers set rx_copybreak to 1518 (the max packet size)
 > for non-i386 architectures.  Once I thought I understood it and it seems
 > related to cache line alignment.  However, I am not sure exactly about the
 > reason now.  Can someone enlighten me a little bit?

Most non-x86 architectures take a large hit for unaligned accesses.
If the ethernet chip cannot land the beginning of the packet at an
arbitrary byte offset (a modulo 2 offset for ethernet is needed for an
aligned IP header) then the rx_copybreak is set to the ethernet MTU
so that all packets get copied into new buffers where they can have
their header aligned.

Later,
David S. Miller
davem@redhat.com

