Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWJCKhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWJCKhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWJCKhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:37:45 -0400
Received: from colin.muc.de ([193.149.48.1]:36624 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030283AbWJCKho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:37:44 -0400
Date: 3 Oct 2006 12:37:40 +0200
Date: Tue, 3 Oct 2006 12:37:40 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] Generic implemenatation of BUG.
Message-ID: <20061003103740.GB73786@muc.de>
References: <20061003010842.438670755@goop.org>> <20061003010930.971200285@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003010930.971200285@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because powerpc also records the function name, I added this to i386 and
> x86-64 for consistency.  Strictly speaking the function name is redundant with
> kallsyms, so perhaps it can be dropped from powerpc.

It would be good to change it to use kallsyms() then.

>  
>  #ifdef CONFIG_BUG
> +
> +#ifdef CONFIG_GENERIC_BUG
> +struct bug_entry {
> +	unsigned long	bug_addr;
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +	const char	*file;
> +	unsigned short	line;
> +#endif
> +	unsigned short	flags;

Can't you put the flags into the high bits of the line? I don't think
we have any 64kLOC files.

-Andi
