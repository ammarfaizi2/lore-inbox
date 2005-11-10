Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbVKJO7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbVKJO7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVKJO7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:59:15 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62758
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750985AbVKJO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:59:14 -0500
Message-Id: <43736E8D.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 16:00:13 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 18/39] NLKD/x86-64 - INT1/INT3 handling changes
References: <43720DAE.76F0.0078.0@novell.com>  <200511101421.48950.ak@suse.de>  <43736220.76F0.0078.0@novell.com> <200511101525.06063.ak@suse.de>
In-Reply-To: <200511101525.06063.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Looks reasonable except for the CONFIG_NLKD hunk, which doesn't
>> >seem to be related. I think I'll apply it without that.
>>
>> As the comment in that hunk says - this is not the correct test, but
the
>> correct test cannot be used. Omitting the hunk altogether will leave
orphan
>> references to the pda field (even though these won't cause build
problems)
>> in setup64.c and traps.c.
>
>!NLKD code relying on CONFIG_NLKD code? That sounds wrong. I won't
apply
>it then. Please clean up first.

Since the exception stack size doesn't get set to other than 4k, this
isn't by itself wrong (the NLKD patch later conditionally sets this to
more than 4k). The problem, as said in the patch, is that pda.h cannot
include processor.h, and I see no solution for that (other than breaking
up processor.h).

Jan
