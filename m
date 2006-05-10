Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWEJUXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWEJUXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWEJUXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:23:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1766 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932477AbWEJUXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:23:53 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling on Xen.
Date: Wed, 10 May 2006 22:23:48 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Chris Wright <chrisw@sous-sol.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085155.177937000@sous-sol.org> <20060509072139.GB4150@ucw.cz>
In-Reply-To: <20060509072139.GB4150@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605102223.48955.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 09:21, Pavel Machek wrote:
> Hi!
> 
> > +static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
> > +{
> > +#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
> > +	C(0); C(1); C(2);
> > +#undef C
> > +}
> 
> Why not use for loop here? gcc should be able to optimize it...

I don't think you can really blame the Xen people for that code - it's 
just the old code moved.

-Andi
