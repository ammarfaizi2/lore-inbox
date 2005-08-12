Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVHLLny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVHLLny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 07:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVHLLny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 07:43:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:48819 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751024AbVHLLny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 07:43:54 -0400
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Aug 2005 13:43:52 +0200
In-Reply-To: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>
Message-ID: <p73pssj2xdz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck <martin.wilck@fujitsu-siemens.com> writes:

> Hi William, hello everyone,
> 
> The MP_valid_apicid() function [arch/i386/kernel/mpparse.c] checks
> whether the APIC version field is >=20 in order to determine whether
> the CPU supports 8-bit physical APIC ids.

Yes, it's broken. In fact I removed it in my physflat32 patch
which is needed for 16 core AMD systems. I don't think there
is a generic way to fix it because the XAPIC check breaks
on AMD systems and there is no good way to decide early 
on subarchitectures before doing this check. Also it's only
a sanity check for broken BIOS, and in this case it causes more problems
than it solves.

ftp://ftp.firstfloor.org/pub/ak/x86_64/x86_64-2.6.13rc3-1/patches/physflat32

Will hopefully be fixed in 2.6.14.

-Andi
