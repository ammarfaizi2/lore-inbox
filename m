Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbTD3MnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTD3MnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:43:03 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:12043 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262155AbTD3MnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:43:02 -0400
Date: Wed, 30 Apr 2003 13:55:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA-Q sys_ioperm()/sys_iopl()
Message-ID: <20030430135521.A5383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20030430122825.GL8931@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030430122825.GL8931@holomorphy.com>; from wli@holomorphy.com on Wed, Apr 30, 2003 at 05:28:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 05:28:25AM -0700, William Lee Irwin III wrote:
> NUMA-Q cannot support these operations without significant
> infrastructure to emulate a global port io space for userspace to
> manipulate, possibly even with hooks into the scheduler.
> 
> Not only are the applications depending on this particular form of
> privilege elevation generally inappropriate uses of these machines
> (they are large "server-class" machines, typically shipped and run
> headless), but the devices typically managed with these interfaces
> are already explicitly unsupported in UNIX configurations.
> 
> This patch removes sys_iopl() and sys_ioperm() support conditional on
> #ifdef CONFIG_X86_NUMAQ to prevent the device register corruption
> condition without significant impact on core i386 support.

Please use cond_syscall to autogenerate the stubs, and make the compilation
of /ioport.c conditional on !CONFIG_X86_NUMAQ.
