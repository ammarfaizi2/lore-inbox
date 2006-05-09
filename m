Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWEILP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWEILP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWEILP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:15:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43242 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751720AbWEILP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:15:28 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 16/35] subarch support for interrupt and exception gates
Date: Tue, 9 May 2006 13:09:49 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.441800000@sous-sol.org>
In-Reply-To: <20060509085154.441800000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091309.49631.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*
> + * This needs to use 'idt_table' rather than 'idt', and
> + * thus use the _nonmapped_ version of the IDT, as the
> + * Pentium F0 0F bugfix can have resulted in the mapped
> + * IDT being write-protected.
> + */
> +void set_intr_gate(unsigned int n, void *addr)
> +{
> +	_set_gate(idt_table+n,14,0,addr,__KERNEL_CS);
> +}

No need to duplicate the various set_*_gate functions into the subarchs.


> +static void __init set_task_gate(unsigned int n, unsigned int gdt_entry)
> +{
> +	/* _set_gate(n, 5, 0, 0, (gdt_entry<<3)); */
> +}

Looks weird, but can be handled in the low level function.

-Andi
