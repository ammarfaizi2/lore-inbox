Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWAYKY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWAYKY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 05:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWAYKY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 05:24:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26276 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751087AbWAYKY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 05:24:57 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>, ak@suse.de,
       vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Subject: Re: [PATCH 1/5] stack overflow safe kdump (2.6.16-rc1-i386) -
 safe_smp_processor_id
References: <1138171868.2370.62.camel@localhost.localdomain>
	<20060124231052.7c9fcbec.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 03:23:40 -0700
In-Reply-To: <20060124231052.7c9fcbec.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 24 Jan 2006 23:10:52 -0800")
Message-ID: <m1acdkk3mb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> It assumes that all x86 SMP machines have APICs.  That's untrue of Voyager.
> I think we can probably live with this assumption - others would know
> better than I.

So looking at the code hard_smp_processor_id is fine.  Voyager
also implements that.

If we are running UP with an SMP kernel we are fine.

But I think x86_cpu_to_apicid will get us into trouble
on Voyager, because I don't think we should compile smpboot.c
as it has conflicting simples with voyager_smp.c

Although reading the makefile I don't see how we can avoid
compiling them both in SMP mode.

Everything else has a local apic when running SMP so we should
be good there.

Eric



