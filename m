Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUA1DGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbUA1DGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:06:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:16849 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265817AbUA1DGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:06:47 -0500
Date: Tue, 27 Jan 2004 19:06:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-acpi <linux-acpi@intel.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@brodo.de>, Dave Jones <davej@redhat.com>
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
In-Reply-To: <40171B5B.4020601@oracle.com>
Message-ID: <Pine.LNX.4.58.0401271859140.10794@home.osdl.org>
References: <40171B5B.4020601@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jan 2004, Alessandro Suardi wrote:
>
> Already reported, but I'll do so once again, since it looks like
>   in a short while I won't be able to boot official kernels in my
>   current config...
>
>	http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0442.html

Can you make adjust_jiffies() print out its arguments (it's in 
drivers/cpufreq/cpufreq.c).

It looks like cpufreq_scale() gets a divide-by-zero or an overflow on one 
of

	l_p_j_ref, l_p_j_ref_freq, ci->new

and just printing out those values would be interesting.

That said, the code is crap anyway. It does various divides without 
actually testing for any sanity at all, and tries to "avoid overflow" by 
totally bogus methods, instead of just using the 64-bit do_div64().

Dominic? Dave? Suggestions about nicer failure modes?

		Linus
