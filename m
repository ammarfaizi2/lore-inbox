Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVGKOos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVGKOos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVGKOnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:43:25 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:4087 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261892AbVGKOmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:42:04 -0400
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: serue@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
In-Reply-To: <20050630195043.GE23538@serge.austin.ibm.com>
References: <20050630194458.GA23439@serge.austin.ibm.com>
	 <20050630195043.GE23538@serge.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 11 Jul 2005 10:40:28 -0400
Message-Id: <1121092828.12334.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 14:50 -0500, serue@us.ibm.com wrote:
> Adds the actual stacker LSM.
<snip>
> +static int stacker_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
> +{
> +	RETURN_ERROR_IF_ANY_ERROR(inode_getsecurity,inode_getsecurity(inode,name,buffer,size));
> +}
> +
> +static int stacker_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
> +{
> +	RETURN_ERROR_IF_ANY_ERROR(inode_setsecurity,inode_setsecurity(inode,name,value,size,flags));
> +}
> +
> +static int stacker_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
> +{
> +	RETURN_ERROR_IF_ANY_ERROR(inode_listsecurity,inode_listsecurity(inode,buffer, buffer_size));
> +}

These hooks pose a similar problem for stacking as with the
[gs]etprocattr hooks, although [gs]etsecurity have the benefit of
already taking a distinguishing name suffix (the part after the
security. prefix).  Note also that inode_getsecurity returns the number
of bytes used/required on success.

The proposed inode_init_security hook will likewise have an issue for
stacking.

-- 
Stephen Smalley
National Security Agency

