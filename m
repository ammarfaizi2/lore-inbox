Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754456AbWKMLJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbWKMLJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 06:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754458AbWKMLJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 06:09:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754459AbWKMLJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 06:09:23 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0611121732010.2724@raven.themaw.net> 
References: <Pine.LNX.4.64.0611121732010.2724@raven.themaw.net> 
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, "bibo,mao" <bibo.mao@intel.com>,
       David Howells <dhowells@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 - panic after mount fail 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 13 Nov 2006 11:07:13 +0000
Message-ID: <1292.1163416033@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> wrote:

> -	if (sbi->pipe) {
> -		fput(sbi->pipe);	/* Close the pipe */
> -		sbi->pipe = NULL;
> -	}
> +	fput(sbi->pipe);	/* Close the pipe */
> +	sbi->pipe = NULL;

Ummm...  Is that right?  fput() doesn't check its argument for a NULL pointer,
so the original code shouldn't hurt and should give you an extra bit of
defense.

Other than that, it looks reasonable.

David
