Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWHMUGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWHMUGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWHMUGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:06:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:27359 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751397AbWHMUGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:06:50 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: fastboot@osdl.org, Jan Kratochvil <lace@jankratochvil.net>,
       Horms <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
       dzickus@redhat.com
Subject: Re: [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060811212522.GF18865@redhat.com>
	<m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Aug 2006 22:06:19 +0200
In-Reply-To: <m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
Message-ID: <p73psf49z9g.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> Do you know what code had problems having _PAGE_NX set.
> What are we doing with early_ioremap the requires execute
> permissions.  It doesn't sound right that we would need
> this.

The early EM64T CPUs didn't support NX and would GPF when
they hit the bit. That is why you always need to mask 
with __supported_pte_mask when using _PAGE_NX.

-Andi
