Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTJVKiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 06:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTJVKiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 06:38:25 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:63130 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S263507AbTJVKiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 06:38:23 -0400
Message-ID: <19ce01c39888$7993f620$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Marco Roeland" <marco.roeland@xs4all.nl>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
References: <20031021131915.GA4436@rushmore> <20031021135221.GA22633@localhost> <20031021143741.GB22633@localhost>
Subject: Re: [PATCH] RH7.3 can't compile 2.6.0-test8 (fs/proc/array.c)
Date: Wed, 22 Oct 2003 19:36:53 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland asked:

> Does this compile (and work) for any of you friendly RedHat 7.[23] users?
> In 2.6.0-test8 yet another argument was added to the monstrous sprintf.
> Perhaps this was just the droplet to overflow gcc-2.96's buckets? Here we
> split it into 3 distinct parts.

It didn't help in RH 7.3.
Again the word エラー in the following excerpt means error.


fs/proc/array.c: In function `proc_pid_stat':
fs/proc/array.c:398: Unrecognizable insn:
(insn/i 1325 1690 1684 (parallel[
            (set (reg:SI 0 eax)
                (asm_operands ("") ("=a") 0[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (set (reg:SI 1 edx)
                (asm_operands ("") ("=d") 1[
                        (reg:DI 1 edx)
                    ]
                    [
                        (asm_input:DI ("A"))
                    ]  ("include/linux/times.h") 37))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 1319 (nil))
    (nil))
fs/proc/array.c:398: confused by earlier errors, bailing out
make[2]: *** [fs/proc/array.o] エラー 1
make[1]: *** [fs/proc] エラー 2
make: *** [fs] エラー 2


Line 37 of include/linux/times.h is the do_div call shown below.


static inline u64 jiffies_64_to_clock_t(u64 x)
{
#if (HZ % USER_HZ)==0
        do_div(x, HZ / USER_HZ);


