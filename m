Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWHHFGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWHHFGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWHHFGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:06:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13252 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751185AbWHHFGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:06:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Horms <horms@verge.net.au>, vgoyal@in.ibm.com, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060804225611.GG19244@in.ibm.com>
	<m1k65onleq.fsf@ebiederm.dsl.xmission.com>
	<20060808033405.GA6767@verge.net.au> <44D813D7.3050004@zytor.com>
Date: Mon, 07 Aug 2006 23:04:51 -0600
In-Reply-To: <44D813D7.3050004@zytor.com> (H. Peter Anvin's message of "Mon,
	07 Aug 2006 21:32:23 -0700")
Message-ID: <m1ac6fakcs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Horms wrote:
>> I also agree that it is non-intitive. But I wonder if a cleaner
>> fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
>> it just a work around for the kernel not being relocatable, or
>> are there uses for it that relocation can't replace?
>>
>
> Yes, booting with the 2^n existing bootloaders.

Which is something we certainly have to be careful with.

> Relocation, as far as I've understood this patch, refers to loaded address, not
> runtime address.

Actually it refers to both.

Basically we detect if we were loaded with a clueless bootloader,
aka at 1MB.  If so we just load to whatever address the code was built
to run at.  Otherwise the code stays put.

To be loaded and run at a different address is what is needed for the
crash dump scenario.  Where we have to run at some reserved area
of physical memory that the original kernel did not run from.

Eric

