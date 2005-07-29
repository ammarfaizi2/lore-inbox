Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVG2DSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVG2DSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVG2DSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:18:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30848 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262184AbVG2DRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:17:54 -0400
To: vgoyal@in.ibm.com
Cc: Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdump: Save parameter segment in protected mode (x86)
References: <20050728121305.GB4962@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 28 Jul 2005 21:17:30 -0600
In-Reply-To: <20050728121305.GB4962@in.ibm.com> (Vivek Goyal's message of
 "Thu, 28 Jul 2005 17:43:05 +0530")
Message-ID: <m18xzq5mid.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ack.  This is a simple fix to a very practical problem, for
using the kernel from a reserved area of memory.

Vivek Goyal <vgoyal@in.ibm.com> writes:

> o With introduction of kexec as boot-loader, the assumption that parameter
>   segment will always be loaded at lower address than kernel and will be 
>   addressable by early bootup page tables is no longer valid. In kexec on 
>   panic case parameter segment might well be loaded beyond kernel image and 
>   might not be addressable by early boot page tables.
> o This case might hit in the scenario where user has reserved a chunk of
>   memory for second kernel, for example 16MB to 64MB, and has also built 
>   second kernel for physical memory location 16MB. In this case kexec has no 
>   choice but to load the parameter segment at a higher address than new kernel 
>   image at safe location where new kernel does not stomp it. 
> o Though problem should automatically go away once relocatable kernel for i386 
>   is in place and kexec can determine the location of new kernel at run time
>   and load parameter segment at lower address than kernel image. But till then
>   this patch can go in (assuming it does not break something else). 
> o This patch moves up the boot parameter saving code. Now boot parameters
>   are copied out in protected mode before page tables are initialized. This
>   will ensure that parameter segment is always addressable irrespective of
>   its physical location.
>
>
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
