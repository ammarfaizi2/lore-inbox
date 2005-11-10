Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVKJOGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVKJOGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVKJOGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:06:12 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12317
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750911AbVKJOGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:06:10 -0500
Message-Id: <43736220.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 15:07:12 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 18/39] NLKD/x86-64 - INT1/INT3 handling changes
References: <43720DAE.76F0.0078.0@novell.com>  <437210D1.76F0.0078.0@novell.com>  <4372120B.76F0.0078.0@novell.com> <200511101421.48950.ak@suse.de>
In-Reply-To: <200511101421.48950.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 10.11.05 14:21:48 >>>
>On Wednesday 09 November 2005 15:13, Jan Beulich wrote:
>> This
>> - switches the INT3 handler to run on an IST stack (to cope with
>>   breakpoints set by a kernel debugger on places where the kernel's
>>   %gs base hasn't been set up, yet); the IST stack used is shared with
>>   the INT1 handler's
>> - allows nesting of INT1/INT3 handlers so that one can, with a kernel
>>   debugger, debug (at least) the user-mode portions of the INT1/INT3
>>   handling; the nesting isn't actively enabled here since a kernel-
>>   debugger-free kernel doesn't need it
>
>Looks reasonable except for the CONFIG_NLKD hunk, which doesn't
>seem to be related. I think I'll apply it without that.

As the comment in that hunk says - this is not the correct test, but the correct test cannot be used. Omitting the hunk altogether will leave orphan references to the pda field (even though these won't cause build problems) in setup64.c and traps.c.

Jan

