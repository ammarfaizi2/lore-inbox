Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUAVRQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUAVRQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:16:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:27569 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266321AbUAVRQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:16:18 -0500
Date: Thu, 22 Jan 2004 09:15:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Karol Kozimor <sziwan@hell.org.pl>, "Georg C. F. Greve" <greve@gnu.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <16399.55109.244040.516731@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58.0401220900510.2123@home.osdl.org>
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com>
 <m3u12pgfpr.fsf@reason.gnu-hamburg> <m3ptddgckg.fsf@reason.gnu-hamburg>
 <20040122120854.GB3534@hell.org.pl> <16399.55109.244040.516731@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jan 2004, Mikael Pettersson wrote:

> Karol Kozimor writes:
>  > 
>  > diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c patched/arch/i386/kernel/apic.c
>  > --- linux-2.6.0-test8/arch/i386/kernel/apic.c	2003-10-18 05:43:36.000000000 +0800
>  > +++ patched/arch/i386/kernel/apic.c	2003-10-30 23:17:50.000000000 +0800
>  > @@ -836,8 +836,8 @@
>  >  {
>  >  	unsigned int lvtt1_value, tmp_value;
>  >  
>  > -	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
>  > -			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
>  > +	lvtt1_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
>  > +
>  >  	apic_write_around(APIC_LVTT, lvtt1_value);
> 
> What is the purpose of this change?
> I don't remember seeing this before on LKML. (I don't have time to read bugzilla.)

Hmm.. It does seem to fix things for a couple of people, so it looks 
interesting.

As far as I can tell, the _only_ thing it does is to change the timer base
from "DIV" to "CLKIN". I seem to have misplaced my ia-32 "volume 3" thing, 
but I have an old one for a pentium, and that one doesn't actually
haev the timer-base thing at all - and marks those bits as "reserved".

So it is entirely possible that the only safe value to write there is 0.

Also, why the heck do we call that "lvtt1"? It's just lvtt - no "1" there
anywhere.

So I'm inclined to apply the patch, but it would be better if somebody who 
had more recent docs could tell me what those newer docs say is the 
difference bewteen BASE_CLKIN (0) and BASE_DIV (2)...

		Linus
