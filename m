Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945897AbWJSOCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945897AbWJSOCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945903AbWJSOCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:02:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945897AbWJSOCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:02:40 -0400
Subject: Re: 2.6 patch] fs/gfs2/ops_fstype.c:fill_super_meta(): fix NULL
	dereference
From: Steven Whitehouse <swhiteho@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061019132659.GO3502@stusta.de>
References: <20061019132659.GO3502@stusta.de>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 19 Oct 2006 15:09:22 +0100
Message-Id: <1161266962.27980.146.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 ... and this one is pushed to the GFS2 git tree too. Thanks for the
patches,

Steve.

On Thu, 2006-10-19 at 15:27 +0200, Adrian Bunk wrote:
> Don't dereference new->s_root when we do know it's NULL.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6/fs/gfs2/ops_fstype.c.old	2006-10-19 15:24:23.000000000 +0200
> +++ linux-2.6/fs/gfs2/ops_fstype.c	2006-10-19 15:24:32.000000000 +0200
> @@ -793,10 +793,10 @@ static int fill_super_meta(struct super_
>  	if (!new->s_root) {
>  		fs_err(sdp, "can't get root dentry\n");
>  		error = -ENOMEM;
>  		iput(inode);
> -	}
> -	new->s_root->d_op = &gfs2_dops;
> +	} else
> +		new->s_root->d_op = &gfs2_dops;
>  
>  	return error;
>  }
>  
> 

