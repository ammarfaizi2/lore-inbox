Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262487AbSJDQ4p>; Fri, 4 Oct 2002 12:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbSJDQ4p>; Fri, 4 Oct 2002 12:56:45 -0400
Received: from mail3.efi.com ([192.68.228.90]:25099 "HELO
	fcexgw03.efi.internal") by vger.kernel.org with SMTP
	id <S262487AbSJDQ4n>; Fri, 4 Oct 2002 12:56:43 -0400
Message-ID: <3D9DC9E1.44D7AF7A@efi.com>
Date: Fri, 04 Oct 2002 10:03:29 -0700
From: Kallol Biswas <kallol@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>
CC: linux-kernel@vger.kernel.org, linux.nics@intel.com,
       Andrey Nekrasov <andy@spylog.ru>
Subject: Re: NIC on Intel STL2 - bad work with eepro100 & e100
References: <20021004113128.GA31145@an.local> <20021004135016.GJ6318@stingr.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 17:02:22.0404 (UTC) FILETIME=[CE538840:01C26BC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the problem is due to the sleep mode bit,
I  think the errata of Intel-STL2 documents it. We had a similar problem with our

STL2 based board,
clearing the sleep mode fixed it.

Paul P Komkoff Jr wrote:

> Replying to Andrey Nekrasov:
> >                       Intel Server Board STL2.
> >       Network: onboard NIC "Intel(R) 82559 single chip PCI LAN controller"
>
> I have almost the same behavior here except that eepro100 works
> without freezes. Maybe spylog servers' NIC load is much more higher
> than mine :)
>
> Intel support guys advised me to test both versions of e100 driver.
>
> ftp://aiedownload.intel.com/df-support/2896/eng/e100-2.1.15.tar.gz
> ftp://aiedownload.intel.com/df-support/2896/eng/e100-1.8.38.tar.gz
>
> Unfortunately, I haven't tested it yet. My investigation shows that
> the following fragment of e100_main.c code fails:
>
> <code from="e100_hw_init">
>      if (!e100_wait_exec_cmplx(bdp, 0, SCB_RUC_LOAD_BASE))
>             return false;
> </code>
>
> we returning false here.
>
> And I am stalled for now till the end of next week until the ACM ICPC
> Qfinal is over :(
>
> --
> Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
>   When you're invisible, the only one really watching you is you (my keychain)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

