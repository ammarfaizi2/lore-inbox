Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWEISOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWEISOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWEISOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:14:53 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:62379 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750878AbWEISOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:14:52 -0400
Date: Tue, 9 May 2006 19:14:44 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
Message-ID: <20060509181444.GP7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085155.177937000@sous-sol.org> <4460AC12.3000006@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4460AC12.3000006@mbligh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:49:54AM -0700, Martin J. Bligh wrote:
> >+static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
> >+{
> >+#define C(i) 
> >HYPERVISOR_update_descriptor(virt_to_machine(&get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i]), *(u64 *)&t->tls_array[i])
> >+	C(0); C(1); C(2);
> >+#undef C
> >+}
> 
> Please just expand this or make it a real function call (static inline),
> not a temporary macro ..

Yes, I've added an inline function to do a single descriptor.

Should I change the non-xen case as well?  It was the inspiration
for this code ;-)

    christian

