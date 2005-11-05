Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVKEATa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVKEATa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVKEATa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:19:30 -0500
Received: from verein.lst.de ([213.95.11.210]:24232 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751247AbVKEAT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:19:29 -0500
Date: Sat, 5 Nov 2005 01:19:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH consolidate sys_ptrace
Message-ID: <20051105001917.GA11100@lst.de>
References: <20051101051221.GA26017@lst.de> <20051101050900.GA25793@lst.de> <10611.1130845074@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10611.1130845074@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 11:37:54AM +0000, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > The sys_ptrace boilerplate code (everything outside the big switch
> > > statement for the arch-specific requests) is shared by most
> > > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > > arch-specific code as arch_ptrace.
> 
> Looks okay to me. I do have a concern about all the extra indirections we're
> acquiring by this mad rush to centralise everything. It's going to slow things
> down and consume more stack space. Is there any way we can:
> 
>  (1) Make a sys_ptrace() *jump* to arch_ptrace() instead of calling it, thus
>      obviating the extra return step.
> 
>  (2) Drop the use of lock_kernel().
> 
> Otherwise, the patch looks valid:

As BKL usage indicates this is a real slowpath.  No one cares about one
function call or less here.

