Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTFJTKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTFJTJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:09:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:37858 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261936AbTFJTHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:07:31 -0400
Date: Tue, 10 Jun 2003 12:22:00 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Jon Miles <jon@cybah.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.4.18 Call Trace: [link_path_walk+889/2008]	[path_walk+26/28] [open_namei+131/1596] [filp_open+59/92] [sys_open+54/204]	[system_call+51/56]
Message-ID: <46010000.1055272920@w-hlinder>
In-Reply-To: <1055267308.18284.260.camel@fusion.local>
References: <1055267308.18284.260.camel@fusion.local>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, June 10, 2003 06:48:29 PM +0100 Jon Miles <jon@cybah.co.uk> wrote:

> I'm not sure if I should be sending an oops from a Debian 2.4.18 kernel
> or not? ... this may be useful. I'm not subscribed to the list.
> 
> kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000081
> kernel: Call Trace: [link_path_walk+889/2008] [path_walk+26/28] [open_namei+131/1596] [filp_open+59/92] [sys_open+54/204]
> 
> These patches were applied:
> 
> * NFS client seekdir patch
>   http://www.fys.uio.no/~trondmy/src/

How well have the changes to link_path_walk() included in the 2.4.18 patches
listed above been tested? Has Al Viro reviewed them? They look suspect to me
as they are in the function causing the problem:

> +return_reval:
> +		/*
> +		 * We bypassed the ordinary revalidation routines.
> +		 * Check the cached dentry for staleness.
> +		 */
> +		dentry = nd->dentry;
> +		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
> +			err = -ESTALE;
> +			if (!dentry->d_op->d_revalidate(dentry, 0)) {
> +				d_invalidate(dentry);
> +				break;
> +			}
> +		}

Just my $0.02

Hanna



