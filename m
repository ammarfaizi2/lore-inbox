Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSGAQO7>; Mon, 1 Jul 2002 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGAQO6>; Mon, 1 Jul 2002 12:14:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35087 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315779AbSGAQOy>;
	Mon, 1 Jul 2002 12:14:54 -0400
Message-ID: <3D208086.7070603@mandrakesoft.com>
Date: Mon, 01 Jul 2002 12:17:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru> <20020701075418.GA13908@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:
> Hi Ivan, Alan, Marcelo,
> 
> On Sun, Jun 30, 2002 at 03:50:58AM +0400, Ivan Kokshaysky wrote:
> 
>>On Sat, Jun 29, 2002 at 03:28:50AM +0100, Alan Cox wrote:
>>
>>>Please back it back in. The bug is the Alpha port. Alpha needs its own OSF
>>>readv/writev entry point which masks the top bits.
>>
>>Ouch. The new entry point just because of this?!
>>Marcelo, if you're going to back in that patch, please apply
>>the following on the top of it.
> 
> 
> This patch indeed makes acroread & netscape work again on my alpha. Nice
> spotting.
> Don't we know about the type of binary? (Like personality ...)
> So we could use something like
>    ssize_t len
>  #ifdef __alpha__
>    if (current->personality == DEC_OSF_OLD)
>      len = (int) iov[i].iov_len;
>    else
>      len = (ssize_t) iov[i].iov_len;
>  #else
>    len = (ssize_t) iov[i].iov_len;
>  #endif
> 
> Not really beautiful, but working for all cases.


That's a good point.

FWIW we have Mozilla 1.0.x working just fine on Alpha, so I don't mind 
second-classing, or making optional, OSF/1 binary support.

It _should_ be possible to correctly support SuSv3 and OSF/1 binaries 
simultaneously.

	Jeff



