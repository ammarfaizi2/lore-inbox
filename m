Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWITL1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWITL1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 07:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWITL1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 07:27:46 -0400
Received: from mail.suse.de ([195.135.220.2]:29589 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750759AbWITL1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 07:27:45 -0400
To: rohitseth@google.com
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
From: Andi Kleen <ak@suse.de>
Date: 20 Sep 2006 13:27:33 +0200
In-Reply-To: <1158718722.29000.50.camel@galaxy.corp.google.com>
Message-ID: <p7364fikcbe.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohitseth@google.com> writes:
>  					 */
> +#ifdef CONFIG_CONTAINERS
> +	struct container_struct *ctn; /* Pointer to container, may be NULL */
> +#endif

I still don't think it's a good idea to add a pointer to struct page for this.
This means any kernel that enables the config would need to carry this significant
overhead, no matter if containers are used to not.

Better would be to store them in some other data structure that is only
allocated on demand or figure out a way to store them in the sometimes
not all used fields in struct page.

BTW your patchkit seems to be also in wrong order in that when 02 is applied
it won't compile.

-Andi
