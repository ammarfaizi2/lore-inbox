Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316846AbSFKGYG>; Tue, 11 Jun 2002 02:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSFKGYF>; Tue, 11 Jun 2002 02:24:05 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:55767 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316846AbSFKGYF> convert rfc822-to-8bit; Tue, 11 Jun 2002 02:24:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>, roland@topspin.com
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 08:23:52 +0200
User-Agent: KMail/1.4.1
Cc: wjhun@ayrnetworks.com, paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <52lm9m7969.fsf@topspin.com> <52d6uy77k0.fsf@topspin.com> <20020610.213851.129507691.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206110823.52065.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 06:38 schrieb David S. Miller:
>    From: Roland Dreier <roland@topspin.com>
>    Date: 10 Jun 2002 21:39:27 -0700
>
>        David> How about allocating struct something using pci_pool?
>
>    The problem is the driver can't safely touch field1 or field2 near
> the DMA (it might pull the cache line back in too soon, or dirty the
> cache line and have it written back on top of DMA'ed data)
>
> Oh duh, I see, then go to making the thing a pointer to the
> dma area.

That would mean doing things like memory allocations for one single
byte. Also it would affect things like the scsi layer (sense buffer in
the structure).
And it would be additional overhead for everybody for the benefit
of a small minority. An alignment macro could be turned into a nop
on some architectures.

	Regards
		Oliver

