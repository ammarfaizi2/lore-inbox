Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSFTNSi>; Thu, 20 Jun 2002 09:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFTNSh>; Thu, 20 Jun 2002 09:18:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41776 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314396AbSFTNSg>; Thu, 20 Jun 2002 09:18:36 -0400
Date: Thu, 20 Jun 2002 15:19:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620131951.GD10718@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <20020620114459.GA13532@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620114459.GA13532@spylog.ru>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 03:44:59PM +0400, Andrey Nekrasov wrote:
> Hello Andrea Arcangeli,
> 
> 
> Kernel 2.4.19pre10aa3 + hidden_arp (from LVS)
> 
> 
> 
> ...
> Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.8.38
> Copyright (c) 2002 Intel Corporation
> 
> eth0: Intel(R) 8255x-based Ethernet Adapter
>   Mem:0xfb101000  IRQ:18  Speed:100 Mbps  Dx:Full
>   Hardware receive checksums enabled
>   cpu cycle saver enabled
> ...
> 
> ...
> eth0 e100_wait_exec_cmd: Wait failed.
> hw tcp v4 csum failed
> hw tcp v4 csum failed
> hw tcp v4 csum failed
> hw tcp v4 csum failed
> hw tcp v4 csum failed
> hw tcp v4 csum failed
> hw tcp v4 csum failed
> ...
> 
> 
> Than this message is caused? It something serious also can be problems?

probably a driver issue with hw checksum. btw interestingly the stack
computes the cksum by hand for every tcp incoming packet (unless
ip_summed is set by the driver to CHECKSUM_UNNECESSARY), this is how it
noticed the hw checksum was wrong. I guess it's either an e100 driver
issue, or an hardware issue. Maybe it's setting DF_CSUM_OFFLOAD for your
card despite your hardware doesn't support that feature, or maybe
there's something wrong in the logic that sets the skb->csum.

Andrea
