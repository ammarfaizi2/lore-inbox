Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWF2QBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWF2QBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWF2QBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:01:49 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:36793 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S1750812AbWF2QBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:01:48 -0400
Subject: Re: NFS and partitioned md
From: Martin Filip <bugtraq@smoula.net>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17571.19699.980491.970386@cse.unsw.edu.au>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	 <17568.31894.207153.563590@cse.unsw.edu.au>
	 <1151432312.11996.32.camel@reaver.netbox-in.cz>
	 <17571.19699.980491.970386@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-2
Date: Thu, 29 Jun 2006 18:01:11 +0200
Message-Id: <1151596871.16253.2.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Neil Brown pí¹e v Èt 29. 06. 2006 v 13:45 +1000:
> Exactly.  4105 > 256.  Such devices need a different format filehandle
> which didn't work until very recently due to a bug (obviously no-one
> tried it until recently).
> 
> The patch below fixes the kernel so that this will work.

I'm affraid the problem will be yet somewhere else. I've tried this
patch and the result is totaly same :(


> -----------------------------
> Fixing missing 'expkey' support for fsid type 3
> 
> From: Frank Filz <ffilzlnx@us.ibm.com>
> 
> Type '3' is used for the fsid in filehandles when the device number
> of the device holding the filesystem has more than 8 bits in either
> major or minor.
> Unfortunately expkey_parse doesn't recognise type 3.  Fix this.
> 
> (Slighty modified from Frank's original)
> 
> Signed-Off-By: Frank Filz <ffilzlnx@us.ibm.com>
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./fs/nfsd/export.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
> --- .prev/fs/nfsd/export.c	2006-06-29 11:07:21.000000000 +1000
> +++ ./fs/nfsd/export.c	2006-06-27 18:27:49.000000000 +1000
> @@ -126,7 +126,7 @@ static int expkey_parse(struct cache_det
>  	if (*ep)
>  		goto out;
>  	dprintk("found fsidtype %d\n", fsidtype);
> -	if (fsidtype > 2)
> +	if (key_len(fsidtype)==0) /* invalid type */
>  		goto out;
>  	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
>  		goto out;
> -

-- 
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net
www: http://www.smoula.net

 _______________________________________ 
< BOFH Excuse #20: divide-by-zero error >
 --------------------------------------- 
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

