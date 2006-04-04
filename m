Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWDDQ31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWDDQ31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWDDQ31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:29:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65037 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750734AbWDDQ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:29:22 -0400
Date: Tue, 4 Apr 2006 18:29:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com, rdunlap@xenotime.net,
       fastboot@osdl.org
Subject: 2.6.17-rc1-mm1: KEXEC became SMP-only
Message-ID: <20060404162921.GK6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
>...
> +x86-clean-up-subarch-definitions.patch
>...
>  x86 updates.
>...

The following looks bogus:

 config KEXEC
        bool "kexec system call (EXPERIMENTAL)"
-       depends on EXPERIMENTAL
+       depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)

The dependencies do now say that KEXEC is only offered for machines that 
are _both_ non-Voyager and SMP.

Is the problem you wanted to express that a non-SMP Voyager config 
didn't compile?

AFAIR I recently sent a patch disallowing non-SMP Voyager configurations 
that wasn't yet applied.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

