Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266740AbUG1AOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266740AbUG1AOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUG1AOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 20:14:40 -0400
Received: from holomorphy.com ([207.189.100.168]:42631 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266740AbUG1AOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 20:14:38 -0400
Date: Tue, 27 Jul 2004 17:14:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-ID: <20040728001415.GI2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com> <20040727132638.7d26e825.ak@suse.de> <Pine.LNX.4.58.0407271006290.23985@montezuma.fsmlabs.com> <20040727120125.0ec751a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727120125.0ec751a3.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Andi Kleen wrote:
>>> This will likely increase code size. Do you have numbers by how
>>> much? And is it really worth it?

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>>  Yes there is a growth;
>>     text    data     bss     dec     hex filename
>>  3655358 1340511  486128 5481997  53a60d vmlinux-after
>>  3648445 1340511  486128 5475084  538b0c vmlinux-before

On Tue, Jul 27, 2004 at 12:01:25PM -0700, Andrew Morton wrote:
> The growth is all in the out-of-line section, so there should be no
> significant additional icache pressure.

There are also flash and similar absolute space footprints to consider.
Experiments seem to suggest that consolidating the lock sections and
other spinlock code can reduce kernel image size by as much as 220KB on
ia32 with no performance impact (rigorous benchmarks still in progress).

That said, I agree with zwane's interrupt enablement change.


-- wli
