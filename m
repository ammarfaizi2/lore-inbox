Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVHVWjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVHVWjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVHVWjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:39:41 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52107 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751318AbVHVWjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:39:40 -0400
Date: Mon, 22 Aug 2005 11:53:02 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strange CRASH_DUMP dependencies
Message-ID: <20050822062302.GA4293@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050821225310.GE5726@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821225310.GE5726@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 12:53:10AM +0200, Adrian Bunk wrote:
> config CRASH_DUMP
> 	bool "kernel crash dumps (EXPERIMENTAL)"
> 	depends on EMBEDDED
> 	depends on EXPERIMENTAL
> 	depends on HIGHMEM
> 	help
> 	  Generate crash dump after being started by kexec.
> 
> Two questions:
> - If it has any dependencies on kexec, why isn't there a dependency?

crashdump has got dependency on kexec but not in the same kernel. What
I mean is that as of today two kernels are involved in this process. First
kernel is crashing kernel which should have enabled CONFIG_KEXEC and second
kernel (capture kernel) is one which captures the dump and should have
CONFIG_CRASH_DUMP enabled. Second kernel need not to have CONFIG_KEXEC
enabled for catpturing dump. Hence CRASH_DUMP is not directly dependent
on CONFIG_KEXEC.

> - Is there any sane reason for the dependency on EMBEDDED?
> 

I believe this was introduced because large servers can have huge amount
of memory (running into Tera Bytes) and saving all that memory might not be
practical. Hence it was perceived that until some filtering mechanism is
implemented, it is more suited for small systems.

Personally I think it can be gotten away with because as a developer I can
run gdb directly on /proc/vmcore and need not to save the whole memory hence
need not to restrict this feature only for small systems.

Eric, do you think otherwise?

Thanks
Vivek
