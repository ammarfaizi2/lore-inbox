Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbRDIOhX>; Mon, 9 Apr 2001 10:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132761AbRDIOhO>; Mon, 9 Apr 2001 10:37:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:40833 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132760AbRDIOhE>; Mon, 9 Apr 2001 10:37:04 -0400
Date: Mon, 9 Apr 2001 10:36:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: nctucis <gis88530@cis.nctu.edu.tw>
cc: linux-kernel@vger.kernel.org
Subject: Re: skbuff.h
In-Reply-To: <012a01c0c0fb$b9305290$ae58718c@cis.nctu.edu.tw>
Message-ID: <Pine.LNX.3.95.1010409102624.12657A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2001, nctucis wrote:

> Hi,
> 
> I use 2.2.16 kernel.
> I found that there is a sk_buff structure in
> "/usr/src/linux/include/linux/skbuff.c", and
> there is a variable "unsigned in csum;" in 
> the sk_buff structure.
> 
> I want to know this checksum check what information.
> Could you give me a hand, please?
> 
> -=-=-=-=-=-=-=-
> In fact, I found 64byte and 1518byte UDP packet waste different
> time to do masquerade(ip_fw_masquerade). 
> Many books say NAT just modify header fields, so it should no 
> different between small and big packet size.
> I guess the different time due to csum_partial(h.raw, doff, sum)
> in ip_fw_masquerade(). Right? Thanks a lot.
> (But I can't find out source code of this function.)
> 
> Cheers,
> Tom

TCP/IP packets contain a checksum. The checksum is defined by the
standards. Linux checksums the IP packets in two ways, the first
is obvious, the second is the 'csum_partial_copy_generic' in
../linux/arch/i386/lib/checksum.S.

NAT, because it modifies the IP packet, must also modify the
checksum. However, the checksum is in the IP header so your
'books' are correct. FYI, since the checksum is known, the
IP address is known, and the standard is known. It is not
necessary to re-checksum the entire packet to produce a new
checksum after modification of some of the checksummed data
(IP address).

I think Linux recalculates the entire checksum over again so
you may have discovered an area where an improvement in performance
could be obtained.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


