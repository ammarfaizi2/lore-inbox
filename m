Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWC3NGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWC3NGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWC3NGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:06:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9908 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932161AbWC3NGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:06:34 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc] fix Kconfig, hotplug_cpu is needed for swsusp
References: <20060329220808.GA1716@elf.ucw.cz>
	<20060329144746.358a6b4e.akpm@osdl.org>
	<20060329150950.A12482@unix-os.sc.intel.com>
	<20060329192453.538a131d.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 06:05:13 -0700
In-Reply-To: <20060329192453.538a131d.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 29 Mar 2006 19:24:53 -0800")
Message-ID: <m14q1gdqwm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Something which remains to be beaten into my head: *why* does HOTPLUG_CPU
> require flat pyhsical mode?  What necessitated that change, and cannot we
> make it work OK in logical mode as well as flat mode?

Good question.  

There is a window after a cpu starts and before we initialize it that
we must be very careful and not deliver it any interrupts because
we don't know what the cpu will do.

Which means in the presence of cpu hotplug we can never use broadcast
interrupts.

I don't know how the that disallows logical mode though.

Eric
