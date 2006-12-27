Return-Path: <linux-kernel-owner+w=401wt.eu-S1754788AbWL0Vy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbWL0Vy7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbWL0Vy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:54:59 -0500
Received: from homer.mvista.com ([63.81.120.158]:46767 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbWL0Vy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:54:59 -0500
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227212555.GA14947@elte.hu>
References: <20061227193550.324850000@mvista.com>
	 <20061227212555.GA14947@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 13:54:15 -0800
Message-Id: <1167256455.14081.51.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 22:25 +0100, Ingo Molnar wrote:
> 
> +void pagefault_disable(void)
> +{
> +       current->pagefault_disabled++;
> +       /*
> +        * make sure to have issued the store before a pagefault
> +        * can hit.
> +        */
> +       barrier();
> +}
> +
> +void pagefault_enable(void)
> +{
> +       /*
> +        * make sure to issue those last loads/stores before enabling
> +        * the pagefault handler again.
> +        */
> +       barrier();
> +       current->pagefault_disabled--;
> +}
> +

I'll test it, but clearly I'm not going to get the same scheduling while
atomic using this change.. So may as well just put it in -rt and see if
something crashes ..

Daniel

