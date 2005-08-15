Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVHOEJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVHOEJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 00:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVHOEJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 00:09:03 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:43326 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S1750712AbVHOEJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 00:09:03 -0400
Message-ID: <430014EA.4030404@google.com>
Date: Sun, 14 Aug 2005 21:07:06 -0700
From: Mike Waychison <mikew@google.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: coywolf@sosdg.org
CC: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] unexport __mntput()
References: <20050815015357.GA16778@everest.sosdg.org>
In-Reply-To: <20050815015357.GA16778@everest.sosdg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hello,
> 
> Unexport __mntput() was talked about two months ago. http://lkml.org/lkml/2005/6/9/69
> Modules should not call __mntput() directly. If autofs or nfsd does that, it's
>  being wrong.

I think you missed the point in the last discussion.  __mntput is called 
from mntput(), which autofs and nfsd call.  Their use is correct given 
what they do:

Autofs 3 and 4 use it for walking the vfsmount tree and determining 
if/when a mountpoint is ready to expire.

Nfsd uses it to serve up nfs exports that don't cross mountpoints (or 
do, if "crossmnt" is specified in /etc/exports.

Thanks,

Mike Waychison

> 
> 		Coywolf
> 
> 
> Signed-off-by: Coywolf Qi Hunt <coywolf@sosdg.org>
> --- 2.6.13-rc6/fs/namespace.c~unexport-__mntput	2005-08-12 08:21:22.000000000 -0500
> +++ 2.6.13-rc6/fs/namespace.c	2005-08-14 20:32:01.000000000 -0500
> @@ -180,8 +180,6 @@
>  	deactivate_super(sb);
>  }
>  
> -EXPORT_SYMBOL(__mntput);
> -
>  /* iterator */
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {

