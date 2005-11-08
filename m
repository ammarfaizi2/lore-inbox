Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbVKHHbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVKHHbY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVKHHbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:31:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44928 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030198AbVKHHbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:31:24 -0500
Date: Tue, 8 Nov 2005 08:31:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 12/21] i386 Deprecate descriptor asm
Message-ID: <20051108073136.GD28201@elte.hu>
References: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080431.jA84Vdg5009909@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> +static inline unsigned long get_desc_base(struct desc_struct *desc)
> +{
> +	unsigned long base;
> +	struct desc_internal_struct *dint = desc_internal(desc);
> +	base = (dint->base0) | (dint->base1 << 16) | (dint->base2 << 24);
> +	return base;
> +}

these cleanups are very nice too. I only have minor style nits: e.g. the 
above is more readable as:

> +static inline unsigned long get_desc_base(struct desc_struct *desc)
> +{
> +	struct desc_internal_struct *dint = desc_internal(desc);
> +
> +	return dint->base0 | (dint->base1 << 16) | (dint->base2 << 24);
> +}

same for the remaining inline files.

also, these should quite likely be non-inlined functions - leading to 
even more compact code. I'd suggest to put them into a new 
arch/i386/kernel/segments.c file.

	Ingo
