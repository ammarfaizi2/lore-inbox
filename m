Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVEIRot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVEIRot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVEIRoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:44:23 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:63151 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261456AbVEIRnz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:43:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E9QndqcUodDtGSOFhP2hBobdE2VWsLH670agehEYleZWQo7tWv5jZxvU1Tt0kJWNUtFB7wjKQbIkkKDAqHP2s7GTEpWDLvIbhQeyWckF5OyTSOYuFfkPrm1ndRfzYT2VQsWWq0p76hyog5xCXifPStsbo4NYIwgbVtLtuWBVSa4=
Message-ID: <2cd57c90050509104363efed0e@mail.gmail.com>
Date: Tue, 10 May 2005 01:43:50 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Robert Love <rml@novell.com>
Subject: Re: [patch] inotify.
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <1115654707.6734.134.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115654707.6734.134.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Robert Love <rml@novell.com> wrote:
> Below is the latest revision of inotify, against 2.6.12-rc4.
> 
> The only functional changes from the last release is a compile warning
> fix for !CONFIG_INOTIFY.

Here's another compile warning, also in the current -mm tree.

> diff -urN linux-2.6.12-rc4/fs/namei.c linux/fs/namei.c
> --- linux-2.6.12-rc4/fs/namei.c 2005-05-09 11:52:48.000000000 -0400
> +++ linux/fs/namei.c    2005-05-09 11:58:52.000000000 -0400

...

> @@ -2172,18 +2174,18 @@
>         DQUOT_INIT(old_dir);
>         DQUOT_INIT(new_dir);
> 
> +       old_name = fsnotify_oldname_init(old_dentry->d_name.name);
> +

prodigy:/home/coywolf/2.6.12-rc3-mm3-cy# make fs/namei.o
  CC      fs/namei.o
/home/coywolf/2.6.12-rc3-mm3-cy/fs/namei.c: In function `vfs_rename':
/home/coywolf/2.6.12-rc3-mm3-cy/fs/namei.c:2177: warning: passing arg
1 of `fsnotify_oldname_init' from incompatible pointer type


The problem lies in const char *name V.S. const unsigned char *name.


-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
