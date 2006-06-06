Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWFFFaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWFFFaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 01:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWFFFaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:30:09 -0400
Received: from ns1.suse.de ([195.135.220.2]:54915 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750866AbWFFFaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:30:07 -0400
To: Martin Bisson <bissonm@discreet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 system call entry points II
References: <44846210.4080602@discreet.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Jun 2006 07:30:06 +0200
In-Reply-To: <44846210.4080602@discreet.com>
Message-ID: <p73verezw9t.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bisson <bissonm@discreet.com> writes:
> 
> - int $0x80/64 bits: All system calls return -1 (EINTR).  Is there
> something wrong in the way I call it:
> pid_t getpid64()
> {
>     pid_t resultvar;
> 
>     asm volatile (
>     "int $0x80\n\t"
>     : "=a" (resultvar)     : "0" (__NR_getpid)
>     : "memory");
> 
>     return resultvar;
> }

I tested it now. Since it ends up as a 32bit syscall you're not 
actually calling 64bit getpid() - but 32bit mkdir(). That is because 32bit and 64bit
have different syscall numbers. For me it returns -14, which is EFAULT.
Expected for a random argument to mkdir()

-Andi
