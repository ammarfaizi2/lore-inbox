Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWA0USL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWA0USL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWA0USL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:18:11 -0500
Received: from spirit.analogic.com ([204.178.40.4]:58891 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1161005AbWA0USJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:18:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43DA62CC.8090309@wolfmountaingroup.com>
X-OriginalArrivalTime: 27 Jan 2006 20:18:06.0717 (UTC) FILETIME=[C8BABAD0:01C6237E]
Content-class: urn:content-classes:message
Subject: Re: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled check
Date: Fri, 27 Jan 2006 15:18:06 -0500
Message-ID: <Pine.LNX.4.61.0601271513360.15124@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.14 kernels and above copy_to_user stupidity with IRQ disabled check
Thread-Index: AcYjfsjXFEVsIqxES5SquOHiikVbRg==
References: <43DA62CC.8090309@wolfmountaingroup.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Jan 2006, Jeff V. Merkey wrote:

>
> Is there a good reason someone set a disabled_irq() check on 2.6.14 and
> above for copy_to_user to barf out
> tons of bogus stack dump messages if the function is called from within
> a spinlock:
>

This is a joke, right????

> i.e.
>
> spin_lock_irqsave(&regen_lock, regen_flags);
>    v = regen_head;
>    while (v)
>    {
>       if (i >= count)
>          return -EFAULT;

** BUG **  return with spin-lock held!

>
>
>       err = copy_to_user(&s[i++], v, sizeof(VIRTUAL_SETUP));

** BUG ** copy to user with spinlock held!

>       if (err)
>          return err;
>

** BUG ** Return with spin-lock held!
>
>       v = v->next;
>    }
>    spin_unlock_irqrestore(&regen_lock, regen_flags);
>
> is now busted and worked in kernels up to this point.  The error message
> is annoying but non-fatal.
>
> Jeff

It was NEVER supposed to work! The only reason it worked is because
your page(s) copied to, were not swapped out. If they were swapped
out, you are stuck, the page-fault won't occur.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
