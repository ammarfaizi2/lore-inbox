Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760285AbWLFH4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760285AbWLFH4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 02:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760287AbWLFH4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 02:56:30 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:32470
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760285AbWLFH43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 02:56:29 -0500
Message-Id: <45768610.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 06 Dec 2006 07:57:52 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Cc: "Randy Dunlap" <randy.dunlap@oracle.com>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fully support linker generated .eh_frame_hdr
	section
References: <4574598F.76E4.0078.0@novell.com>
 <20061204145827.155ce33c.randy.dunlap@oracle.com>
 <45753A9C.76E4.0078.0@novell.com>
 <Pine.LNX.4.61.0612052052230.18570@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612052052230.18570@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Jan Engelhardt <jengelh@linux01.gwdg.de> 05.12.06 20:52 >>>
>
>>>> Now that binutils' ld is able to properly populate .eh_frame_hdr in the
>>>> Linux kernel case, here's a patch to add some functionality to the Dwarf2
>>>> unwinder to actually be able to make use of this (applies on firstfloor
>>>> tree with the previously sent patch to add debug output, but not on plain
>>>> 2.6.19).
>>>
>>>Requires what version of binutils / ld?
>>
>>mainline - the second of the required patches went in just yesterday.
>
>Which means people using distros will have it in some 6 months, unless 
>vendors give an earlier update.

That's not the point here - the point is that the kernel should be ready to take
advantage of this whenever somebody tries to build with newer binutils. Also,
the patch adds a previously missing check that would result in not creating a
runtime allocated table (assuming the linker created one is usable), but failing
to read from that table during later lookups (resulting in the originally
observed long boot time due to lockdep making heavy use of this code).

Jan
