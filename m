Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932934AbWK3Jfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWK3Jfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933066AbWK3Jfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:35:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:15305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932934AbWK3Jfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:35:46 -0500
Date: Thu, 30 Nov 2006 01:35:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH -mm] x86_64 UP needs smp_call_function_single
Message-Id: <20061130013531.6bb73f53.akpm@osdl.org>
In-Reply-To: <1164878540.11036.29.camel@earth>
References: <20061129170111.a0ffb3f4.randy.dunlap@oracle.com>
	<20061129174558.3dfd13df.akpm@osdl.org>
	<1164870000.11036.23.camel@earth>
	<20061129235407.7295c31d.akpm@osdl.org>
	<1164878540.11036.29.camel@earth>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 10:22:20 +0100
Ingo Molnar <mingo@redhat.com> wrote:

> > 
> > btw, does anyone know why the SMP versions of this function use
> > spin_lock_bh(&call_lock)?
> 
> that makes no sense (neither the get_cpu()/put_cpu() gymnastics) if this
> is called with irqs disabled all the time.

smp_call_function_single() must be called with local interrupts ENabled.

But why isn't it just spin_lock()?

<looks>

Eric simply copied that code from ia64, which added the spin_lock_bh()
in 2.4.8.  Ho-hum.
