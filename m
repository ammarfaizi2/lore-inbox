Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268024AbUIPLvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268024AbUIPLvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUIPLrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:47:22 -0400
Received: from holomorphy.com ([207.189.100.168]:50339 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268014AbUIPLpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:45:49 -0400
Date: Thu, 16 Sep 2004 04:45:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Message-ID: <20040916114515.GP9106@holomorphy.com>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:28:26PM +0300, Denis Vlasenko wrote:
> I see 2.6.9-rc2 being slower than 2.4.27-rc3
> on a Pentium 66, 80 MB RAM.
> Specifically:
> top on idle machine sucks ~40% CPU while in 2.4
> it takes only ~6%
> I recompiled 2.6 with HZ=100 and with slab debugging
> off. This helped a bit (wget was slow too),
> but top still hogs CPU.
> I did 'strace -T -tt top b n 1' under both kernels,
> postprocessed it a bit:

The following patches in -mm are likely to help top(1).

kallsyms-data-size-reduction--lookup-speedup.patch
  kallsyms data size reduction / lookup speedup

inconsistent-kallsyms-fix.patch
  Inconsistent kallsyms fix

kallsyms-correct-type-char-in-proc-kallsyms.patch
  kallsyms: correct type char in /proc/kallsyms

kallsyms-fix-sparc-gibberish.patch
  kallsyms: fix sparc gibberish

As for all syscalls/etc. being slower by 50%-100%, I suggest toning
down HZ (we desperately need to go tickless) and seeing if it persists.
Also please check that time isn't twice as fast as it should be in 2.6.


-- wli
