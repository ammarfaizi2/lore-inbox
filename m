Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWIAVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWIAVoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWIAVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:44:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750998AbWIAVob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:44:31 -0400
Date: Fri, 1 Sep 2006 14:44:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Generic infrastructure for acls
Message-Id: <20060901144423.aa306d36.akpm@osdl.org>
In-Reply-To: <20060901221457.803728153@winden.suse.de>
References: <20060901221421.968954146@winden.suse.de>
	<20060901221457.803728153@winden.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 00:14:22 +0200
Andreas Gruenbacher <agruen@suse.de> wrote:

> +generic_acl_list(struct inode *inode, struct generic_acl_operations *ops,
> +		 int type, char *list, size_t list_size)
> +{
> +	struct posix_acl *acl;
> +	const char *name;
> +	size_t size;
> +
> +	acl = ops->getacl(inode, type);
> +	if (!acl)
> +		return 0;
> +	posix_acl_release(acl);
> +
> +	switch(type) {
> +		case ACL_TYPE_ACCESS:
> +			name = POSIX_ACL_XATTR_ACCESS;
> +			break;
> +
> +		case ACL_TYPE_DEFAULT:
> +			name = POSIX_ACL_XATTR_DEFAULT;
> +			break;
> +
> +		default:
> +			return 0;
> +	}
> +	size = strlen(name) + 1;
> +	if (list && size <= list_size)
> +		memcpy(list, name, size);
> +	return size;
> +}

That's a clumsy-looking interface.  How is the caller to know that *list
got filled in?  By checking the generic_acl_list() return value against
`list_size'?

If so, shouldn't this be covered in the API description (when you write
it ;))?

Or should it be returning some error code in this case?

Or should we just strdup() the thing?

Or return `name' and let the caller worry about it?

-- 
VGER BF report: H 1.83187e-15
