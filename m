Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVKOIXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVKOIXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVKOIXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:23:46 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:5803
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751373AbVKOIXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:23:46 -0500
Message-Id: <4379A960.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 15 Nov 2005 09:24:48 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>, "Andi Kleen" <ak@suse.de>
Cc: <george@mvista.com>, <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
References: <43720DAE.76F0.0078.0@novell.com>  <20051112204428.GA14733@midnight.suse.cz>  <43792DFF.1000300@mvista.com>  <200511150205.25339.ak@suse.de> <20051115075026.GA11994@midnight.suse.cz>
In-Reply-To: <20051115075026.GA11994@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Vojtech Pavlik <vojtech@suse.cz> 15.11.05 08:50:26 >>>
>On Tue, Nov 15, 2005 at 02:05:24AM +0100, Andi Kleen wrote:
>
>> On Tuesday 15 November 2005 01:38, George Anzinger wrote:
>> 
>> > Doesn't this depend on the atomic nature of the 64-bit read?  If
it
>> > is really two 32-bit reads one would need to do extra work to
make
>> > sure the two parts belong together.
>> 
>> Please take a look at the Subject.
> 
>Still, the HPET doesn't necessarily have to be a 64-bit device. At
least
>on AMD systems, where it's implemented in AMD8111 Thor, it's bundled
>together with other, 32-bit PCI devices like USB. On the other hand,
the
>8111 HPET doesn't implement a 64-bit conter, and it's likely that the
>Intel implementation in the northbridges (or *CH, as Intel prefers
>calling the things) is likely native 64-bit.

And even then there is no guarantee there isn't something somewhere
converting the 64-bit to pairs of 32-bit accesses. Thus one would in
fact need extra information about the platform to know whether the
entire bus path is 64-bit in order to safely do 64-bit accesses.

However, the changes as I proposed them (and will resubmit hopefully
later today with the adjustments requested by Andi) do intentionally not
do any 64-bit reads, they only use 64-bit writes when resetting counter
or comparator (where all that's needed from the platform is that the
writes to the low 32 bits are done first, which x86 architecturally
guarantees).

Jan
