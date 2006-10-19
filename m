Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161405AbWJSNqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161405AbWJSNqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWJSNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:46:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:42388 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161405AbWJSNqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:46:07 -0400
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] account_system_vtime() should be a macro, not a function
Date: Thu, 19 Oct 2006 15:46:02 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200610171747.34177.cijoml@volny.cz> <20061019014446.36410c81.akpm@osdl.org> <200610191543.18951.dada1@cosmosbay.com>
In-Reply-To: <200610191543.18951.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610191546.02566.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 October 2006 15:43, Eric Dumazet wrote:
> [PATCH] account_system_vtime() should be a macro, not a function
> 
> Because the way 'current' is implemented on some archs, it's better to use a 
> null macro for account_system_vtime(current) 
> 
> I discovered that gcc was (correctly) issuing one useless instruction (to 
> load %rax with current from pda) on x86_64 on irq_enter() and __irq_exit()
> 
> This saves few bytes in kernel size, on archs where current is 'asm volatile'

I dropped the asm volatile on x86-64 some time ago. Perhaps it should
be dropped on the other architectures too.  Then such hacks wouldn't
be needed anywhere.

-Andi
