Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSFKHjx>; Tue, 11 Jun 2002 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316885AbSFKHjv>; Tue, 11 Jun 2002 03:39:51 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:42113 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316884AbSFKHjZ> convert rfc822-to-8bit; Tue, 11 Jun 2002 03:39:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 09:38:52 +0200
User-Agent: KMail/1.4.1
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <52d6uy77k0.fsf@topspin.com> <200206110823.52065.oliver@neukum.name> <20020610.233850.60926092.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206110938.52090.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 08:38 schrieb David S. Miller:
>    From: Oliver Neukum <oliver@neukum.name>
>    Date: Tue, 11 Jun 2002 08:23:52 +0200
>
>    That would mean doing things like memory allocations for one single
>    byte. Also it would affect things like the scsi layer (sense buffer
> in the structure).
>    And it would be additional overhead for everybody for the benefit
>    of a small minority. An alignment macro could be turned into a nop
>    on some architectures.
>
> The problem is people are going to get it wrong if we expose all of
> this cacheline crap to the drivers.

You don't have to fully expose it. We make a simple rule like:
If you want to do DMA to a variable it needs "DMA_ALIGN after the
name in the declaration". Architectures could define it, with generic nop.
People will get it wrong by doing DMA to members of structures
otherwise. There's no really painless way to solve this.
You have to introduce a new rule anyway.

	Regards
		Oliver

