Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132776AbRDIQAR>; Mon, 9 Apr 2001 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132777AbRDIQAH>; Mon, 9 Apr 2001 12:00:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:44673 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132776AbRDIP75>; Mon, 9 Apr 2001 11:59:57 -0400
Date: Mon, 9 Apr 2001 11:59:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: gis88530 <gis88530@cis.nctu.edu.tw>
cc: linux-kernel@vger.kernel.org
Subject: Re: skbuff.h
In-Reply-To: <018601c0c10c$50f5d3b0$ae58718c@cis.nctu.edu.tw>
Message-ID: <Pine.LNX.3.95.1010409114912.8832A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2001, gis88530 wrote:

> Thanks a lot.
> Do you know the purpose of csum_partial( ) function?
> I can't find out it source code.
> 

Sure. It does a partial checksum of various IP fragments when they
are being assembled. By starting with 0 as the input parameter,
and the entire length of the IP packet, you calculate the whole
checksum. It's output has to be shifted into a short, added to the
low word of the result, then inverted, to complete the TCP/IP
checksum.

It was believed that partial checksumming during various stages
of IP packet assembly would improve performance. It is possible
that performance would be improved if the checksum was done only once,
though, because there is a lot of overhead in setting up pointers and
counters prior to calculating the checksum. However, the kind of
"performance" we are talking about is probably nothing that would
actually improve network I/O. That is currently limited by the Ethernet
devices. However, some CPU cycles could be saved.

> I can't believe that I have discovered an area where an
> improvement in performance. Maybe I loss some thing.
> 
> Cheers,
> Tom


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


