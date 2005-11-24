Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbVKXXf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbVKXXf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbVKXXf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:35:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34027 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161070AbVKXXf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:35:27 -0500
To: Andi Kleen <ak@suse.de>
Cc: thockin@hockin.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <20051124142200.GH20775@brahms.suse.de>
	<1132845324.13095.112.camel@localhost.localdomain>
	<20051124145518.GI20775@brahms.suse.de>
	<m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
	<20051124153635.GJ20775@brahms.suse.de>
	<20051124191207.GB2468@hockin.org>
	<20051124191445.GR20775@brahms.suse.de>
	<20051124192414.GA3670@hockin.org>
	<20051124192953.GT20775@brahms.suse.de>
	<20051124194459.GA4069@hockin.org>
	<20051124212000.GW20775@brahms.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 24 Nov 2005 16:33:12 -0700
In-Reply-To: <20051124212000.GW20775@brahms.suse.de> (Andi Kleen's message
 of "Thu, 24 Nov 2005 22:20:00 +0100")
Message-ID: <m1br09hb9j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Thanks. But without a per board DIMM mapping it's pretty useless, isn't it?

Nope.

Getting a per board chip select to DIMM mapping is fairly easy, you
just need a lookup table of:
(memory_controller, chip_select, channel, dimm_label)

Which if the motherboard vendor does not give it to you is pretty
straight forward to discover just by plugging a minimal memory configuration
into various slots.  We can already query in software what the
motherboard is so keeping a table like this in user space is
not a problem.

> One could detect the IO hole by reading the IORR MSRs or alternatively
> parsing the e820 map in /var/log/boot.msg

The problem is not detection but compensating for how it changes
the address.

I do agree that it would be nice if there was a standard for
BIOS's reporting this information.  In LinuxBIOS it is one of
those TODO list items we never quite get to.  But so far a user
space table has proved quite useful in practice.

Eric
