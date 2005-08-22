Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVHVWjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVHVWjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVHVWjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:39:42 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52107 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751333AbVHVWjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:39:40 -0400
To: vgoyal@in.ibm.com
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: strange CRASH_DUMP dependencies
References: <20050821225310.GE5726@stusta.de>
	<20050822062302.GA4293@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 Aug 2005 00:40:10 -0600
In-Reply-To: <20050822062302.GA4293@in.ibm.com> (Vivek Goyal's message of
 "Mon, 22 Aug 2005 11:53:02 +0530")
Message-ID: <m1vf1ytqyd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Aug 22, 2005 at 12:53:10AM +0200, Adrian Bunk wrote:
>> config CRASH_DUMP
>> 	bool "kernel crash dumps (EXPERIMENTAL)"
>> 	depends on EMBEDDED
>> 	depends on EXPERIMENTAL
>> 	depends on HIGHMEM
>> 	help
>> 	  Generate crash dump after being started by kexec.
>> 
>> Two questions:
>> - If it has any dependencies on kexec, why isn't there a dependency?
>
> crashdump has got dependency on kexec but not in the same kernel. What
> I mean is that as of today two kernels are involved in this process. First
> kernel is crashing kernel which should have enabled CONFIG_KEXEC and second
> kernel (capture kernel) is one which captures the dump and should have
> CONFIG_CRASH_DUMP enabled. Second kernel need not to have CONFIG_KEXEC
> enabled for catpturing dump. Hence CRASH_DUMP is not directly dependent
> on CONFIG_KEXEC.
>
>> - Is there any sane reason for the dependency on EMBEDDED?
>> 
>
> I believe this was introduced because large servers can have huge amount
> of memory (running into Tera Bytes) and saving all that memory might not be
> practical. Hence it was perceived that until some filtering mechanism is
> implemented, it is more suited for small systems.
>
> Personally I think it can be gotten away with because as a developer I can
> run gdb directly on /proc/vmcore and need not to save the whole memory hence
> need not to restrict this feature only for small systems.
>
> Eric, do you think otherwise?

I would have to look again but I think the EMBEDDED dependency comes in
more from the code that runs the kernel at a different address.  But
the essence is not because the crash dump kernel is for small systems
(that isn't what embedded means anyway) but because at the moment you
can't reasonably have the crash dump kernel be a general purpose
kernel.

I have some patches which should use of a general purpose kernel.  I
need to find a few moments and get them into the -mm tree for further testing.

For most of the code under CONFIG_CRASH_DUMP my opinion is that all
that is really need is fix /dev/mem to be usable, and we can do most
if not all of the work in user space.  But as long as we are
communicating between the two kernels with a sane interface I really
don't care.

Eric

