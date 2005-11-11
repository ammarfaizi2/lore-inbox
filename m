Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVKKPti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKKPti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKKPti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:49:38 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:4622
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750829AbVKKPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:49:37 -0500
Message-Id: <4374CBE9.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 11 Nov 2005 16:50:49 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH] x86-64: adjust ia32entry.S
References: <4370AFF0.76F0.0078.0@novell.com>  <4370C36D.76F0.0078.0@novell.com>  <43722D73.76F0.0078.0@novell.com> <200511111634.44871.ak@suse.de>
In-Reply-To: <200511111634.44871.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 11.11.05 16:34:44 >>>
>On Wednesday 09 November 2005 17:10, Jan Beulich wrote:
>> IA32 compatibility entry points needlessly played with extended
>> registers. Additionally, frame unwind information was still
incorrect
>> for ia32_ptregs_common (sorry, my fault).
>
>What do you mean with needlessly played? That it didn't initialize 
>all on the stack frame? That was more a feature than a bug.
>Did it cause you problems?

It saved and restored R12-R15, even though these registers have no
meaning (and are architecturally undefined) when coming from/going to
32-bit mode. Problems? No, except that without the extra loads (stores
don't matter that much I believe) performance is better...

>In general I'm weary of making the asm macros more complex
>(adding more arguments etc.) Please keep it simple.

Then ignore this, perhaps with the exception of the unwind info
adjustment.

Jan
