Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVHPDHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVHPDHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 23:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVHPDHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 23:07:38 -0400
Received: from quark.didntduck.org ([69.55.226.66]:35284 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965077AbVHPDHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 23:07:37 -0400
Message-ID: <43015894.1090307@didntduck.org>
Date: Mon, 15 Aug 2005 23:08:04 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zach@vmware.com
CC: akpm@osdl.org, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 0/6] i386 virtualization patches, Set 3
References: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
In-Reply-To: <200508152258.j7FMw9p8005295@zach-dev.vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zach@vmware.com wrote:
> This round attempts to conclude all of the LDT related cleanup with some
> finally nice looking LDT code, fixes for the UML build, a bugfix for
> really rather nasty kprobes problems, and the basic framework for an LDT
> test suite.  It is really rather unfortunate that this code is so
> difficult to test, even with DOSemu and Wine, there are still very nasty
> corner cases here - anyone want an iret to 16-bit stack test?.
> 
> I was going to attempt to clean up the math-emu code to make it use the
> nice new segment and descriptor table accessors, but it quickly became
> apparent that this would be a long, tedious, error prone process that
> would eventually result in the death of a large section of my brain.
> In addition, it is not very fun to test this on the actual hardware it
> is designed to run on (although I did manage to track down a 386 with
> detachable i387 coprocessor, the owner is not sure it still boots).
> Someday it would be nice to have an audit of this code; it appears to
> be riddled with bugs relating to segmentation, for example it assumes
> LDT segments on overrides, does not use the mm->context semaphore to
> protect LDT access, and generally looks scarily out of date in both
> function and appearance.

If you really want to test the math emu code, you can hack check_x87 in 
head.S to always leave the fpu disabled.  Then you can test it on any 
cpu, not just a 386.

--
				Brian Gerst
