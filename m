Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSIIJA5>; Mon, 9 Sep 2002 05:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSIIJA4>; Mon, 9 Sep 2002 05:00:56 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:47377 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S316674AbSIIJA4>;
	Mon, 9 Sep 2002 05:00:56 -0400
Date: Mon, 09 Sep 2002 17:58:21 +0900 (JST)
Message-Id: <20020909.175821.108746773.taka@valinux.co.jp>
To: davem@redhat.com
Cc: "Feldman, Scott" <scott.feldman@intel.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS for 2.5.33
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020909.001902.28439948.davem@redhat.com>
References: <20020909.161123.74745039.taka@valinux.co.jp>
	<20020909.001902.28439948.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As far as I know e1000 has a feature that it can split a jumbo UDP frame
into some IP fragments.

>    From: Hirokazu Takahashi <taka@valinux.co.jp>
>    Date: Mon, 09 Sep 2002 16:11:23 +0900 (JST)
> 
>    Using TSO code is commented out at this moment as TSO for UDP isn't
>    implemented yet. I'm waiting for it so that we would remove "#ifdef NotYet"
>    to send jumbo UDP frames without any fragmentation and any checksumming.
>    Then I hope we will get great performance.
>    
> Actually, device interface for what could be used is there, see
> NETIF_F_FRAGLIST.  No devices set this and IP never makes use of it
> yet though :-)
> 
> Acenic and Tigon3 will be able to do this, probably e1000 has this
> feature as well.
> 
> But it does not work how you imagine.  One passes already fragmented
> list of packets to card, and it can checksum the packet if you tell it
> which descriptor is first of fragmented frame and which is last.
> 
> It does not do the fragmentation of UDP frames for you, only
> checksumming of UDP portion.  No card does what you mention.
