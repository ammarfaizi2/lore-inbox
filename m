Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSKMWX5>; Wed, 13 Nov 2002 17:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSKMWXz>; Wed, 13 Nov 2002 17:23:55 -0500
Received: from fmr01.intel.com ([192.55.52.18]:39679 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264657AbSKMWXn>;
	Wed, 13 Nov 2002 17:23:43 -0500
Message-ID: <01b101c28b64$47301880$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Rusty Lynch" <rusty@linux.co.intel.com>,
       "Arjan van de Ven" <arjanv@redhat.com>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <rusty@linux.co.intel.com>
References: <200211132013.gADKDhS01389@linux.intel.com.suse.lists.linux.kernel> <1037220406.2889.4.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365v1w4sh.fsf@oldwotan.suse.de> <013101c28b5b$0efcab80$77d40a0a@amr.corp.intel.com>
Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()
Date: Wed, 13 Nov 2002 14:30:32 -0800
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

To clarify further, I am talking about the sample driver I submitted earlier
at
http://marc.theaimsgroup.com/?l=linux-kernel&m=103721364225087&w=2

The patch implements a char device that enables arbitrary printk's to be
inserted at in arbitrary kernel addresses.  It is used by writing strings of
the
form "0xADDRESS MESSAGE" to the device.

I was looking for a way to verify the address passed in was valid before
creating and inserting a new probe.

Maybe there is a better way to verify a kernel address is valid before
messing
with it?

    -rusty
----- Original Message -----
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Arjan van de Ven" <arjanv@redhat.com>; "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>; <rusty@linux.co.intel.com>
Sent: Wednesday, November 13, 2002 1:24 PM
Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()


> I had a need for it in a sample kprobes driver where I wanted to verify
that
> some address
> was a valid kernel space address before I handed a probe to kprobes.
>
> So I would do something like:
>
> if (!valid_kernel_address(probe->addr)) {
>     ret = -EINVAL;
>     goto out;
> }
>
> register_kprobe(probe);
>
> and then kpboes will go and attempt to set *(probe->addr) = BREAK_POINT;
>
>     -rustyl
> ----- Original Message -----
> From: "Andi Kleen" <ak@suse.de>
> To: "Arjan van de Ven" <arjanv@redhat.com>
> Cc: <linux-kernel@vger.kernel.org>; <rusty@linux.co.intel.com>
> Sent: Wednesday, November 13, 2002 1:14 PM
> Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()
>
>
> > Arjan van de Ven <arjanv@redhat.com> writes:
> >
> > > it is customary that people who ask for an export explain why they
need
> > > it.... would you mind explaining that ?
> >
> > For modular lkcd I guess. Make a lot of sense to do it modular.
> >
> > -Andi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

