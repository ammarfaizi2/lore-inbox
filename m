Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWFHFLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWFHFLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 01:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFHFLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 01:11:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17293 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751228AbWFHFLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 01:11:33 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: "Brendan Trotter" <btrotter@gmail.com>
cc: "Andi Kleen" <ak@suse.de>, "Ashok Raj" <ashok.raj@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NMI problems with Dell SMP Xeons 
In-reply-to: Your message of "Wed, 07 Jun 2006 15:18:57 GMT."
             <b1ebdcad0606070818l3024b264k89f6cd37ccb0b6f7@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Jun 2006 15:11:15 +1000
Message-ID: <6888.1149743475@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brendan Trotter" (on Wed, 7 Jun 2006 15:18:57 +0000) wrote:
>Hi,
>
>On 6/7/06, Keith Owens <kaos@sgi.com> wrote:
>> This problem is not KDB specific, although that is where it was first
>> noticed.  Any code that sends a broadcast IPI 2 or an NMI IPI will
>> crash these Dell boxes when there is a mismatch between the cpus known
>> to the BIOS and the cpus known to the OS.
>
>I missed this (broadcast IPI 2 causing problems)...

It turns out that there is an uncommented hack in x86_64's version of
__prepare_ICR().

	case NMI_VECTOR:
                icr |= APIC_DM_NMI;
		break;

That hack is not in i386, which means that IPI 2 does different things
in i386 vs. x86_64 mode on the same hardware.  I am still tracking down
all the differences before doing a clean up patch that makes i386 and
x86_64 behave the same.

