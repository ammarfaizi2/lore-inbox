Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRB1Jjx>; Wed, 28 Feb 2001 04:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbRB1Jjn>; Wed, 28 Feb 2001 04:39:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129393AbRB1Jjf>; Wed, 28 Feb 2001 04:39:35 -0500
Subject: Re: rx_copybreak value for non-i386 architectures
To: jsun@mvista.com (Jun Sun)
Date: Wed, 28 Feb 2001 09:42:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A9C6336.D2E086A6@mvista.com> from "Jun Sun" at Feb 27, 2001 06:32:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Y38I-0005Iu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for non-i386 architectures.  Once I thought I understood it and it seems
> related to cache line alignment.  However, I am not sure exactly about the
> reason now.  Can someone enlighten me a little bit?

A lot of pci net cards can only start packets on a 4 byte boundary. A lot
of CPU's need 4 byte aligned read/writes for performance. The ethernet header
is howerver 14 bytes long.

For CPU's with poor unaligned performance it turns out better to copy or
copy/checksum the data so the IP/TCP headers are aligned. If the card can
hit 16bit boundaries then you will see card drivers doing


	alloc_skb(blah)

	skb_reserve(skb, 2);

to align the header of he buffer so that the IP data is aligned


