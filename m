Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280195AbRKIV5u>; Fri, 9 Nov 2001 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280200AbRKIV5j>; Fri, 9 Nov 2001 16:57:39 -0500
Received: from oe42.law11.hotmail.com ([64.4.16.100]:6160 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280195AbRKIV53>;
	Fri, 9 Nov 2001 16:57:29 -0500
X-Originating-IP: [66.108.21.174]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "Ronny Lampert \(EED\)" <Ronny.Lampert@eed.ericsson.se>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEBC9F5.92D90C41@eed.ericsson.se>
Subject: Re: 2.4.14: crashing on heavy swap-load with SmartArray
Date: Fri, 9 Nov 2001 16:55:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE42dveoo5MYtHs8Bry0000a0e0@hotmail.com>
X-OriginalArrivalTime: 09 Nov 2001 21:57:23.0929 (UTC) FILETIME=[835A2490:01C16969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ok my original response to you may have been wrong.  I think that patch
may not have fixed my problem with the cpqarray driver though I could be
wrong.  If the patch doesn't work for you try downgrading the cpqarray
driver.  Copy the cpqarray.[ch], ida_cmd.h, and ida_ioctl.h files from the
drivers/block directory from an earlier kernel source tree over the ones in
your 2.4.14 kernel source tree.  This fixed the problem I had.

----- Original Message -----
From: "Ronny Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, November 09, 2001 7:20 AM
Subject: 2.4.14: crashing on heavy swap-load with SmartArray


> Hello,
>
> Total crash (Aieeee: Killing interrupt handlers...) on an compaq 6400R
> Dual PIII Xeon 500, 3GB Ram + 1G Swap, custom kernel (SMP,
> smartarray/eepro100 into kernel).
>
> syslog says:
> Nov  9 13:05:54 eedn36ls kernel: Invalid request on ida/c0d0 = (cmd=30
> sect=5490
> 904 cnt=112 sg=12 ret=10)
>
> console:
> Invalid request ...(same as above)
> invalid operand: 0000
> CPU: 1
> EIP: 0010: [<c0123b3e>] EFLAGS: 00010046
> eax: 0 ebx: edd98500 ecx: 1 edx: c1a80dc0
> esi: 2 edi: c1a80dc0 ebp: 1 esp: c4039efc
> ds: 0018 es: 0018 ss: 0018
>
> (...)
>
> Process: swapper (PID: 0, stackpage=c4039000) ...
> ....
> Code: 0f 0b 8d 5a 24 8d 42 28 39 42 28 74 11 b9 01 00 00 00 ba 03
>
> On the second crash, there was a slight change:
> No reporting about an invalid request on ida/c0d0 but:
>
> CPU: 0
> same EIP, EFLAGS
>
> Process: mtest01 (PID: 683, stackpage=f7439000)
> ....
>
> same Code: ...
>
> It is reproduceable on 2.4.14 (first compile using 2.91.66 gcc, second
> 2.95.3 gcc) using mtest01 from the Linux Testing Project
> (ltp-20010801/ltctests/mem/mtest01).
> I also applied the newest microcodeupdate from Intel, stays the same.
> 2.2.19 is doing fine (with bigmempatch, of course).
>
> I used params: ./mtest01 -w -c $[25*1024*1024] -p 60 and started 3
> processes. This will allocate 60% of total system ram on each process in
> 25MB chunks and will write to it after allocating.
>
> If more infos are required, I will try me best to write down the
> kernel-panic :)
> Please include me on CC.
>
> Kind regards,
> Ronny
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
