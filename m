Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWCOVe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWCOVe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWCOVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:34:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46551 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751499AbWCOVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:34:43 -0500
To: vgoyal@in.ibm.com
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<1142452665.3021.43.camel@laptopd505.fenrus.org>
	<C6CFDF8E-CE60-4FCD-AC17-72DC83E8521C@kernel.crashing.org>
	<m1ek13h3ej.fsf@ebiederm.dsl.xmission.com>
	<20060315203200.GB7465@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 13:58:00 -0700
In-Reply-To: <20060315203200.GB7465@in.ibm.com> (Vivek Goyal's message of
 "Wed, 15 Mar 2006 15:32:00 -0500")
Message-ID: <m1k6avfmsn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Few problems which I have noticed so far.
>
> - Many printk() warnings. Wherever start and end are being printed,
>   the format specifier being used is %lx. Needs to be changed to %Lx.

Sane, but we need to check the 64bit case as well.

> - Some folks save a pointer of type (unsigned long *) to start and end field
>   and then try to operate on it. This pointer type shall have to be changed
>   to something like u64*.
>
> 	unsigned long *port, *end, *tport, *tend;
> 	port = &dev->res.port_resource[idx].start;

Weird.

> - Some folks cast "start" to a pointer and then use it. Compiler gives warning.
>
> 	addr_reg = (void __iomem *) addr->start;

I'm not familiar enough with that part of the code off the top of my head
but that except for a few helper functions that kind of behavior should
be pretty much forbidden.

This feels like entering the guts of ugly barely working drivers at
the moment.

Eric

