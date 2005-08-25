Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVHYDcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVHYDcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 23:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVHYDcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 23:32:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50360 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964781AbVHYDcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 23:32:54 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6: halt instead of reboot
References: <Pine.SOC.4.61.0508202137170.13442@math.ut.ee>
	<m14q9iva4q.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508221152350.17731@math.ut.ee>
	<m1mznativw.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0508242252120.20856@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 Aug 2005 21:32:39 -0600
In-Reply-To: <Pine.SOC.4.61.0508242252120.20856@math.ut.ee> (Meelis Roos's
 message of "Wed, 24 Aug 2005 22:55:04 +0300 (EEST)")
Message-ID: <m11x4iofmw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:

>>> It does not hang, it just powers off like on halt.
>>
>> Ok. Then at least in part the kernel behavior is either
>> intersecting with a BIOS bug, a bad reboot script that calls halt instead,
>> or a driver that is scribbling on the wrong register.  There is
>> nothing in that code path that should remove the power.
>
> With reboot=c, reboot=w and reboot=h it still powers off. With reboot=b it
> actually reboots. With 2.6.13-rc2 (the previous good kernel here) it just works
> and does a reboot with no special parameters.
>
> I also have lapic nmi_watchdog=1 in boot command line but removing these does
> not help either.
>
> So far I only know that rc6+somegit and rc7 power off and rc2 works, will try
> som kernels inbetween.

Hmm.  Odd. 

When skimming through the code I thought that reboot_thru_bios was the
default. 

So the code is currently trying a reset through the keyboard controller
and a triple fault and neither work.

If you can't track this down we can at least dig up your board DMI ID
and put it in the list of systems that need to go through the BIOS to reboot.

Eric
