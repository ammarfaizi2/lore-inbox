Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbVHKKe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVHKKe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVHKKe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:34:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43496 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964908AbVHKKe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:34:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine ethernet driver bug (reprise)
Date: Thu, 11 Aug 2005 13:34:08 +0300
User-Agent: KMail/1.5.4
References: <42F64C9F.602@xs4all.nl>
In-Reply-To: <42F64C9F.602@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111334.08394.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 August 2005 21:02, Udo van den Heuvel wrote:
> Hello,
> 
> In january of this year I mentioned a problem with the Linux kernel
> driver for VIA Rhine ethernet chips. (see http://lkml.org/lkml/2005/1/15/47)
> In the mean time this bug was reproduced quite a number of times on my
> Fedora Core 3 (then)/4 (now) box (a VIA CL6000).
> 
> An alternative driver by VIA was used (with kernel 2.6.1x,
> http://www.viaarena.com/downloads/Source/rhinefet.tgz); this VIA driver
> did not have the Oversized ethernet frame bug but consumes quite a lot
> of CPU when transfering a steady stream of a few 1000 KB/S, so it is no
> good solution.
> 
> Since the ethernet connection goes down due to this bug I think I can
> mark the bug as critical. The bug is still present in 2.6.12.
> The maintainer of the driver cannot fix the bug. Who can?

at http://lkml.org/lkml/2005/1/15/47:
> I see messages like:
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple buffers, entry 0x4 length 0 status 00000600!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80040 vs ccf80040.
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple buffers, entry 0x5 length 0 status 00000400!
...
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame spanned multiple buffers, entry 0x3 length 0 status 00000581!
Jan 13 19:35:46 epia kernel: eth1: Oversized Ethernet frame ccf80030 vs ccf80030.
every 3 or 4 days or so when I really use the card. (please notice all 16 entries are used and the length is 0)
>While googlin' I saw that this is an old bug which was not fixed for years.
I am in contact with the maintainer and currently am trying to see what
effect a smaller mtu and/or older driver versions might have.
>Because of the impact of this nasty bug (many users have these chips in
their hardware) I would like to ask if others could have a look into this
problem as well. Please email me your experiences (2.6.x kernel? Same bug or
no problem? Fixes? Etc).

What is "ccf80030 vs ccf80030"? Those numbers are the same...
Maybe you need to add more debugging prints in that part of code.

But anyway:

Since it happens less than once a day, why not just add a code
to reset the NIC completely in this case, like it is
typically done in tx_timeout handlers of many NICs, and forget about it?
--
vda

