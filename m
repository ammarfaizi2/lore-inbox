Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271821AbRIHXLi>; Sat, 8 Sep 2001 19:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271823AbRIHXL3>; Sat, 8 Sep 2001 19:11:29 -0400
Received: from colorfullife.com ([216.156.138.34]:59146 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271821AbRIHXLV>;
	Sat, 8 Sep 2001 19:11:21 -0400
Message-ID: <000901c138bb$8e151270$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Roger Larsson" <roger.larsson@norran.net>
Cc: <linux-kernel@vger.kernel.org>, "Robert Love" <rml@tech9.net>,
        <nigel@nrg.org>
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
Date: Sun, 9 Sep 2001 01:11:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is interesting. [Assumes UP Athlon - correct]
> Note that all BUGs out in highmem.h:95 (kmap_atomic)
> and that test is only on if you have enabled HIGHMEM_DEBUG
> [my analyze is done with a 2.4.10-pre2 kernel, but I checked with
> later patches and I do not think they fix it either...]
>
> The preemptive kernel puts more SMP stress on the kernel than
> running with multiple CPUs.
>
> So this might be a potential bug in the kernel proper, running with
> a SMP computer.

No.
It seems to be a missing ctx_sw_off() in highmem.h:
kmap_atomic uses a per-cpu variable, thus ctx_sw_off() is needed in
kmap_atomic, and ctx_sw_on() in kunmap_atomic().

--
    Manfred



