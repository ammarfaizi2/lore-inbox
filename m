Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSKMVUC>; Wed, 13 Nov 2002 16:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSKMVTG>; Wed, 13 Nov 2002 16:19:06 -0500
Received: from fmr02.intel.com ([192.55.52.25]:42726 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263143AbSKMVRt>; Wed, 13 Nov 2002 16:17:49 -0500
Message-ID: <013101c28b5b$0efcab80$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Arjan van de Ven" <arjanv@redhat.com>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <rusty@linux.co.intel.com>
References: <200211132013.gADKDhS01389@linux.intel.com.suse.lists.linux.kernel> <1037220406.2889.4.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365v1w4sh.fsf@oldwotan.suse.de>
Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()
Date: Wed, 13 Nov 2002 13:24:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a need for it in a sample kprobes driver where I wanted to verify that
some address
was a valid kernel space address before I handed a probe to kprobes.

So I would do something like:

if (!valid_kernel_address(probe->addr)) {
    ret = -EINVAL;
    goto out;
}

register_kprobe(probe);

and then kpboes will go and attempt to set *(probe->addr) = BREAK_POINT;

    -rustyl
----- Original Message -----
From: "Andi Kleen" <ak@suse.de>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>; <rusty@linux.co.intel.com>
Sent: Wednesday, November 13, 2002 1:14 PM
Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()


> Arjan van de Ven <arjanv@redhat.com> writes:
>
> > it is customary that people who ask for an export explain why they need
> > it.... would you mind explaining that ?
>
> For modular lkcd I guess. Make a lot of sense to do it modular.
>
> -Andi

