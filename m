Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVBQXjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVBQXjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVBQXhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:37:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:24486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261218AbVBQXgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:36:19 -0500
Date: Thu, 17 Feb 2005 15:41:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] add umask parameter to procfs
Message-Id: <20050217154119.1f237921.akpm@osdl.org>
In-Reply-To: <20050217212859.GA24403@lsrfire.ath.cx>
References: <20050217212859.GA24403@lsrfire.ath.cx>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>
> Add proc.umask kernel parameter.  It can be used to restrict permissions
> on the numerical directories in the root of a proc filesystem, i.e. the
> directories containing process specific information.
> 
> E.g. add proc.umask=077 to your kernel command line and all users except
> root can only see their own process details (like command line
> parameters) with ps or top.  It can be useful to add a bit of privacy to
> multi-user servers.
> 
> The patch has been inspired by a similar feature in GrSecurity.
> 
> It could have also been implemented as a mount option to procfs, but at
> a higher cost and no apparent benefit -- changes to this umask are not
> supposed to happen very often.  Actually, the previous incarnation of
> this patch was implemented as a half-assed mount option, but I didn't
> know then how easy it is to add a kernel parameter.

The feature seems fairly obscure, although very simple.  Is anyone actually
likely to use this?

>  
> +static umode_t umask = 0;

a) I think the above should be called proc_umask.

b) You shouldn't initialise it.

c) When adding a kernel parameter you should update
   Documentation/kernel-parameters.txt
