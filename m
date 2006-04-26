Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWDZVkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWDZVkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWDZVkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:40:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:42117 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964892AbWDZVkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:40:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PDJtRtzY2Z9yOYsfV8+s/WcS/9D8zXEyVIpqwsNd1UsAMPjxhBnbS+vnPGe7f0WeIbWw2cEFMGMDHmYv54MTDdB/QgrSjUA/7jNIPQmuiH3YzYfaNL/bUPEwM+zMJYbKcTQu3z/d2DHQOjM9xs/b2FK+J6cxmBQkPqK3HvVow4w=
Message-ID: <a4403ff60604261440u22b7e4c9k5be1a14e2f41e1e6@mail.gmail.com>
Date: Wed, 26 Apr 2006 15:40:11 -0600
From: "David Wilk" <davidwilk@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
Cc: "Chris Wright" <chrisw@sous-sol.org>, "Greg KH" <greg@kroah.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <p73fyk09ayc.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
	 <Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com>
	 <a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com>
	 <20060421192743.GH3061@sorel.sous-sol.org>
	 <a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com>
	 <Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com>
	 <a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com>
	 <a4403ff60604251108x7ed6d4e3q10cb3597ea27876c@mail.gmail.com>
	 <p73fyk09ayc.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In defense of having that option available, this was not a case where
the user was deliberately trying to set that option, but rather that
it somehow got set accidentally (still a bit of a mystery as I was not
modifying configs at the time).

On 26 Apr 2006 07:12:43 +0200, Andi Kleen <ak@suse.de> wrote:
> "David Wilk" <davidwilk@gmail.com> writes:
>
> > Ok, I think I need to apologize to everyone here.  I have found the
> > problem, and it is not with your patch, Hugh.  For some reason, the
> > config for my 2.6.16.7 source tree had a 1G/3G user/kernel split
> > configured.  This is very bizaar as I copy my .config from tree to
> > tree to avoid any changes in the configuration of my test kernels.
>
> This just shows this dreaded VMSPLIT config was a bad idea in the first
> place. There was a reason we didn't have it for such a long time (too
> many users get it wrong) and such occurrences just show again that this
> is still true.
>
> IMHO it would be best to just remove that option again and require
> users who really want to change this to patch their kernels again.
>
> At the very least it should be probably made dependent on CONFIG_EMBEDDED.
>
> -Andi
>
> Mark VMSPLIT EMBEDDED
>
> Too many users get it wrong.
>
> Signed-off-by: Andi Kleen <ak@suse.de>
>
> Index: linux/arch/i386/Kconfig
> ===================================================================
> --- linux.orig/arch/i386/Kconfig
> +++ linux/arch/i386/Kconfig
> @@ -466,7 +466,7 @@ endchoice
>
>  choice
>         depends on EXPERIMENTAL && !X86_PAE
> -       prompt "Memory split"
> +       prompt "Memory split" if EMBEDDED
>         default VMSPLIT_3G
>         help
>           Select the desired split between kernel and user memory.
>
