Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVADXDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVADXDA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVADXB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:01:57 -0500
Received: from [213.85.13.118] ([213.85.13.118]:6276 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262397AbVADW7X (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 4 Jan 2005 17:59:23 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
References: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Wed, 05 Jan 2005 01:59:07 +0300
In-Reply-To: <20050104214833.GA3420@IBM-BWN8ZTBWA01.austin.ibm.com> (Serge
 E. Hallyn's message of "Tue, 4 Jan 2005 15:48:33 -0600")
Message-ID: <m1u0pwls1w.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> The attached patch introduces a __vm_enough_memory function in
> security/security.c which is used by cap_vm_enough_memory,
> dummy_vm_enough_memory, and selinux_vm_enough_memory.  This has
> been discussed on the lsm mailing list.
>
> Are there any objections to or comments on this patch?
>
> thanks,
> -serge
>
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
>

[...]

> -
> -	return -ENOMEM;
> +	return __vm_enough_memory(pages,
> +			(cap_capable(current, CAP_SYS_ADMIN) == 0));

I don't think that CAP_SYS_ADMIN is proper capability for this:
CAP_SYS_ADMIN is catch-all that should be used only when no other
capability covers action being performed. In this case CAP_SYS_RESOURCE
seems to be a better fit, after all __vm_enough_memory() controls access
to a resource, plus file systems use CAP_SYS_RESOURCE to protect disk
blocks reserved for "root".

>  }

[...]

Nikita.
