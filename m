Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUJ0EER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUJ0EER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUJ0EEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:04:16 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41438 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261429AbUJ0EEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:04:12 -0400
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200410262250.40674.dtor_core@ameritech.net>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
	 <200410262220.38052.dtor_core@ameritech.net>
	 <1098847066.5661.47.camel@desktop.cunninghams>
	 <200410262250.40674.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1098849333.6269.8.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 13:55:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-10-27 at 13:50, Dmitry Torokhov wrote:
> Well, I understand that ACPI is using semaphore and a GFP_KERNEL, but what
> is the problem with MTRR? I understand that they should be set with IRQ
> off but I highly doibt that enabling IRQ at the end is a requirement.
> I think what is described in the commnet is rather a "normal flow of events".

The real problem with MTRRs is SMP support: smp_call_function doesn't
like IRQs disabled.

I got around a similar issue with saving CPU state (for suspend-to-disk)
by using the same general sequence that I later discovered described in
arch/i386/kernel/cpu/mtrr/main.c (set_mtrr header) for saving CPU
contexts. I extended it yesterday to do the MTRR settings as well,
before Shaohua pointed to the more general need.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

