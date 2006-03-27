Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWC0H2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWC0H2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWC0H2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:28:48 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:2512 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750766AbWC0H2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:28:48 -0500
Date: Mon, 27 Mar 2006 02:28:45 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>,
       Dustin Kirkland <dustin.kirkland@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] Capture selinux subject/object context information.
In-Reply-To: <200603251818.k2PIINcX027696@hera.kernel.org>
Message-ID: <Pine.LNX.4.64.0603270223540.2351@excalibur.intercode>
References: <200603251818.k2PIINcX027696@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006, Linux Kernel Mailing List wrote:

> commit 8c8570fb8feef2bc166bee75a85748b25cda22d9
> tree ed783d405ea9d5f3d3ccc57fb56c7b7cb2cdfb82
> parent c8edc80c8b8c397c53f4f659a05b9ea6208029bf
> author Dustin Kirkland <dustin.kirkland@us.ibm.com> Thu, 03 Nov 2005 17:15:16 +0000
> committer Al Viro <viro@zeniv.linux.org.uk> Tue, 21 Mar 2006 00:08:54 -0500
> 
> [PATCH] Capture selinux subject/object context information.
> 

> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -869,6 +869,11 @@ struct swap_info_struct;
>   *	@ipcp contains the kernel IPC permission structure
>   *	@flag contains the desired (requested) permission set
>   *	Return 0 if permission is granted.
> + * @ipc_getsecurity:
> + *      Copy the security label associated with the ipc object into
> + *      @buffer.  @buffer may be NULL to request the size of the buffer 
> + *      required.  @size indicates the size of @buffer in bytes. Return 
> + *      number of bytes used/required on success.

I may have missed it, but was this change discussed on the LSM list?

> +	char *(*inode_xattr_getsuffix) (void);

Not documented?

>  static int selinux_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size, int err)

> -	if (err > 0) {
> -		if ((len == err) && !(memcmp(context, buffer, len))) {
> -			/* Don't need to canonicalize value */
> -			rc = err;
> -			goto out_free;
> -		}
> -		memset(buffer, 0, size);
> -	}

Where did this functionality go?



- James
-- 
James Morris
<jmorris@namei.org>
