Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290822AbSARVIu>; Fri, 18 Jan 2002 16:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSARVIm>; Fri, 18 Jan 2002 16:08:42 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:22568 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290822AbSARVI0> convert rfc822-to-8bit; Fri, 18 Jan 2002 16:08:26 -0500
Date: Fri, 18 Jan 2002 22:07:09 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
cc: <hozer@drgw.net>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>, <rmk@arm.linux.org.uk>,
        <dan@embeddededge.com>, <mattl@mvista.com>
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <20020118.123837.21900127.davem@redhat.com>
Message-ID: <20020118215449.K2042-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 18 Jan 2002, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Fri, 18 Jan 2002 21:21:35 +0100 (CET)
>
>    I have noted that some ports may [ever] require pci_alloc_consistent not
>    to be called from interrupt context. Just I will look into this when time
>    will allow.
>
> Do not bother Gerard, these ports really are broken and
> pci_alloc_consistent must work from interrupts.
>
>    I am not going to ever use not cache coherent hardware, even if I am ready
>    to make the sym driver work reliably on such brain-dead things. Just it is
>    not high priority stuff for now.
>
> Perhaps you misunderstand, it is not "lack of cache coherency" it is
> "cache needs flushing around DMA transfers" and this is handled
> perfectly by PCI DMA interfaces.  It is nothing you should be
> concerned about.

Depends on the OS.

Under Linux, PCI consistent allocation support is a requirement. Let me
cross fingers for this to stay as it is. :)

Under some other (NetBSD, for example, just not to name it :)), such
feature is just a hint and as a result drivers are theorically also
required to care about cache flushing for DMAs that involve driver
internal data structures if full portability is in concern. Btw, I donnot
really use NetBSD O/S but just ported sym-2 to it (NetBSD-1.5 with
coherency being a requirement for driver data structure allocations) as an
exercise.

  Gérard.

