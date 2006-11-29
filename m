Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758925AbWK2XWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925AbWK2XWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758972AbWK2XWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:22:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:13002 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758925AbWK2XWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:22:01 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 add idle notifier
Date: Thu, 30 Nov 2006 00:21:41 +0100
User-Agent: KMail/1.9.5
Cc: eranian@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
References: <20061129162540.GL28007@frankl.hpl.hp.com> <20061129221853.GD29670@frankl.hpl.hp.com> <20061129150544.ebd952f3.akpm@osdl.org>
In-Reply-To: <20061129150544.ebd952f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300021.41497.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> An alternative approach might be to change perfmon so that it works out
> whether it is being called by an idle thread
> 
> 	if ((current->flags & PF_IDLE) && (other stuff to do with irqs?))
> 		return;

The problem is that the performance counters just keep running in the CPU.
Perfmon needs to do something actively to disable them.

Actually on x86 they usually stop in true idle state in hardware, but 
they don't do in polling mode and it sometimes seems to depend on
the firmware.  So it mostly would be for idle=poll

But if you do walk clock time profiling exactly because they stop 
a profiler should account for this somehow. Otherwise the profiling time
doesn't add up to 100%

-Andi
