Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313962AbSDPX3w>; Tue, 16 Apr 2002 19:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313963AbSDPX3v>; Tue, 16 Apr 2002 19:29:51 -0400
Received: from fungus.teststation.com ([212.32.186.211]:54796 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313962AbSDPX3u>; Tue, 16 Apr 2002 19:29:50 -0400
Date: Wed, 17 Apr 2002 01:29:48 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Christian =?iso-8859-15?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: smbfs 2.4.19pre6
In-Reply-To: <200204162310.09755.linux-kernel@borntraeger.net>
Message-ID: <Pine.LNX.4.33.0204170103300.5458-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Christian [iso-8859-15] Bornträger wrote:

> Hello list,
> 
> I have a smbfs mounted samba-share that got lost due to a network error.
> 
> Every process accessing the mount point falls into uniterruptable sleep - till 
> the reboot. Even a lsof is frozen. 
> 
> Is this a bug or a known issue?

It's known, and it's a bug. The network part of smbfs has a few problems.

I did some patches that used poll to check if they could send things and
timeout after 30 seconds. Perhaps combined with checking the tcp state
would work for this case.

The overly long delay (and most people would assume it is frozen) is one
or more network timeouts (tcp level?) that needs to pass before the 
process stops.

That the mount fails to recover could be related to smbmount not managing
to stay alive.

For 2.5 there is work going on that should fix this at the same time as it
allows oplock support and stuff. The process should always be
interruptible.

/Urban

