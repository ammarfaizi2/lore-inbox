Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWH1Jub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWH1Jub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWH1Jub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:50:31 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:22719
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932484AbWH1Jub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:50:31 -0400
Message-Id: <44F2D8A4.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 28 Aug 2006 10:51:00 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>, "Andi Kleen" <ak@suse.de>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>, "H. J. Lu" <hjl@lucon.org>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Zachary Amsden" <zach@vmware.com>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the
	kernel.
References: <20060827084417.918992193@goop.org>
 <200608271757.18621.ak@suse.de> <44F1D464.5020304@goop.org>
 <200608272019.15067.ak@suse.de>
In-Reply-To: <200608272019.15067.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 27.08.06 20:19 >>>
>On Sunday 27 August 2006 19:20, Jeremy Fitzhardinge wrote:
>> Andi Kleen wrote:
>> >> +1:	movw GS(%esp), %gs
>> >>     
>> >
>> > movl is recommended in 32bit mode
>> >   
>> 
>> arch/i386/kernel/entry.S: Assembler messages:
>> arch/i386/kernel/entry.S:334: Error: suffix or operands invalid for `mov'
>
>Looks like a gas bug to me.

This was an intentional change (by H.J. if I recall right) as using movl
with segment registers gives the incorrect impression that one gets a
32-bit memory access (especially for stores this is important, since
there's really nothing stored to the upper 16 bits). One should always
use suffix-less 'mov' for segment register accesses.

Jan
