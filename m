Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUGHAQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUGHAQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 20:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUGHAQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 20:16:07 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:46861 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S265697AbUGHAQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 20:16:04 -0400
Date: Thu, 8 Jul 2004 08:27:26 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Oleg Drokin <green@clusterfs.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, braam@clusterfs.com
Subject: Re: [3/9] Lustre VFS patches for 2.6
In-Reply-To: <20040707124732.GA25917@clusterfs.com>
Message-ID: <Pine.LNX.4.58.0407080821140.30806@wombat.indigo.net.au>
References: <20040707124732.GA25917@clusterfs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2004, Oleg Drokin wrote:

> Index: linus-2.6.7-bk-latest/fs/exec.c
> ===================================================================
> --- linus-2.6.7-bk-latest.orig/fs/exec.c	2004-07-07 10:56:13.395545976 +0300
> +++ linus-2.6.7-bk-latest/fs/exec.c	2004-07-07 11:38:42.869966952 +0300
> @@ -121,8 +121,9 @@
>  	struct nameidata nd;
>  	int error;
>  
> +	intent_init(&nd.intent.open, IT_OPEN);
>  	nd.intent.open.flags = FMODE_READ;
> -	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
> +	error = user_path_walk_it(library, &nd);
>  	if (error)
>  		goto out;
>

I don't have source available right now (I'll check later) but droping 
LOOKUP_FOLLOW might break autofs4.

Ian

