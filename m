Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbVJESlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbVJESlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJESlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:41:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37292 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030314AbVJESlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:41:13 -0400
Date: Wed, 5 Oct 2005 13:40:58 -0500
From: serue@us.ibm.com
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Keys: Add LSM hooks for key management
Message-ID: <20051005184058.GA12008@sergelap.austin.ibm.com>
References: <29942.1128529714@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29942.1128529714@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int key_task_permission(const key_ref_t key_ref,
> +			struct task_struct *context,
> +			key_perm_t perm)
> +{
> +	struct key *key;
> +	key_perm_t kperm;
> +	int ret;
> +
> +	/* let the security module have first say
> +	 * - it should return:
> +	 *	+ve to grant access
> +	 *	0   to deny access
> +	 *	-ve to fall back to normal permission checking
> +	 */
> +	ret = security_key_permission(key_ref, context, perm);
> +	if (ret >= 0)
> +		return ret;

Hmm, my only problem here is that this is nonstandard compared to
expected return values from other security_ authorization hooks.
Could this be switched to

	-ve : deny access (and return the error)
	0: grant access
	+ve: fall back to normal permission checking

Actually that's still nonstandard.  On the whole, LSM only
restricts, does not authorize, with capable() being the notable
exception.  Is there good reason to allow LSMs to fully authorize
in this case?

thanks,
-serge
