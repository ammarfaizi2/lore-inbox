Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSFIKyJ>; Sun, 9 Jun 2002 06:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSFIKyI>; Sun, 9 Jun 2002 06:54:08 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:13224 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317589AbSFIKyH>; Sun, 9 Jun 2002 06:54:07 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>, "David S. Miller" <davem@redhat.com>
Cc: <roland@topspin.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Sun, 9 Jun 2002 12:54:48 +0200
Message-Id: <20020609105448.3898@smtp.wanadoo.fr>
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Now at this point the driver calls pci_unmap_single or whatever.  What
>is pci_unmap_single to do?  If it does nothing, or does a writeback,
>we lose the DMA data.  If it does an invalidate we lose the value
>written to X.  Clearly, neither is correct.
>
>The bottom line is that we can only have one writer to any given cache
>line at a time.  If a buffer is being used for DMA from a device to
>memory, the cpu MUST NOT write to any cache line that overlaps the
>buffer.

Note that this typically happen with network drivers, some infos in
the skbuf getting lost when they happen to share a cache line with
the data portion of the skbuf. When writing a driver specific to a
non-coherent CPU, it can be worked around by reserving enough space,
but "generic" PCI drivers are still affected.

On those architectures, the core skbuf alloc routines should probably
make sure the data portion don't share a cache line with other
informations.

Ben.


