Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUFDAXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUFDAXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUFDAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:23:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265007AbUFDAXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:23:08 -0400
Date: Thu, 3 Jun 2004 17:25:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: pj@sgi.com, linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, mikpe@csd.uu.se,
       nickpiggin@yahoo.com.au, rusty@rustcorp.com.au, Simon.Derr@bull.net,
       wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603172547.2880eeb0.akpm@osdl.org>
In-Reply-To: <20040603170725.4b3f8b34.akpm@osdl.org>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040603170725.4b3f8b34.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> > +typedef struct { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
> >
> 
> We avoided doing this because in some situations the compiler will not pass
> such a cpumask_t in a register, ever.  An efficiency problem on sparc64,
> apparently.

Although for some reason your patches shrink my sparc64 build from

	   text    data     bss     dec     hex filename
	3508730  895000  302656 4706386  47d052 vmlinux
to	3507586  895080  302656 4705322  47cc2a vmlinux

so we can probably evade the wrath-of-davem.

