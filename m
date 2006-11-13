Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933038AbWKMTfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038AbWKMTfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933039AbWKMTfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:35:23 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:35821 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S933038AbWKMTfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:35:22 -0500
Date: Mon, 13 Nov 2006 14:34:47 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061113193447.GB13832@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com> <200611131822.44034.ak@suse.de> <20061113175947.GA13832@in.ibm.com> <200611131913.32073.ak@suse.de> <m14pt3qhjy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14pt3qhjy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 12:21:05PM -0700, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> >> This code (verify_cpu) is called while we are still in real mode. So it has
> >> to be present in low 1MB. Now in trampoline has been designed to switch to
> >> 64bit mode and then jump to the kernel hence kernel can be loaded anywhere
> >> even beyond (4G). So if we move this code into say arch/x86_64/kernel/head.S
> >> then we can't even call it.
> >
> > I didn't mean to call it. Just #include it from a common file
> 
> I believe the duplication winds up happening in setup.S
> 

Yes. So boot cpu code in setup.S is also doing these checks. So one 
of the options is that I create a new file says verify_cpu.S and this
code can be shared by setup.S, trampoline.S and wakeup.S.

Or, I can simply drop the verify_cpu bit from trampoline.S and wakeup.S.
This looks like a non-essential bit and in the past we did not perform
these checks in trampoline.S and wakeup.S

At this point of time, I will prefer to go with second option of dropping
extended checks in trampoline.S and wakeup.S to keep things simple.

Does that make sense?

Thanks
Vivek

