Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVIUDqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVIUDqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVIUDqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:46:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57048 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750976AbVIUDqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:46:51 -0400
Date: Wed, 21 Sep 2005 04:46:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>,
       Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] HPPFS: fix access to ppos and file->f_pos
Message-ID: <20050921034649.GX7992@ftp.linux.org.uk>
References: <20050918140951.31461.78736.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918140951.31461.78736.stgit@zion.home.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 04:09:51PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
>  static ssize_t read_proc(struct file *file, char *buf, ssize_t count,
>  			 loff_t *ppos, int is_user)
>  {
> @@ -228,17 +237,21 @@ static ssize_t read_proc(struct file *fi
>  	if (read == NULL)
>  		return -EINVAL;
>  
> +	WARN_ON(is_user != (ppos != NULL));

Eww....  Why not pass the right ppos in all cases?
