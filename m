Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291994AbSBTSpg>; Wed, 20 Feb 2002 13:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292181AbSBTSp0>; Wed, 20 Feb 2002 13:45:26 -0500
Received: from elin.scali.no ([62.70.89.10]:42246 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S291994AbSBTSpP>;
	Wed, 20 Feb 2002 13:45:15 -0500
Date: Wed, 20 Feb 2002 19:44:58 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
To: "David S. Miller" <davem@redhat.com>
cc: <jgarzik@mandrakesoft.com>, <jmerkey@vger.timpanogas.org>,
        <linux-kernel@vger.kernel.org>, <jmerkey@timpanogas.org>
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
In-Reply-To: <20020220.093034.112623671.davem@redhat.com>
Message-ID: <Pine.LNX.4.30.0202201940480.20082-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, David S. Miller wrote:

>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Wed, 20 Feb 2002 12:26:12 -0500
>
>    type abuse aside, and alpha bugs aside, this looks ok... what is the
>    value of as->msize?
>
> Jeff and Jeff, the problem is one of two things:
>
> 1) when you have ~2GB of memory the vmalloc pool is very small
>    and this it the same place ioremap allocations come from
>
> 2) the BIOS or Linus is not assigning resources of the device
>    properly, or it simple can't because the available PCI MEM space
>    with this much memory is too small
>
> I note that one of the resources of the card is 16MB or so.

Hi guys,

There is actually no need to have all three regions mapped at all times is
there Jeff ? In the Scali ICM driver we actually doesn't ioremap() the
prefetchable space at all because this is done with the mmap() method to
the userspace clients. If you have a kernel space client though ioremap()
is used, but only the parts of it that is needed (based on the number of
nodes in the cluser and the shared memory size per node).

Regards,

 --
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

