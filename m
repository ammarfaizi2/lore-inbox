Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRHFAdE>; Sun, 5 Aug 2001 20:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRHFAcz>; Sun, 5 Aug 2001 20:32:55 -0400
Received: from zero.aec.at ([195.3.98.22]:5386 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S265810AbRHFAcm>;
	Sun, 5 Aug 2001 20:32:42 -0400
To: "" <simon@baydel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP zero-copy
In-Reply-To: <663CE32D.1D4A9213.0F45C3B8@netscape.net> <15210.4821.318434.454971@pizda.ninka.net> <3B6A7B96.1591.241743@localhost>
From: Andi Kleen <ak@muc.de>
Date: 06 Aug 2001 02:32:36 +0200
In-Reply-To: ""'s message of "Fri, 03 Aug 2001 11:30:11 +0200"
Message-ID: <k2elqqdo4b.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B6A7B96.1591.241743@localhost>,
"" <simon@baydel.com> writes:

> I have written a driver for an Intel ixf1002 chip, which has some 
> surrounding HW, and is capable of checksumming and processing 
> dma in fragments. Is there any information on what changes I 
> would have to make to the driver to support zerocopy/checksum ?  

The driver has to set dev->features to its checksum  capabilities (see skbuff.h
for more details) and implement them. It should also be able to process
skbs with multiple skb fragments in hard_start_xmit for true zero copy;
in this case set NETIF_F_SG and also NETIF_F_HIGHDMA if it supports 64bit
addresses. When NETIF_F_SG and NETIF_F_IP_CSUM or NETIFI_F_HW_CSUM are set
the stack will do zero copy IO on TX with sendfile.

-Andi


-Andi
