Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317217AbSFKRyp>; Tue, 11 Jun 2002 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSFKRyo>; Tue, 11 Jun 2002 13:54:44 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:31709 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317217AbSFKRyn> convert rfc822-to-8bit; Tue, 11 Jun 2002 13:54:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 16:23:30 +0200
User-Agent: KMail/1.4.1
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <200206111007.19142.oliver@neukum.name> <200206111406.14274.oliver@neukum.name> <20020611.050433.28184805.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206111623.30842.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 14:04 schrieb David S. Miller:
>    From: Oliver Neukum <oliver@neukum.name>
>    Date: Tue, 11 Jun 2002 14:06:14 +0200
>
>    A sparc64 is unlikely to be short on memory, or is it ?
>    What's wrong with always aligning on 128 bytes on sparc64 ?
>    A runtime check would be expensive.
>
> Maybe on arch FOO, target X needs no alignment when using PCI
> controller Y, but for PCI controller Z it does need alignment.

Still does that justify the overhead and the complications ?
Couldn't we provide for the worst case in a generic kernel
and make it a compile time option ?

If I understand you correctly, we even couldn't use kmalloc()
for allocating the buffers. IMHO you cannot expose that to
driver writers and hope to get a useful result.
So what are the alternatives ?
We could either use a bounce buffer or disable caching for the
page in question, which has its own set of problems.

	Regards
		Oliver


