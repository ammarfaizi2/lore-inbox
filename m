Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280162AbRKIVl4>; Fri, 9 Nov 2001 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280163AbRKIVlr>; Fri, 9 Nov 2001 16:41:47 -0500
Received: from oe54.law11.hotmail.com ([64.4.16.47]:25608 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280162AbRKIVll>;
	Fri, 9 Nov 2001 16:41:41 -0500
X-Originating-IP: [66.108.21.174]
From: "Linux Kernel Developer" <linux_developer@hotmail.com>
To: "Ronny Lampert \(EED\)" <Ronny.Lampert@eed.ericsson.se>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEBC9F5.92D90C41@eed.ericsson.se>
Subject: Re: 2.4.14: crashing on heavy swap-load with SmartArray
Date: Fri, 9 Nov 2001 16:39:37 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006A_01C1693D.1F013960"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE54erINtcWI8GZrL2j00012a0c@hotmail.com>
X-OriginalArrivalTime: 09 Nov 2001 21:41:35.0314 (UTC) FILETIME=[4DEEFB20:01C16967]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_006A_01C1693D.1F013960
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The cpqarray driver was updated in 2.4.14.  And the update appears to be
broken.  Your probably encountering the same error I did.  I attached a
relevent message that includes a patch.

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

------=_NextPart_000_006A_01C1693D.1F013960
Content-Type: message/rfc822;
	name="Re_ CPQARRAY driver horribly broken in 2_4_14.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Re_ CPQARRAY driver horribly broken in 2_4_14.eml"


>From linux-kernel-owner@vger.kernel.org Thu, 08 Nov 2001 19:50:05 -0800
Received: from [199.183.24.194] by hotmail.com (3.2) with ESMTP id MHotMailBDB49D320016400431C9C7B718C2E1070; Thu, 08 Nov 2001 19:49:11 -0800
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRKIDpi>; Thu, 8 Nov 2001 22:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279202AbRKIDp1>; Thu, 8 Nov 2001 22:45:27 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:56198 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S279190AbRKIDpQ>;
	Thu, 8 Nov 2001 22:45:16 -0500
Received: from pobox.com (localhost.localdomain [127.0.0.1])
	by mirai.cx (8.11.6/8.11.6) with ESMTP id fA93jDN07748;
	Thu, 8 Nov 2001 19:45:13 -0800
Message-ID: <3BEB5149.B0B7990F@pobox.com>
Date:	Thu, 08 Nov 2001 19:45:13 -0800
From:	J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:	Linux Kernel Developer <linux_developer@hotmail.com>
CC:	linux-kernel@vger.kernel.org
Subject: Re: CPQARRAY driver horribly broken in 2.4.14
In-Reply-To: <F5uLCTaogxLDp7mvjkO00000742@hotmail.com>
Content-Type: multipart/mixed;
 boundary="------------0B4AB4FD009D357EEBF46038"
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0B4AB4FD009D357EEBF46038
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linux Kernel Developer wrote:

> Hi all,
>
>      I'm using the cpqarray driver for a Compaq Smart Arrat 3100ES
> controller on a Compaq Proliant 7000.  Today I tried upgrading the kernel to
> 2.4.14.  Soon after the upgrade I though about making a small change in the
> kernel however as soon as I tried doing a "make dep" the system oopsed and
> froze.

Been there, done that, bought the t-shirt.

The attached patch courtesy of Jens Axboe
fixed my Compaq 6500 which was giving me
fits - basically in 2.4.14 it had a nasty habit of
scribbling on the disk and then locking up,
requiring a power cycle, manual fsck and
file restoration to get it running again.

With this patch 2.4.14 has been solid.

cu

jjs



--------------0B4AB4FD009D357EEBF46038
Content-Type: text/plain; charset=us-ascii;
 name="cciss-dequeue-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cciss-dequeue-1"

--- linux/drivers/block/cciss.c~	Thu Nov  8 11:36:24 2001
+++ linux/drivers/block/cciss.c	Thu Nov  8 11:37:03 2001
@@ -1307,6 +1307,8 @@
 	if (( c = cmd_alloc(h, 1)) == NULL)
 		goto startio;

+	blkdev_dequeue_request(creq);
+
 	spin_unlock_irq(&io_request_lock);

 	c->cmd_type = CMD_RWREQ;
@@ -1386,12 +1388,6 @@

 	spin_lock_irq(&io_request_lock);

-	blkdev_dequeue_request(creq);
-
-        /*
-         * ehh, we can't really end the request here since it's not
-         * even started yet. for now it shouldn't hurt though
-         */
 	addQ(&(h->reqQ),c);
 	h->Qdepth++;
 	if(h->Qdepth > h->maxQsinceinit)

--------------0B4AB4FD009D357EEBF46038--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_006A_01C1693D.1F013960--
